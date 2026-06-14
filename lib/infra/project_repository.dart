// Dart imports:
import 'dart:convert';
import 'dart:io';

// Package imports:
// Project imports:
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/infra/project_directory.dart';

final class ProjectRepository implements IProjectRepository {
  ProjectRepository(this._projectsDirectory);

  static var _temporaryFileSequence = 0;

  final Directory _projectsDirectory;
  Future<void> _saveQueue = Future.value();

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
  Future<void> save(Project project) {
    final json = const JsonEncoder.withIndent('  ').convert(project.toJson());
    final save = _saveQueue.then((_) => _save(project.id, json));
    _saveQueue = save.then<void>((_) {}, onError: (_, _) {});
    return save;
  }

  Future<void> _save(ProjectId projectId, String json) async {
    await _projectsDirectory.create(recursive: true);
    final projectDirectory = ProjectDirectory.inProjects(
      _projectsDirectory,
      projectId,
    );
    if (!await projectDirectory.root.exists()) {
      await projectDirectory.root.create(recursive: true);
    }
    if (!await projectDirectory.assetsDirectory.exists()) {
      await projectDirectory.assetsDirectory.create(recursive: true);
    }

    final tempFile = File(
      '${projectDirectory.projectFile.path}.tmp.${_temporaryFileSequence++}',
    );
    try {
      await tempFile.writeAsString(json);
      await tempFile.rename(projectDirectory.projectFile.path);
    } finally {
      if (await tempFile.exists()) {
        await tempFile.delete();
      }
    }
  }

  Future<Project> _read(File file) async {
    final json = jsonDecode(await file.readAsString());
    if (json is! Map<String, Object?>) {
      throw const FormatException('Project file root must be an object');
    }

    return Project.fromJson(json);
  }
}
