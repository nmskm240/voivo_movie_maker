import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:voivo_movie_maker/constants.dart';
import 'package:voivo_movie_maker/domain/project.dart';

final class ProjectRepository implements IProjectRepository {
  const ProjectRepository(this.root);

  final Directory root;

  @override
  Future<List<Project>> findAny() async {
    final projects = <Project>[];
    if (!await root.exists()) {
      return projects;
    }

    await for (final entity in root.list()) {
      if (entity is! Directory) {
        continue;
      }

      final projectFile = _projectFileIn(entity);
      if (!await projectFile.exists()) {
        continue;
      }

      projects.add(await _read(projectFile));
    }
    return projects;
  }

  @override
  Future<Project> getById(ProjectId id) async {
    final projectFile = _projectFileIn(_projectDirectoryFor(id));
    if (!await projectFile.exists()) {
      throw ArgumentError.value(
        id.value,
        'id',
        'Project not found at ${projectFile.path}',
      );
    }

    return _read(projectFile);
  }

  @override
  Future<void> save(Project project) async {
    await root.create(recursive: true);
    final projectDir = _projectDirectoryFor(project.id);
    if (!await projectDir.exists()) {
      await projectDir.create(recursive: true);
    }
    final assetsDir = Directory(p.join(projectDir.path, assetDirectoryName));
    if (!await assetsDir.exists()) {
      await assetsDir.create(recursive: true);
    }

    const encoder = JsonEncoder.withIndent('  ');
    final tempFile = File(p.join(projectDir.path, ".$projectFileName.tmp"));
    await tempFile.writeAsString(encoder.convert(project.toJson()));
    await tempFile.rename(_projectFileIn(projectDir).path);
  }

  Directory _projectDirectoryFor(ProjectId id) {
    return Directory(p.join(root.path, id.value));
  }

  File _projectFileIn(Directory directory) {
    return File(p.join(directory.path, projectFileName));
  }

  Future<Project> _read(File file) async {
    final json = jsonDecode(await file.readAsString());
    if (json is! Map<String, Object?>) {
      throw const FormatException('Project file root must be an object');
    }

    return Project.fromJson(json);
  }
}
