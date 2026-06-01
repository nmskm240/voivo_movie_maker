import 'package:flutter/material.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/text_clip.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/preview/painters/clip_painters/clip_painter.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/preview/painters/preview_paint_context.dart';

class TextClipPainter extends ClipPainter<TextClip> {
  const TextClipPainter();

  @override
  void paint(Canvas canvas, TextClip clip, PreviewPaintContext context) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: clip.text,
        style: TextStyle(
          color: clip.color,
          fontFamily: clip.fontFamily,
          fontSize: clip.size,
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
