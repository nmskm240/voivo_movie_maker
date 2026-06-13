import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voivo_movie_maker/application/services/export/export_operation.dart';
import 'package:voivo_movie_maker/application/services/export/export_result.dart';
import 'package:voivo_movie_maker/application/services/export/ffmpeg_project_encoder.dart';
import 'package:voivo_movie_maker/application/services/export/project_exporter.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('exports, saves, and removes the temporary video', () async {
    final temporaryDirectory = await Directory.systemTemp.createTemp(
      'project_exporter_test_',
    );
    List<int>? savedBytes;
    const channel = MethodChannel('flutter_file_dialog');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          expect(call.method, 'saveFile');
          final arguments = call.arguments as Map<Object?, Object?>;
          expect(arguments['fileName'], 'movie.mp4');
          expect(arguments['mimeTypesFilter'], ['video/mp4']);
          savedBytes = await File(
            arguments['sourceFilePath']! as String,
          ).readAsBytes();
          return 'movie.mp4';
        });
    final operation = ExportOperation();
    final exporter = ProjectExporter(
      encoder: const _FakeProjectEncoder(),
      temporaryDirectoryProvider: () async => temporaryDirectory,
    );

    final result = await exporter.export(
      Project(
        name: 'movie',
        assets: ProjectAssetCatalog(),
        timeline: Timeline(),
      ),
      operation: operation,
    );

    expect(result?.success, isTrue);
    expect(result?.outputPath, 'movie.mp4');
    expect(savedBytes, [1, 2, 3]);
    expect(operation.currentProgress.phase, ExportPhase.saving);
    expect(temporaryDirectory.listSync(), isEmpty);

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
    await operation.dispose();
    await temporaryDirectory.delete();
  });
}

class _FakeProjectEncoder extends FfmpegProjectEncoder {
  const _FakeProjectEncoder();

  @override
  Future<ExportResult> encode(
    Project project,
    String outputPath, {
    ExportOperation? operation,
  }) async {
    operation?.markStarted();
    await File(outputPath).writeAsBytes([1, 2, 3]);
    return ExportResult(
      success: true,
      outputPath: outputPath,
      command: 'fake',
      logs: '',
      returnCode: 0,
    );
  }
}
