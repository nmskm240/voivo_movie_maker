// Dart imports:
import 'dart:io';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/infra/project_repository.dart';

void main() {
  test('serializes concurrent project saves', () async {
    final projectsDirectory = await Directory.systemTemp.createTemp(
      'project_repository_test',
    );
    addTearDown(() => projectsDirectory.delete(recursive: true));
    final repository = ProjectRepository(projectsDirectory);
    final project = Project.empty();

    await Future.wait(List.generate(20, (_) => repository.save(project)));

    final restored = await repository.getById(project.id);
    expect(restored.id, project.id);
  });

  test('does not collide across repository instances', () async {
    final projectsDirectory = await Directory.systemTemp.createTemp(
      'project_repository_test',
    );
    addTearDown(() => projectsDirectory.delete(recursive: true));
    final repositories = [
      ProjectRepository(projectsDirectory),
      ProjectRepository(projectsDirectory),
    ];
    final project = Project.empty();

    await Future.wait(
      List.generate(20, (index) => repositories[index % 2].save(project)),
    );

    final restored = await repositories.first.getById(project.id);
    expect(restored.id, project.id);
  });
}
