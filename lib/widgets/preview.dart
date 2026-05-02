import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/timeline.dart';

class PreviewPane extends StatelessWidget {
  const PreviewPane({
    super.key,
    required this.project,
    required this.currentFrame,
  });

  final Project project;
  final int currentFrame;

  @override
  Widget build(BuildContext context) {
    final settings = project.settings;
    final activeTextClips = project.timeline.tracks
        .expand((track) => track.clips)
        .where((clip) => clip.isActiveAt(currentFrame))
        .toList();

    return Container(
      color: const Color(0xff0d0f11),
      padding: const EdgeInsets.all(18),
      child: Center(
        child: AspectRatio(
          aspectRatio: settings.width / settings.height,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: settings.backgroundColor,
              border: Border.all(color: const Color(0xff3c454d)),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final previewScale = constraints.maxWidth / settings.width;

                return Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
                    Positioned.fill(
                      child: CustomPaint(painter: _PreviewGridPainter()),
                    ),
                    if (activeTextClips.isEmpty)
                      const Center(
                        child: Text(
                          'No active clip',
                          style: TextStyle(color: Color(0xffa9b3ba)),
                        ),
                      ),
                    for (final clip in activeTextClips)
                      _PreviewTextClip(
                        clip: clip,
                        currentFrame: currentFrame,
                        previewScale: previewScale,
                      ),
                    Positioned(
                      left: 12,
                      bottom: 10,
                      child: _FrameBadge(
                        frame: currentFrame,
                        fps: settings.fps,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _PreviewTextClip extends StatelessWidget {
  const _PreviewTextClip({
    required this.clip,
    required this.currentFrame,
    required this.previewScale,
  });

  final TextClip clip;
  final int currentFrame;
  final double previewScale;

  @override
  Widget build(BuildContext context) {
    final transform = clip.transform;
    final alignment = Alignment(
      (transform.x * 2) - 1,
      (transform.y * 2) - 1,
    );
    final opacity = clip.opacityAt(currentFrame);

    return Positioned.fill(
      child: IgnorePointer(
        child: Align(
          alignment: alignment,
          child: Opacity(
            opacity: opacity,
            child: Transform.rotate(
              angle: transform.rotation * math.pi / 180,
              child: Transform.scale(
                scale: transform.scale,
                child: Text(
                  clip.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: clip.textColor,
                    fontFamily: clip.fontFamily,
                    fontSize: clip.fontSize * previewScale,
                    fontWeight: FontWeight.w700,
                    shadows: const [
                      Shadow(
                        color: Color(0xbb000000),
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FrameBadge extends StatelessWidget {
  const _FrameBadge({required this.frame, required this.fps});

  final int frame;
  final int fps;

  @override
  Widget build(BuildContext context) {
    final seconds = frame / fps;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xcc111416),
        border: Border.all(color: const Color(0xff3c454d)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          '${seconds.toStringAsFixed(2)}s / frame $frame',
          style: const TextStyle(
            color: Color(0xffdbe4e9),
            fontFeatures: [FontFeature.tabularFigures()],
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class _PreviewGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x173FFFFF)
      ..strokeWidth = 1;

    for (var x = 0.0; x <= size.width; x += size.width / 8) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var y = 0.0; y <= size.height; y += size.height / 6) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
