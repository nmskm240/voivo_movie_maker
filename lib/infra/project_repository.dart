// Dart imports:
import 'dart:convert';
import 'dart:io';

// Package imports:
// Project imports:
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/infra/project_directory.dart';

final class ProjectRepository implements IProjectRepository {
  const ProjectRepository(this._projectsDirectory);

  final Directory _projectsDirectory;

  @override
  Future<List<Project>> findAny() async {
    final projects = <Project>[];
    if (!await _projectsDirectory.exists()) {
      return projects;
    }

    await for (final entity in _projectsDirectory.list()) {
      if (entity is! Directory) {
        continue;
      }

      final projectFile = ProjectDirectory(entity).projectFile;
      if (!await projectFile.exists()) {
        continue;
      }

      projects.add(await _read(projectFile));
    }
    return projects;
  }

  @override
  Future<Project> getById(ProjectId id) async {
    final projectFile = ProjectDirectory.inProjects(
      _projectsDirectory,
      id,
    ).projectFile;
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
    await _projectsDirectory.create(recursive: true);
    final projectDirectory = ProjectDirectory.inProjects(
      _projectsDirectory,
      project.id,
    );
    if (!await projectDirectory.root.exists()) {
      await projectDirectory.root.create(recursive: true);
    }
    if (!await projectDirectory.assetsDirectory.exists()) {
      await projectDirectory.assetsDirectory.create(recursive: true);
    }

    const encoder = JsonEncoder.withIndent('  ');
    final tempFile = File('${projectDirectory.projectFile.path}.tmp');
    await tempFile.writeAsString(encoder.convert(project.toJson()));
    await tempFile.rename(projectDirectory.projectFile.path);
  }

  Future<Project> _read(File file) async {
    final json = jsonDecode(await file.readAsString());
    if (json is! Map<String, Object?>) {
      throw const FormatException('Project file root must be an object');
    }

    return Project.fromJson(json);
  }
}
