// Dart imports:
import 'dart:ui';

// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:voivo_movie_maker/domain/timeline_clips/components/base.dart';
import 'package:voivo_movie_maker/utils/json_converters.dart';

part 'image.g.dart';

@JsonSerializable()
class ImageComponent extends ClipComponent {
  ImageComponent({Size? size, super.id}) : size = size ?? const Size(640, 360);

  factory ImageComponent.fromJson(Map<String, Object?> json) =>
      _$ImageComponentFromJson(json);

  @SizeJsonConverter()
  Size size;

  @override
  int get maxInstancesPerClip => 1;

  Map<String, Object?> toJson() => _$ImageComponentToJson(this);
}
