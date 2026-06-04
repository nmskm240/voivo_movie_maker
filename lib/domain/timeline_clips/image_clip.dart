import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/traits/asset.dart';
import 'package:voivo_movie_maker/utils/json_converters.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/traits/transform.dart';

part 'image_clip.g.dart';

@JsonSerializable(explicitToJson: true)
class ImageClip extends TimelineClip with WithAsset, WithTransform {
  ImageClip({
    required super.id,
    required super.startFrame,
    required this.assetId,
    super.durationFrames,
    ClipTransform? transform,
    Size? size,
  }) : transform = transform ?? ClipTransform(),
       size = size ?? const Size(640, 360);

  factory ImageClip.fromJson(Map<String, Object?> json) =>
      _$ImageClipFromJson(json);

  @override
  TimelineClipKind get kind => TimelineClipKind.image;
  @override
  final ClipTransform transform;
  @override
  AssetId assetId;
  @SizeJsonConverter()
  Size size;

  Map<String, Object?> toJson() =>_$ImageClipToJson(this);

  void update({AssetId? assetId, Size? size}) {
    this.assetId = assetId ?? this.assetId;
    this.size = size ?? this.size;
  }
}
