import 'package:flutter/material.dart';

class PreviewPane extends StatelessWidget {
  const PreviewPane({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff0d0f11),
      padding: const EdgeInsets.all(18),
      child: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: const Color(0xff20262b),
              border: Border.all(color: const Color(0xff3c454d)),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(painter: _PreviewGridPainter()),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.play_circle_outline,
                    size: 72,
                    color: Color(0x99ffffff),
                  ),
                ),
                Positioned(
                  left: 48,
                  bottom: 48,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    color: const Color(0xdd111416),
                    child: const Text(
                      'こんにちは、動画編集をはじめよう',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 48,
                  bottom: 40,
                  child: Container(
                    width: 92,
                    height: 150,
                    decoration: BoxDecoration(
                      color: const Color(0xff8fd6c8),
                      border: Border.all(color: Colors.white70, width: 2),
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      color: Color(0xff111416),
                      size: 72,
                    ),
                  ),
                ),
              ],
            ),
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
