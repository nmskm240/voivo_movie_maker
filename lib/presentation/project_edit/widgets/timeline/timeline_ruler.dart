// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TimelineRuler extends StatelessWidget {
  const TimelineRuler({required this.pixelsPerFrame, super.key});

  final double pixelsPerFrame;

  static const height = 32.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: CustomPaint(painter: _TimeRulerPainter(pixelsPerFrame)),
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
  const _TimeRulerPainter(this.pixelsPerFrame);

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

    for (var i = 0; i <= 8; i++) {
      final x = size.width * i / 8;
      canvas.drawLine(Offset(x, 24), Offset(x, size.height), linePaint);
      textPainter.text = TextSpan(
        text: '00:${(i * 5).toString().padLeft(2, '0')}',
        style: TextStyle(color: Color(0xffa9b3ba), fontSize: 11),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x + 6, 6));
    }
  }

  @override
  bool shouldRepaint(covariant _TimeRulerPainter oldDelegate) {
    return oldDelegate.pixelsPerFrame != pixelsPerFrame;
  }
}
