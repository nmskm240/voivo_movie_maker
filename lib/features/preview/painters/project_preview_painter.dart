import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/domain/timeline_track.dart';
import 'package:voivo_movie_maker/features/preview/painters/clip_painters/registry.dart';
import 'package:voivo_movie_maker/features/preview/painters/preview_paint_context.dart';

class ProjectPreviewPainter extends CustomPainter {
  ProjectPreviewPainter(this.project, this.currentFrame);
  final Project project;
  final int currentFrame;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = Colors.black);

    final scaleX = size.width / project.width;
    final scaleY = size.height / project.height;
    final context = PreviewPaintContext(
      projectSize: Size(project.width, project.height),
    );

    canvas.save();
    canvas.scale(scaleX, scaleY);
    for (final track in project.timeline.tracks) {
      _paintTrack(canvas, track, context);
    }
    canvas.restore();
  }

  void _paintTrack(
    Canvas canvas,
    TimelineTrack track,
    PreviewPaintContext context,
  ) {
    final clip = track.getActiveClipAt(currentFrame);
    if (clip == null) {
      return;
    }

    canvas.save();
    _paintClip(canvas, clip, context);
    canvas.restore();
  }

  void _paintClip(
    Canvas canvas,
    TimelineClip clip,
    PreviewPaintContext context,
  ) {
    canvas.save();
    if (clip is WithTransform) {
      _applyTransform(canvas, clip.transform, context);
    }

    clipPainterRegistry[clip.runtimeType]?.tryPaint(canvas, clip, context);
    canvas.restore();
  }

  void _applyTransform(
    Canvas canvas,
    ClipTransform transform,
    PreviewPaintContext context,
  ) {
    final position = context.resolvePosition(transform.position);

    canvas.translate(position.dx, position.dy);
    canvas.rotate(transform.rotation * math.pi / 180);
    canvas.scale(transform.scale.x, transform.scale.y);
  }

  @override
  bool shouldRepaint(covariant ProjectPreviewPainter oldDelegate) {
    return project.width != oldDelegate.project.width ||
        project.height != oldDelegate.project.height ||
        currentFrame != oldDelegate.currentFrame;
  }
}
