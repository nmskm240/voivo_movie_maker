import 'package:flutter/material.dart';
import 'package:voivo_movie_maker/application/services/rendering/clip_painter.dart';
import 'package:voivo_movie_maker/application/services/rendering/project_paint_context.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';

class ShapeClipPainter extends ClipPainter<ShapeComponent> {
  const ShapeClipPainter();

  @override
  void paint(
    Canvas canvas,
    TimelineClip clip,
    ShapeComponent component,
    ProjectPaintContext context,
  ) {
    final rect = Rect.fromCenter(
      center: Offset.zero,
      width: component.size.width,
      height: component.size.height,
    );
    final paint = Paint()..color = component.color;

    switch (component.shapeType) {
      case ShapeType.rectangle:
        canvas.drawRect(rect, paint);
        return;
      case ShapeType.ellipse:
        canvas.drawOval(rect, paint);
        return;
    }
  }
}
