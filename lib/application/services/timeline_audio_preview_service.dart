import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:voivo_movie_maker/application/providers/playback_controller_provider.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';

final timelineAudioPreviewServiceProvider =
    Provider<TimelineAudioPreviewService>((ref) {
      final service = TimelineAudioPreviewService();
      ref.onDispose(service.dispose);
      return service;
    });

final class TimelineAudioPreviewService {
  final Map<TimelineClipId, _PlayingAudioClip> _playingByClipId = {};
  final Set<TimelineClipId> _startingClipIds = {};
  final Map<AssetId, Future<File>> _cachedFilesByAssetId = {};
  int _generation = 0;

  Future<void> sync({
    required PlaybackInfo playback,
    required Project project,
  }) async {
    if (playback is! PlaybackPlaying) {
      stopAll();
      return;
    }

    final activeClips = project.timeline.tracks
        .expand((track) => track.clips)
        .whereType<AudioClip>()
        .where((clip) => clip.isActiveAt(playback.currentFrame))
        .where((clip) => !clip.audio.muted)
        .toList(growable: false);
    final activeClipIds = activeClips.map((clip) => clip.id).toSet();

    for (final playing in _playingByClipId.entries.toList()) {
      if (!activeClipIds.contains(playing.key)) {
        unawaited(playing.value.stop());
        _playingByClipId.remove(playing.key);
      }
    }

    for (final clip in activeClips) {
      if (_playingByClipId.containsKey(clip.id) ||
          _startingClipIds.contains(clip.id)) {
        continue;
      }
      _startingClipIds.add(clip.id);
      try {
        await _startClip(
          project: project,
          clip: clip,
          frame: playback.currentFrame,
          generation: _generation,
        );
      } finally {
        _startingClipIds.remove(clip.id);
      }
    }
  }

  void stopAll() {
    for (final playing in _playingByClipId.values) {
      unawaited(playing.stop());
    }
    _playingByClipId.clear();
    _startingClipIds.clear();
    _generation++;
  }

  void dispose() {
    stopAll();
  }

  Future<void> _startClip({
    required Project project,
    required AudioClip clip,
    required int frame,
    required int generation,
  }) async {
    final file = await _fileForAsset(project, clip.assetId);
    final offset = Duration(
      microseconds: ((frame - clip.startFrame) / project.fps * 1000000).round(),
    );
    final player = Player();
    await player.setVolume(clip.audio.volume * 100);

    final playing = _PlayingAudioClip(player);
    if (generation != _generation) {
      unawaited(playing.stop());
      return;
    }

    _playingByClipId[clip.id] = playing;
    playing.onComplete = player.stream.completed.listen((completed) {
      if (!completed) {
        return;
      }
      if (identical(_playingByClipId[clip.id], playing)) {
        _playingByClipId.remove(clip.id);
      }
      unawaited(playing.stop());
    });
    try {
      await player.open(Media(file.path, start: offset));
    } catch (_) {
      if (identical(_playingByClipId[clip.id], playing)) {
        _playingByClipId.remove(clip.id);
      }
      unawaited(playing.stop());
      rethrow;
    }
  }

  Future<File> _fileForAsset(Project project, AssetId assetId) {
    return _cachedFilesByAssetId.putIfAbsent(assetId, () async {
      final asset = project.assets.findById(assetId);
      final directory = await getTemporaryDirectory();
      final file = File(
        p.join(directory.path, 'voivo_preview_${asset!.id.value}_${asset.name}'),
      );
      if (await file.exists()) {
        return file;
      }

      final sink = file.openWrite();
      // try {
      //   await for (final chunk in project.assetStorage.getBytes(asset)) {
      //     sink.add(chunk);
      //   }
      // } catch (_) {
      //   await sink.close();
      //   if (await file.exists()) {
      //     await file.delete();
      //   }
      //   rethrow;
      // }
      await sink.close();
      return file;
    });
  }
}

final class _PlayingAudioClip {
  _PlayingAudioClip(this.player);

  final Player player;
  StreamSubscription<bool>? onComplete;
  bool _stopped = false;

  Future<void> stop() async {
    if (_stopped) {
      return;
    }
    _stopped = true;
    await onComplete?.cancel();
    await player.stop();
    await player.dispose();
  }
}
