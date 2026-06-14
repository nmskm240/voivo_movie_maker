// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:voivo_movie_maker/domain/timeline_clips/components/base.dart';
import 'package:voivo_movie_maker/utils/json_converters.dart';

part 'text.g.dart';

@JsonSerializable()
class TextComponent extends ClipComponent {
  TextComponent({
    this.text = 'Text',
    this.fontFamily = 'Noto Sans CJK JP',
    this.size = 24,
    Color? color,
    super.id,
  }) : color = color ?? Colors.white;

  factory TextComponent.fromJson(Map<String, Object?> json) =>
      _$TextComponentFromJson(json);

  String text;
  String fontFamily;
  double size;
  @ColorJsonConverter()
  Color color;

  @override
  String get label => 'Text';

  void update({String? text, String? fontFamily, double? size, Color? color}) {
    this.text = text ?? this.text;
    this.fontFamily = fontFamily ?? this.fontFamily;
    this.size = size ?? this.size;
    this.color = color ?? this.color;
  }

  Map<String, Object?> toJson() => _$TextComponentToJson(this);
}
