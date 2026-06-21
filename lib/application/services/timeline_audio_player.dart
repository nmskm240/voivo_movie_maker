// Dart imports:
import 'dart:typed_data';

// Package imports:
import 'package:media_kit/media_kit.dart';

// Project imports:
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';

typedef TimelineAudioAssetLoader =
    Future<Uint8List> Function(ProjectAsset asset);

final class TimelineAudioPlayer {
  TimelineAudioPlayer({Player? player}) : _player = player ?? Player();

  final Player _player;
  TimelineClipId? _clipId;
  AssetId? _assetId;
  var _disposed = false;
  var _syncVersion = 0;

  Future<void> sync({
    required Project project,
    required int currentFrame,
    required bool isPlaying,
    required TimelineAudioAssetLoader loadAudio,
  }) async {
    if (_disposed) {
      return;
    }
    final target = _findActiveAudio(project, currentFrame);
    if (!isPlaying || target == null) {
      await stop();
      return;
    }
    if (project.fps <= 0) {
      await stop();
      return;
    }
    final (:clip, :component, :asset) = target;
    if (_clipId == clip.id && _assetId == asset.id) {
      return;
    }

    final version = ++_syncVersion;
    final bytes = await loadAudio(asset);
    if (_disposed || version != _syncVersion) {
      return;
    }

    final media = await Media.memory(bytes);
    if (_disposed || version != _syncVersion) {
      return;
    }

    final offsetFrames = currentFrame - clip.startFrame;
    final offset = Duration(
      microseconds: (offsetFrames / project.fps * 1000000).round(),
    );
    await _player.open(media, play: true);
    await _player.seek(offset);
    await _player.setVolume(component.volume * 100);
    _clipId = clip.id;
    _assetId = asset.id;
  }

  Future<void> stop() async {
    _syncVersion++;
    _clipId = null;
    _assetId = null;
    await _player.stop();
  }

  Future<void> dispose() async {
    _disposed = true;
    await _player.dispose();
  }

  ({TimelineClip clip, AudioComponent component, ProjectAsset asset})?
  _findActiveAudio(Project project, int currentFrame) {
    for (final clip in project.timeline.getActiveClipsAt(currentFrame)) {
      final component = clip.component<AudioComponent>();
      if (component == null || component.muted) {
        continue;
      }
      final asset = project.assets.findById(component.assetId);
      if (asset == null || asset.kind != ProjectAssetKind.audio) {
        continue;
      }
      return (clip: clip, component: component, asset: asset);
    }
    return null;
  }
}
