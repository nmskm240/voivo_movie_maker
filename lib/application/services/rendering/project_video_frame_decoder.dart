// Dart imports:
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

// Package imports:
import 'package:ffmpeg_kit_extended_flutter/ffmpeg_kit_extended_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

// Project imports:
import 'package:voivo_movie_maker/application/services/export/ffmpeg_command_builder.dart';

final class ProjectVideoFrameDecoder {
  const ProjectVideoFrameDecoder({
    this.temporaryDirectoryProvider = getTemporaryDirectory,
  });

  final Future<Directory> Function() temporaryDirectoryProvider;

  Future<Image> decodeFrame(
    Uint8List bytes, {
    required Duration position,
    String extension = '.mp4',
  }) async {
    await FFmpegKitExtended.initialize();
    final directory = await temporaryDirectoryProvider();
    final workingDirectory = await directory.createTemp('voivo_video_preview_');
    try {
      final input = File(path.join(workingDirectory.path, 'input$extension'));
      final output = File(path.join(workingDirectory.path, 'frame.png'));
      await input.writeAsBytes(bytes);
      final command = FfmpegCommandBuilder()
          .addFlag('-y')
          .addOption('-ss', _formatPosition(position))
          .addInput(input.path)
          .addOption('-frames:v', 1)
          .addOutput(output.path)
          .build();
      final session = await FFmpegKit.executeAsync(command);
      final returnCode = session.getReturnCode();
      if (!ReturnCode.isSuccess(returnCode) || !await output.exists()) {
        throw StateError(
          'Failed to decode video frame '
          '(code $returnCode): ${session.getLogs() ?? session.getOutput() ?? ''}',
        );
      }
      final pngBytes = await output.readAsBytes();
      return await _decodeImage(pngBytes);
    } finally {
      if (await workingDirectory.exists()) {
        await workingDirectory.delete(recursive: true);
      }
    }
  }

  String _formatPosition(Duration position) {
    final microseconds = position.inMicroseconds;
    final seconds = microseconds ~/ Duration.microsecondsPerSecond;
    final fraction = microseconds.remainder(Duration.microsecondsPerSecond);
    return '$seconds.${fraction.toString().padLeft(6, '0')}';
  }

  Future<Image> _decodeImage(Uint8List bytes) {
    final completer = Completer<Image>();
    decodeImageFromList(bytes, completer.complete);
    return completer.future;
  }
}
