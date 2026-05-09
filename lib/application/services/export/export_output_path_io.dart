import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../models/timeline.dart';

Future<String> createPlatformDefaultExportOutputPath(Project project) async {
  final outputDirectory = await _resolveExportBaseDirectory();
  final exportsDirectory = Directory(
    path.join(outputDirectory.path, 'exports'),
  );
  if (!await exportsDirectory.exists()) {
    await exportsDirectory.create(recursive: true);
  }

  final timestamp = DateTime.now()
      .toIso8601String()
      .replaceAll(':', '')
      .replaceAll('.', '');
  return path.join(exportsDirectory.path, '${project.id}_$timestamp.mp4');
}

Future<Directory> _resolveExportBaseDirectory() async {
  try {
    return await getApplicationDocumentsDirectory();
  } on MissingPlatformDirectoryException {
    final home = Platform.environment['HOME'];
    if (home != null && home.isNotEmpty) {
      return Directory(path.join(home, 'Videos', 'Voivo Movie Maker'));
    }

    return Directory(path.join(Directory.systemTemp.path, 'Voivo Movie Maker'));
  }
}
