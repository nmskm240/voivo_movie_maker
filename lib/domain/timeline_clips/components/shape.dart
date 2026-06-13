// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:voivo_movie_maker/domain/timeline_clips/components/base.dart';
import 'package:voivo_movie_maker/utils/json_converters.dart';

part 'shape.g.dart';

enum ShapeType { rectangle, ellipse }

@JsonSerializable()
class ShapeComponent extends ClipComponent {
  ShapeComponent({
    this.shapeType = ShapeType.rectangle,
    Size? size,
    Color? color,
    super.id,
  }) : size = size ?? const Size(320, 180),
       color = color ?? Colors.blue;

  factory ShapeComponent.fromJson(Map<String, Object?> json) =>
      _$ShapeComponentFromJson(json);

  ShapeType shapeType;
  @SizeJsonConverter()
  Size size;
  @ColorJsonConverter()
  Color color;

  @override
  int get maxInstancesPerClip => 1;

  void update({ShapeType? shapeType, Size? size, Color? color}) {
    this.shapeType = shapeType ?? this.shapeType;
    this.size = size ?? this.size;
    this.color = color ?? this.color;
  }

  Map<String, Object?> toJson() => _$ShapeComponentToJson(this);
}
