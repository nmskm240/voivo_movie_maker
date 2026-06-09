import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/components/base.dart';
import 'package:voivo_movie_maker/utils/json_converters.dart';

part 'image.g.dart';

@JsonSerializable()
class ImageComponent implements ClipComponent {
  ImageComponent({Size? size}) : size = size ?? const Size(640, 360);

  factory ImageComponent.fromJson(Map<String, Object?> json) =>
      _$ImageComponentFromJson(json);

  @SizeJsonConverter()
  Size size;

  Map<String, Object?> toJson() => _$ImageComponentToJson(this);
}
