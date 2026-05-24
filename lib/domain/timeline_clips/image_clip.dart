import 'dart:ui';

import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/traits/transform.dart';

class ImageClip extends TimelineClip with WithTransform {
  ImageClip({
    required super.id,
    required super.startFrame,
    required this.assetId,
    super.durationFrames,
    ClipTransform? transform,
    Size? size,
  }) : transform = transform ?? ClipTransform(),
       size = size ?? const Size(640, 360);

  @override
  TimelineClipKind get kind => TimelineClipKind.image;
  @override
  final ClipTransform transform;
  AssetId assetId;
  Size size;

  void update({AssetId? assetId, Size? size}) {
    this.assetId = assetId ?? this.assetId;
    this.size = size ?? this.size;
  }
}
