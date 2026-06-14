// Dart imports:
import 'dart:ui';

// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/components/base.dart';
import 'package:voivo_movie_maker/utils/json_converters.dart';

part 'image.g.dart';

@JsonSerializable(explicitToJson: true)
class ImageComponent extends ClipComponent {
  ImageComponent({required this.assetId, Size? size, super.id})
    : size = size ?? const Size(640, 360);

  factory ImageComponent.fromJson(Map<String, Object?> json) =>
      _$ImageComponentFromJson(json);

  AssetId assetId;
  @SizeJsonConverter()
  Size size;

  @override
  String get label => 'Image';

  void update({AssetId? assetId, Size? size}) {
    this.assetId = assetId ?? this.assetId;
    this.size = size ?? this.size;
  }

  Map<String, Object?> toJson() => _$ImageComponentToJson(this);
}
