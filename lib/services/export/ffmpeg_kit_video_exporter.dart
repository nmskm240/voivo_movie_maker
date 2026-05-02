import 'dart:io';

import 'package:ffmpeg_kit_extended_flutter/ffmpeg_kit_extended_flutter.dart';
import 'package:path/path.dart' as path;

import '../../models/timeline.dart';
import 'ass_subtitle_builder.dart';
import 'ffmpeg_command_builder.dart';
import 'video_exporter.dart';

class FfmpegKitVideoExporter implements VideoExporter {
  const FfmpegKitVideoExporter({
    this.subtitleBuilder = const AssSubtitleBuilder(),
    this.commandBuilder = const FfmpegCommandBuilder(),
  });

  final AssSubtitleBuilder subtitleBuilder;
  final FfmpegCommandBuilder commandBuilder;

  @override
  Future<ExportResult> export(Project project, String outputPath) async {
    await FFmpegKitExtended.initialize();

    final workDir = await Directory.systemTemp.createTemp('voivo_export_');
    final assPath = path.join(workDir.path, 'timeline.ass');
    final assFile = File(assPath);
    await assFile.writeAsString(subtitleBuilder.build(project));

    final command = commandBuilder.buildTextOnlyExportCommand(
      project: project,
      assPath: assPath,
      outputPath: outputPath,
    );

    final session = await FFmpegKit.executeAsync(command);
    final returnCode = session.getReturnCode();
    final logs = session.getLogs() ?? session.getOutput() ?? '';
    final success = ReturnCode.isSuccess(returnCode);

    return ExportResult(
      success: success,
      outputPath: outputPath,
      command: command,
      logs: logs,
      returnCode: returnCode,
    );
  }
}
