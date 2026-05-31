import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/project_repository.dart';
import 'package:voivo_movie_maker/infra/asset_storage.dart';

final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  throw UnimplementedError('No project repository implementation provided');
});

final class DirectoryProjectRepository implements ProjectRepository {
  DirectoryProjectRepository(this.directory)
    : _projectFile = File(p.join(directory.path, 'project.json'));

  final Directory directory;
  final File _projectFile;
  Future<void> _saveQueue = Future.value();

  @override
  Future<Project> load() async {
    if (!await _projectFile.exists()) {
      return Project.empty();
    }

    final json = jsonDecode(await _projectFile.readAsString());
    if (json is! Map<String, Object?>) {
      throw const FormatException('Project file root must be an object');
    }

    return Project.fromJson(json);
  }

  @override
  Future<void> save(Project project) async {
    final saveTask = _saveQueue.then((_) async {
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      const encoder = JsonEncoder.withIndent('  ');
      final tempFile = File('${_projectFile.path}.tmp');
      await tempFile.writeAsString(encoder.convert(project.toJson()));
      await tempFile.rename(_projectFile.path);
    });

    _saveQueue = saveTask.catchError((_) {});
    return saveTask;
  }
}
