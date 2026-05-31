import 'dart:convert';
import 'dart:io';

import 'package:voivo_movie_maker/domain/project.dart';

final class ProjectWriter implements IProjectWriter {
  const ProjectWriter(this._file);

  final File _file;

  @override
  Future<void> write(Project project) async {
    const encoder = JsonEncoder.withIndent('  ');
    final jsonString = encoder.convert(project.toJson());
    await _file.writeAsString(jsonString);
  }
}