import 'dart:convert';
import 'dart:io';

import 'package:voivo_movie_maker/domain/project.dart';

final class ProjectReader implements IProjectReader {
  const ProjectReader(this._file);

  final File _file;

  @override
  Future<Project> read() async {
    final contents = await _file.readAsString();
    final json = jsonDecode(contents);
    return Project.fromJson(json);
  }
}
