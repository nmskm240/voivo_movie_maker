import 'package:flutter/material.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';
import 'package:voivo_movie_maker/features/preview/painters/preview_paint_context.dart';

abstract class ClipPainter<T extends TimelineClip> {
  const ClipPainter();

  void paint(Canvas canvas, T clip, PreviewPaintContext context);

  bool tryPaint(Canvas canvas, TimelineClip clip, PreviewPaintContext context) {
    try {
      if (clip is T) {
        paint(canvas, clip, context);
        return true;
      }
    } catch (e) {
      debugPrint('Error painting clip of type ${clip.runtimeType}: $e');
      return false;
    }
    return false;
  }
}
