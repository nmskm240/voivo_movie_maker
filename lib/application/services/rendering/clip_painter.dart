import 'package:flutter/material.dart';
import 'package:voivo_movie_maker/application/services/rendering/project_paint_context.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';

abstract class ClipPainter<T extends ClipComponent> {
  const ClipPainter();

  void paint(
    Canvas canvas,
    TimelineClip clip,
    T component,
    ProjectPaintContext context,
  );

  bool tryPaint(
    Canvas canvas,
    TimelineClip clip,
    ClipComponent component,
    ProjectPaintContext context,
  ) {
    try {
      if (component is T) {
        paint(canvas, clip, component, context);
        return true;
      }
    } catch (error) {
      debugPrint('Error painting component ${component.runtimeType}: $error');
      return false;
    }
    return false;
  }
}
