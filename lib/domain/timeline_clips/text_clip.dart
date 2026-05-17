import 'package:flutter/material.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/traits/transform.dart';

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

  @override
  TimelineClipKind get kind => TimelineClipKind.text;
  @override
  final ClipTransform transform;
  String text;
  String fontFamily;
  double size;
  Color color;

  void update({String? text, String? fontFamily, double? size, Color? color}) {
    this.text = text ?? this.text;
    this.fontFamily = fontFamily ?? this.fontFamily;
    this.size = size ?? this.size;
    this.color = color ?? this.color;
  }
}
