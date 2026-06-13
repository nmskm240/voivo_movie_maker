import 'dart:io';

import 'package:ffmpeg_kit_extended_flutter/ffmpeg_kit_extended_flutter.dart';
import 'package:voivo_movie_maker/domain/project.dart';

import 'export_result.dart';
import 'export_operation.dart';
import 'ffmpeg_command_builder.dart';
import 'ffmpeg_frame_pipe.dart';
import 'project_frame_stream_writer.dart';

class FfmpegProjectEncoder {
  const FfmpegProjectEncoder({
    this.frameStreamWriter = const ProjectFrameStreamWriter(),
  });

  final ProjectFrameStreamWriter frameStreamWriter;

  Future<ExportResult> encode(
    Project project,
    String outputPath, {
    ExportOperation? operation,
  }) async {
    operation?.markStarted();
    operation?.throwIfCancelled();
    await FFmpegKitExtended.initialize();
    operation?.throwIfCancelled();

    final framePipe = await FfmpegFramePipe.create();
    try {
      final command = _buildCommand(project, framePipe.path, outputPath);
      final session = FFmpegKit.createSession(command);
      operation?.attachCancel(session.cancel);
      final sessionFuture = session.executeAsync();

      Object? streamError;
      StackTrace? streamStackTrace;
      try {
        await frameStreamWriter.write(
          project,
          (bytes) => _writeFrame(framePipe, bytes, sessionFuture, session),
          checkCancelled: operation?.throwIfCancelled,
          onProgress: (completedFrames, totalFrames) {
            operation?.reportProgress(
              completedFrames / totalFrames,
              completedFrames: completedFrames,
              totalFrames: totalFrames,
            );
          },
        );
      } catch (error, stackTrace) {
        streamError = error;
        streamStackTrace = stackTrace;
      }
      try {
        await framePipe.dispose();
      } catch (error, stackTrace) {
        session.cancel();
        streamError ??= error;
        streamStackTrace ??= stackTrace;
      }

      final completedSession = await sessionFuture;
      if (streamError != null) {
        Error.throwWithStackTrace(streamError, streamStackTrace!);
      }
      final returnCode = completedSession.getReturnCode();
      return ExportResult(
        success: ReturnCode.isSuccess(returnCode),
        outputPath: outputPath,
        command: command,
        logs: completedSession.getLogs() ?? completedSession.getOutput() ?? '',
        returnCode: returnCode,
      );
    } finally {
      operation?.detachCancel();
      await framePipe.dispose();
      if (operation?.isCancelled ?? false) {
        final outputFile = File(outputPath);
        if (await outputFile.exists()) {
          await outputFile.delete();
        }
      }
    }
  }

  String _buildCommand(
    Project project,
    String framePipePath,
    String outputPath,
  ) {
    return FfmpegCommandBuilder()
        .addFlag('-y')
        .addOption('-f', 'rawvideo')
        .addOption('-pixel_format', 'rgba')
        .addOption(
          '-video_size',
          '${project.width.round()}x${project.height.round()}',
        )
        .addOption('-framerate', project.fps)
        .addInput(framePipePath)
        .addFlag('-an')
        .addOption('-c:v', 'mpeg4')
        .addOption('-b:v', '5M')
        .addOption('-pix_fmt', 'yuv420p')
        .addOption('-movflags', '+faststart')
        .addOutput(outputPath)
        .build();
  }

  Future<void> _writeFrame(
    FfmpegFramePipe framePipe,
    List<int> bytes,
    Future<FFmpegSession> sessionFuture,
    FFmpegSession session,
  ) async {
    await Future.any<void>([
      framePipe.write(bytes),
      sessionFuture.then((completedSession) {
        throw StateError(
          'FFmpeg stopped before consuming all frames '
          '(code ${completedSession.getReturnCode()}): '
          '${completedSession.getLogs() ?? completedSession.getOutput() ?? ''}',
        );
      }),
    ]).timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        session.cancel();
        throw StateError(
          'FFmpeg did not consume an input frame within 15 seconds. '
          '${session.getLogs() ?? session.getOutput() ?? ''}',
        );
      },
    );
  }
}
