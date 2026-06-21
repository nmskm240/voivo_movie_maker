// Dart imports:
import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

// Project imports:
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';

typedef TimelineVideoAssetLoader =
    Future<Uint8List> Function(ProjectAsset asset);

class TimelineVideoPreview extends StatefulWidget {
  const TimelineVideoPreview({
    required this.project,
    required this.clip,
    required this.component,
    required this.asset,
    required this.currentFrame,
    required this.isPlaying,
    required this.loadVideo,
    super.key,
  });

  final Project project;
  final TimelineClip clip;
  final VideoComponent component;
  final ProjectAsset asset;
  final int currentFrame;
  final bool isPlaying;
  final TimelineVideoAssetLoader loadVideo;

  @override
  State<TimelineVideoPreview> createState() => _TimelineVideoPreviewState();
}

class _TimelineVideoPreviewState extends State<TimelineVideoPreview> {
  late final Player _player;
  late final VideoController _controller;
  AssetId? _assetId;
  AssetId? _loadingAssetId;
  var _opened = false;
  var _playing = false;
  var _syncVersion = 0;
  int? _lastSyncedFrame;

  @override
  void initState() {
    super.initState();
    _player = Player();
    _controller = VideoController(_player);
    unawaited(_player.setVolume(0));
    unawaited(_sync());
  }

  @override
  void didUpdateWidget(covariant TimelineVideoPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    unawaited(_sync());
  }

  @override
  void dispose() {
    _syncVersion++;
    unawaited(_player.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Video(
        controller: _controller,
        fit: BoxFit.contain,
        fill: Colors.transparent,
        controls: NoVideoControls,
        wakelock: false,
        pauseUponEnteringBackgroundMode: false,
      ),
    );
  }

  Future<void> _sync() async {
    if (widget.project.fps <= 0) {
      return;
    }
    final offset = _offset();
    final assetChanged = _assetId != widget.asset.id;
    if (assetChanged || !_opened) {
      if (_loadingAssetId == widget.asset.id) {
        return;
      }
      final version = ++_syncVersion;
      _loadingAssetId = widget.asset.id;
      try {
        final bytes = await widget.loadVideo(widget.asset);
        if (!mounted || version != _syncVersion) {
          return;
        }
        final media = await Media.memory(bytes);
        if (!mounted || version != _syncVersion) {
          return;
        }
        await _player.open(media, play: false);
        await _player.setVolume(0);
        await _player.seek(offset);
        if (widget.isPlaying) {
          await _player.play();
        }
        _assetId = widget.asset.id;
        _opened = true;
        _playing = widget.isPlaying;
        _lastSyncedFrame = widget.currentFrame;
      } finally {
        if (version == _syncVersion) {
          _loadingAssetId = null;
        }
      }
      return;
    }

    if (widget.isPlaying) {
      if (!_playing || _seekJumped()) {
        await _player.seek(offset);
      }
      if (!_playing) {
        await _player.play();
      }
    } else {
      await _player.pause();
      if (_lastSyncedFrame != widget.currentFrame) {
        await _player.seek(offset);
      }
    }
    _playing = widget.isPlaying;
    _lastSyncedFrame = widget.currentFrame;
  }

  bool _seekJumped() {
    final last = _lastSyncedFrame;
    if (last == null) {
      return true;
    }
    return (widget.currentFrame - last).abs() >
        math.max(2, widget.project.fps ~/ 3);
  }

  Duration _offset() {
    final localFrame = widget.currentFrame - widget.clip.startFrame;
    return Duration(
      microseconds: (localFrame / widget.project.fps * 1000000).round(),
    );
  }
}
