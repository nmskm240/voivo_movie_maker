import 'dart:ui';

import 'package:vector_math/vector_math.dart';

class PreviewPaintContext {
  const PreviewPaintContext({
    required this.projectSize,
  });

  final Size projectSize;

  Offset resolvePosition(Vector2 position) {
    return Offset(
      projectSize.width / 2 + position.x,
      projectSize.height / 2 + position.y,
    );
  }
}
