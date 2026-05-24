import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';
import 'package:voivo_movie_maker/domain/json_converters.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/traits/transform.dart';

part 'image_clip.g.dart';

@JsonSerializable(explicitToJson: true)
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

  factory ImageClip.fromJson(Map<String, Object?> json) =>
      _$ImageClipFromJson(_normalizeJson(json));

  @override
  @JsonKey(includeFromJson: false)
  TimelineClipKind get kind => TimelineClipKind.image;
  @override
  final ClipTransform transform;
  @TimelineClipIdJsonConverter()
  @override
  TimelineClipId get id => super.id;
  @AssetIdJsonConverter()
  AssetId assetId;
  @SizeJsonConverter()
  Size size;

  Map<String, Object?> toJson() {
    return {..._$ImageClipToJson(this), 'kind': kind.name};
  }

  void update({AssetId? assetId, Size? size}) {
    this.assetId = assetId ?? this.assetId;
    this.size = size ?? this.size;
  }

  static Map<String, Object?> _normalizeJson(Map<String, Object?> json) {
    if (json.containsKey('size') ||
        !json.containsKey('width') ||
        !json.containsKey('height')) {
      return json;
    }
    return {
      ...json,
      'size': {'width': json['width'], 'height': json['height']},
    };
  }
}
