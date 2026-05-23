import 'dart:ui';

import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/traits/transform.dart';

class ImageClip extends TimelineClip with WithTransform {
  ImageClip({
    required super.id,
    required super.startFrame,
    super.durationFrames,
    ClipTransform? transform,
    Size? size,
    this.sourceUri,
  }) : transform = transform ?? ClipTransform(),
       size = size ?? const Size(640, 360);

  @override
  TimelineClipKind get kind => TimelineClipKind.image;
  @override
  final ClipTransform transform;
  Size size;
  Uri? sourceUri;

  void update({Size? size, Uri? sourceUri}) {
    this.size = size ?? this.size;
    this.sourceUri = sourceUri ?? this.sourceUri;
  }
}
