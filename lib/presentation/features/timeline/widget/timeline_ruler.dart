import 'package:flutter/material.dart';

class TimelineRuler extends StatelessWidget {
  const TimelineRuler({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _TimeRulerPainter());
  }
}

class _TimeRulerPainter extends CustomPainter {
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
        style: const TextStyle(color: Color(0xffa9b3ba), fontSize: 11),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x + 6, 6));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
