// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:voivo_movie_maker/application/services/rendering/clip_painter.dart';
import 'package:voivo_movie_maker/application/services/rendering/project_paint_context.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';

class TextClipPainter extends ClipPainter<TextComponent> {
  const TextClipPainter();

  @override
  void paint(
    Canvas canvas,
    TimelineClip clip,
    TextComponent component,
    ProjectPaintContext context,
  ) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: component.text,
        style: TextStyle(
          color: component.color,
          fontFamily: component.fontFamily,
          fontSize: component.size,
          fontWeight: FontWeight.w600,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(-textPainter.width / 2, -textPainter.height / 2),
    );
  }
}
