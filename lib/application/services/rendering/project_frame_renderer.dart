// Dart imports:
import 'dart:math' as math;

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:voivo_movie_maker/application/services/rendering/clip_painter.dart';
import 'package:voivo_movie_maker/application/services/rendering/project_frame.dart';
import 'package:voivo_movie_maker/application/services/rendering/project_paint_context.dart';
import 'package:voivo_movie_maker/application/services/rendering/shape_clip_painter.dart';
import 'package:voivo_movie_maker/application/services/rendering/text_clip_painter.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';

class ProjectFrameRenderer {
  const ProjectFrameRenderer({
    this.clipPainters = const {
      ShapeComponent: ShapeClipPainter(),
      TextComponent: TextClipPainter(),
    },
  });

  final Map<Type, ClipPainter> clipPainters;

  void paint({
    required Canvas canvas,
    required Size outputSize,
    required ProjectFrame frame,
  }) {
    canvas.drawRect(Offset.zero & outputSize, Paint()..color = Colors.black);

    final context = ProjectPaintContext(projectSize: frame.projectSize);
    canvas.save();
    canvas.scale(
      outputSize.width / frame.projectSize.width,
      outputSize.height / frame.projectSize.height,
    );
    for (final clip in frame.clips) {
      _paintClip(canvas, clip, context);
    }
    canvas.restore();
  }

  void _paintClip(
    Canvas canvas,
    TimelineClip clip,
    ProjectPaintContext context,
  ) {
    canvas.save();
    final transform = clip.component<TransformComponent>();
    final position = transform == null
        ? Offset(context.projectSize.width / 2, context.projectSize.height / 2)
        : context.resolvePosition(transform.position);
    canvas.translate(position.dx, position.dy);
    if (transform != null) {
      canvas.rotate(transform.rotation * math.pi / 180);
      canvas.scale(transform.scale.x, transform.scale.y);
    }

    for (final component in clip.components) {
      clipPainters[component.runtimeType]?.tryPaint(
        canvas,
        clip,
        component,
        context,
      );
    }
    canvas.restore();
  }
}
