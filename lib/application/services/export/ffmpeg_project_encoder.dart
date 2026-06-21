// Dart imports:
import 'dart:io';
import 'dart:typed_data';

// Package imports:
import 'package:ffmpeg_kit_extended_flutter/ffmpeg_kit_extended_flutter.dart';
import 'package:path/path.dart' as path;

// Project imports:
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'export_operation.dart';
import 'export_result.dart';
import 'ffmpeg_command_builder.dart';
import 'ffmpeg_frame_pipe.dart';
import 'project_frame_stream_writer.dart';

class FfmpegProjectEncoder {
  const FfmpegProjectEncoder({
    this.frameStreamWriter = const ProjectFrameStreamWriter(),
    this.audioAssets = const {},
  });

  final ProjectFrameStreamWriter frameStreamWriter;
  final Map<AssetId, Uint8List> audioAssets;

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
    final audioInputs = await _createAudioInputs(project, outputPath);
    try {
      final command = _buildCommand(
        project,
        framePipe.path,
        outputPath,
        audioInputs,
      );
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
      await _deleteAudioInputs(audioInputs);
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
    List<_AudioInput> audioInputs,
  ) {
    final builder = FfmpegCommandBuilder()
        .addFlag('-y')
        .addOption('-f', 'rawvideo')
        .addOption('-pixel_format', 'rgba')
        .addOption(
          '-video_size',
          '${project.width.round()}x${project.height.round()}',
        )
        .addOption('-framerate', project.fps)
        .addInput(framePipePath);

    for (final input in audioInputs) {
      builder.addInput(input.path);
    }

    if (audioInputs.isEmpty) {
      builder.addFlag('-an');
    } else {
      builder
          .addOption('-filter_complex', _buildAudioFilter(audioInputs))
          .addOption('-map', '0:v:0')
          .addOption('-map', '[$_mixedAudioLabel]')
          .addOption('-c:a', 'aac')
          .addOption('-t', _seconds(_durationFrames(project), project.fps));
    }

    return builder
        .addOption('-c:v', 'mpeg4')
        .addOption('-b:v', '5M')
        .addOption('-pix_fmt', 'yuv420p')
        .addOption('-movflags', '+faststart')
        .addOutput(outputPath)
        .build();
  }

  Future<List<_AudioInput>> _createAudioInputs(
    Project project,
    String outputPath,
  ) async {
    final clips = project.timeline.tracks.expand((track) => track.clips);
    final inputs = <_AudioInput>[];
    Directory? directory;
    for (final clip in clips) {
      final component = clip.component<AudioComponent>();
      if (component == null || component.muted || component.volume <= 0) {
        continue;
      }
      final asset = project.assets.findById(component.assetId);
      final bytes = audioAssets[component.assetId];
      if (asset == null || asset.kind != ProjectAssetKind.audio) {
        continue;
      }
      if (bytes == null) {
        throw StateError('Audio asset ${component.assetId} is not loaded.');
      }

      directory ??= await File(
        outputPath,
      ).parent.createTemp('voivo_export_audio_');
      final extension = path.extension(asset.name).isEmpty
          ? '.audio'
          : path.extension(asset.name);
      final file = File(
        path.join(directory.path, '${clip.id.value}$extension'),
      );
      await file.writeAsBytes(bytes);
      inputs.add(
        _AudioInput(
          path: file.path,
          startSeconds: clip.startFrame / project.fps,
          durationSeconds: _seconds(clip.durationFrames, project.fps),
          volume: component.volume,
          temporaryDirectory: directory,
        ),
      );
    }
    return inputs;
  }

  Future<void> _deleteAudioInputs(List<_AudioInput> audioInputs) async {
    final directories = audioInputs
        .map((input) => input.temporaryDirectory)
        .toSet();
    for (final directory in directories) {
      if (await directory.exists()) {
        await directory.delete(recursive: true);
      }
    }
  }

  String _buildAudioFilter(List<_AudioInput> audioInputs) {
    final filters = <String>[];
    for (var index = 0; index < audioInputs.length; index++) {
      final input = audioInputs[index];
      final inputIndex = index + 1;
      final delayMs = (input.startSeconds * 1000).round();
      filters.add(
        '[$inputIndex:a]'
        'atrim=0:${input.durationSeconds},'
        'asetpts=PTS-STARTPTS,'
        'volume=${input.volume},'
        'adelay=$delayMs:all=1'
        '[a$index]',
      );
    }

    if (audioInputs.length == 1) {
      filters.add('[a0]anull[$_mixedAudioLabel]');
    } else {
      final inputs = [
        for (var index = 0; index < audioInputs.length; index++) '[a$index]',
      ].join();
      filters.add(
        '$inputs'
        'amix=inputs=${audioInputs.length}:duration=longest:normalize=0'
        '[$_mixedAudioLabel]',
      );
    }
    return filters.join(';');
  }

  int _durationFrames(Project project) {
    return project.timeline.tracks
        .expand((track) => track.clips)
        .fold(
          project.fps,
          (duration, clip) =>
              duration > clip.endFrame ? duration : clip.endFrame,
        );
  }

  String _seconds(num frames, int fps) {
    return (frames / fps).toStringAsFixed(6);
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

const _mixedAudioLabel = 'mixed_audio';

final class _AudioInput {
  const _AudioInput({
    required this.path,
    required this.startSeconds,
    required this.durationSeconds,
    required this.volume,
    required this.temporaryDirectory,
  });

  final String path;
  final double startSeconds;
  final String durationSeconds;
  final double volume;
  final Directory temporaryDirectory;
}
