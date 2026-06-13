import 'dart:io';

import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:voivo_movie_maker/domain/project.dart';

import 'export_operation.dart';
import 'export_result.dart';
import 'ffmpeg_project_encoder.dart';

typedef TemporaryDirectoryProvider = Future<Directory> Function();

class ProjectExporter {
  const ProjectExporter({
    this.encoder = const FfmpegProjectEncoder(),
    this.temporaryDirectoryProvider = getTemporaryDirectory,
  });

  final FfmpegProjectEncoder encoder;
  final TemporaryDirectoryProvider temporaryDirectoryProvider;

  Future<ExportResult?> export(
    Project project, {
    required ExportOperation operation,
  }) async {
    final fileName = path.setExtension(project.name, '.mp4');
    final temporaryDirectory = await temporaryDirectoryProvider();
    final temporaryOutput = File(
      path.join(temporaryDirectory.path, 'voivo_export_${project.id}.mp4'),
    );
    try {
      final result = await encoder.encode(
        project,
        temporaryOutput.path,
        operation: operation,
      );
      if (!result.success) {
        return result;
      }

      final outputPath = await FlutterFileDialog.saveFile(
        params: SaveFileDialogParams(
          sourceFilePath: temporaryOutput.path,
          fileName: fileName,
          mimeTypesFilter: const ['video/mp4'],
        ),
      );
      if (outputPath == null) {
        return null;
      }
      operation.reportSaving();
      return ExportResult(
        success: true,
        outputPath: outputPath,
        command: result.command,
        logs: result.logs,
        returnCode: result.returnCode,
      );
    } finally {
      if (await temporaryOutput.exists()) {
        await temporaryOutput.delete();
      }
    }
  }
}
