import 'package:flutter/material.dart';

sealed class ClipContent {
  const ClipContent();
}

class ClipTransform {
  const ClipTransform({
    required this.x,
    required this.y,
    required this.scale,
    required this.rotation,
    required this.opacity,
  });

  final double x;
  final double y;
  final double scale;
  final double rotation;
  final double opacity;
}

class TextContent extends ClipContent {
  const TextContent({
    required this.text,
    required this.fontFamily,
    required this.fontSize,
    required this.textColor,
  });

  final String text;
  final String fontFamily;
  final double fontSize;
  final Color textColor;
}
