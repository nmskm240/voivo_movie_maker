import 'package:flutter/material.dart';

import '../../models/timeline.dart';

class FfmpegCommandBuilder {
  const FfmpegCommandBuilder();

  String buildTextOnlyExportCommand({
    required Project project,
    required String assPath,
    required String outputPath,
  }) {
    final settings = project.settings;
    final durationSeconds =
        project.timeline.durationFrames / project.settings.fps;
    final color = _ffmpegColor(settings.backgroundColor);

    return [
      '-y',
      '-f',
      'lavfi',
      '-i',
      _quote(
        'color=c=$color:s=${settings.width}x${settings.height}:'
        'r=${settings.fps}:d=${durationSeconds.toStringAsFixed(3)}',
      ),
      '-vf',
      _quote('ass=${_escapeAssFilterPath(assPath)}'),
      '-an',
      '-c:v',
      'mpeg4',
      '-q:v',
      '4',
      '-pix_fmt',
      'yuv420p',
      _quote(outputPath),
    ].join(' ');
  }

  String _ffmpegColor(Color color) {
    final red = (color.r * 255).round();
    final green = (color.g * 255).round();
    final blue = (color.b * 255).round();

    return '0x'
        '${red.toRadixString(16).padLeft(2, '0').toUpperCase()}'
        '${green.toRadixString(16).padLeft(2, '0').toUpperCase()}'
        '${blue.toRadixString(16).padLeft(2, '0').toUpperCase()}';
  }

  String _escapeAssFilterPath(String path) {
    return path.replaceAll(r'\', r'\\').replaceAll(':', r'\:');
  }

  String _quote(String value) {
    return "'${value.replaceAll("'", r"'\''")}'";
  }
}
