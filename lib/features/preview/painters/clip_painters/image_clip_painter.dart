import 'package:flutter/material.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/image_clip.dart';
import 'package:voivo_movie_maker/features/preview/painters/clip_painters/clip_painter.dart';
import 'package:voivo_movie_maker/features/preview/painters/preview_paint_context.dart';

class ImageClipPainter extends ClipPainter<ImageClip> {
  const ImageClipPainter();

  @override
  void paint(Canvas canvas, ImageClip clip, PreviewPaintContext context) {
    final rect = Rect.fromCenter(
      center: Offset.zero,
      width: clip.size.width,
      height: clip.size.height,
    );

    final image = context.imagesByAssetId[clip.assetId];
    if (image == null) {
      _paintMissingImage(canvas, rect);
      return;
    }

    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      rect,
      Paint()..filterQuality = FilterQuality.medium,
    );
  }

  void _paintMissingImage(Canvas canvas, Rect rect) {
    canvas.drawRect(rect, Paint()..color = const Color(0xff1f2937));
    canvas.drawRect(
      rect.deflate(2),
      Paint()
        ..color = const Color(0xff93c5fd)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4,
    );

    final mountainPaint = Paint()..color = const Color(0xff60a5fa);
    final mountainPath = Path()
      ..moveTo(rect.left + rect.width * 0.12, rect.bottom - rect.height * 0.18)
      ..lineTo(rect.left + rect.width * 0.36, rect.top + rect.height * 0.42)
      ..lineTo(rect.left + rect.width * 0.52, rect.bottom - rect.height * 0.18)
      ..close()
      ..moveTo(rect.left + rect.width * 0.42, rect.bottom - rect.height * 0.18)
      ..lineTo(rect.left + rect.width * 0.68, rect.top + rect.height * 0.32)
      ..lineTo(rect.left + rect.width * 0.9, rect.bottom - rect.height * 0.18)
      ..close();
    canvas.drawPath(mountainPath, mountainPaint);

    canvas.drawCircle(
      Offset(rect.right - rect.width * 0.18, rect.top + rect.height * 0.22),
      rect.shortestSide * 0.08,
      Paint()..color = const Color(0xfffde68a),
    );
  }
}
