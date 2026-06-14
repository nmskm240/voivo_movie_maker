// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:voivo_movie_maker/application/services/rendering/clip_painter.dart';
import 'package:voivo_movie_maker/application/services/rendering/project_paint_context.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';

class ImageClipPainter extends ClipPainter<ImageComponent> {
  const ImageClipPainter();

  @override
  void paint(
    Canvas canvas,
    TimelineClip clip,
    ImageComponent component,
    ProjectPaintContext context,
  ) {
    final image = context.resolveImage(component.assetId);
    if (image == null) {
      return;
    }

    final destination = Rect.fromCenter(
      center: Offset.zero,
      width: component.size.width,
      height: component.size.height,
    );
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      destination,
      Paint()..filterQuality = FilterQuality.medium,
    );
  }
}
