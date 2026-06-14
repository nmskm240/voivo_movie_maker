// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TimelineRuler extends StatelessWidget {
  const TimelineRuler({
    required this.fps,
    required this.pixelsPerFrame,
    super.key,
  });

  final int fps;
  final double pixelsPerFrame;

  static const height = 32.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: CustomPaint(painter: _TimeRulerPainter(fps, pixelsPerFrame)),
    );
  }
}

class TimelineRulerGestureArea extends StatefulWidget {
  const TimelineRulerGestureArea({
    required this.pixelsPerFrame,
    required this.onSeek,
    required this.onZoom,
    required this.child,
    super.key,
  });

  final double pixelsPerFrame;
  final ValueChanged<int> onSeek;
  final ValueChanged<double> onZoom;
  final Widget child;

  @override
  State<TimelineRulerGestureArea> createState() =>
      _TimelineRulerGestureAreaState();
}

class _TimelineRulerGestureAreaState extends State<TimelineRulerGestureArea> {
  final _gestureArenaTeam = GestureArenaTeam();
  var _pointerCount = 0;
  double? _scaleStartPixelsPerFrame;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _pointerCount++,
      onPointerUp: (_) => _pointerCount--,
      onPointerCancel: (_) => _pointerCount--,
      child: RawGestureDetector(
        behavior: HitTestBehavior.opaque,
        gestures: {
          HorizontalDragGestureRecognizer:
              GestureRecognizerFactoryWithHandlers<
                HorizontalDragGestureRecognizer
              >(
                () =>
                    HorizontalDragGestureRecognizer()..team = _gestureArenaTeam,
                (recognizer) {
                  recognizer.onUpdate = (details) {
                    if (_pointerCount >= 2) {
                      return;
                    }
                    widget.onSeek(
                      (details.localPosition.dx / widget.pixelsPerFrame)
                          .round(),
                    );
                  };
                },
              ),
          ScaleGestureRecognizer:
              GestureRecognizerFactoryWithHandlers<ScaleGestureRecognizer>(
                () => ScaleGestureRecognizer()..team = _gestureArenaTeam,
                (recognizer) {
                  recognizer
                    ..onStart = (_) {
                      _scaleStartPixelsPerFrame = widget.pixelsPerFrame;
                    }
                    ..onUpdate = (details) {
                      if (details.pointerCount < 2) {
                        return;
                      }
                      widget.onZoom(_scaleStartPixelsPerFrame! * details.scale);
                    }
                    ..onEnd = (_) {
                      _scaleStartPixelsPerFrame = null;
                    };
                },
              ),
        },
        child: widget.child,
      ),
    );
  }
}

class _TimeRulerPainter extends CustomPainter {
  const _TimeRulerPainter(this.fps, this.pixelsPerFrame);

  final int fps;
  final double pixelsPerFrame;

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xff3a4249)
      ..strokeWidth = 1;
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    final pixelsPerSecond = fps * pixelsPerFrame;
    if (pixelsPerSecond <= 0) {
      return;
    }
    final intervalSeconds = _intervalSeconds(pixelsPerSecond);

    for (
      var seconds = 0;
      seconds * fps * pixelsPerFrame <= size.width;
      seconds += intervalSeconds
    ) {
      final x = seconds * fps * pixelsPerFrame;
      canvas.drawLine(Offset(x, 24), Offset(x, size.height), linePaint);
      textPainter.text = TextSpan(
        text: _formatTime(seconds),
        style: const TextStyle(color: Color(0xffa9b3ba), fontSize: 11),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x + 6, 6));
    }
  }

  @override
  bool shouldRepaint(covariant _TimeRulerPainter oldDelegate) {
    return oldDelegate.fps != fps ||
        oldDelegate.pixelsPerFrame != pixelsPerFrame;
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:'
        '${remainingSeconds.toString().padLeft(2, '0')}';
  }

  int _intervalSeconds(double pixelsPerSecond) {
    const intervals = [1, 2, 5, 10, 30, 60, 120, 300, 600];
    return intervals.firstWhere(
      (seconds) => seconds * pixelsPerSecond >= 72,
      orElse: () => intervals.last,
    );
  }
}
