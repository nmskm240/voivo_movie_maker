import 'dart:ui';

import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/audio_clip.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/image_clip.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/text_clip.dart';

class ClipFactory {
  static TimelineClip create(
    TimelineClipKind kind,
    int startFrame, {
    AssetId? assetId,
    Size? size,
  }) {
    final id = TimelineClipId.create();
    return switch (kind) {
      TimelineClipKind.text => TextClip("", id: id, startFrame: startFrame),
      TimelineClipKind.image => ImageClip(
        id: id,
        startFrame: startFrame,
        assetId: assetId ?? (throw ArgumentError.notNull('assetId')),
        size: size,
      ),
      TimelineClipKind.audio => AudioClip(
        id: id,
        startFrame: startFrame,
        assetId: assetId ?? (throw ArgumentError.notNull('assetId')),
      ),
    };
  }
}
