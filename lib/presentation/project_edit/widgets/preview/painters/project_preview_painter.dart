import 'package:flutter/material.dart';
import 'package:voivo_movie_maker/application/services/rendering/project_frame.dart';
import 'package:voivo_movie_maker/application/services/rendering/project_frame_renderer.dart';

class ProjectPreviewPainter extends CustomPainter {
  ProjectPreviewPainter(
    this.frame,
    this.revision, {
    this.renderer = const ProjectFrameRenderer(),
  });

  final ProjectFrame frame;
  final int revision;
  final ProjectFrameRenderer renderer;

  @override
  void paint(Canvas canvas, Size size) {
    renderer.paint(canvas: canvas, outputSize: size, frame: frame);
  }

  @override
  bool shouldRepaint(covariant ProjectPreviewPainter oldDelegate) {
    return frame.projectSize != oldDelegate.frame.projectSize ||
        frame.frameNumber != oldDelegate.frame.frameNumber ||
        revision != oldDelegate.revision;
  }
}
