import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:voivo_movie_maker/domain/json_converters.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/traits/transform.dart';

part 'text_clip.g.dart';

@JsonSerializable(explicitToJson: true)
class TextClip extends TimelineClip with WithTransform {
  TextClip(
    this.text, {
    required super.id,
    required super.startFrame,
    super.durationFrames,
    ClipTransform? transform,
    this.fontFamily = "Noto Sans CJK JP",
    this.size = 24,
    Color? color,
  }) : transform = transform ?? ClipTransform(),
       color = color ?? Colors.white;

  factory TextClip.fromJson(Map<String, Object?> json) =>
      _$TextClipFromJson(json);

  @override
  @JsonKey(includeFromJson: false)
  TimelineClipKind get kind => TimelineClipKind.text;
  @override
  final ClipTransform transform;
  @TimelineClipIdJsonConverter()
  @override
  TimelineClipId get id => super.id;
  String text;
  String fontFamily;
  double size;
  @ColorJsonConverter()
  Color color;

  Map<String, Object?> toJson() {
    return {..._$TextClipToJson(this), 'kind': kind.name};
  }

  void update({String? text, String? fontFamily, double? size, Color? color}) {
    this.text = text ?? this.text;
    this.fontFamily = fontFamily ?? this.fontFamily;
    this.size = size ?? this.size;
    this.color = color ?? this.color;
  }
}
