// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/presentation/projects_list/screen.dart';

void main() {
  testWidgets('deletes a project after confirmation and refreshes the list', (
    tester,
  ) async {
    final project = Project.empty(name: 'movie');
    final repository = _ProjectRepository([project]);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [projectRepositoryProvider.overrideWithValue(repository)],
        child: const MaterialApp(home: ProjectListScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('movie'), findsOneWidget);

    await tester.longPress(find.text('movie'));
    await tester.pumpAndSettle();

    expect(find.text('Delete project?'), findsOneWidget);
    expect(find.textContaining('all of its assets'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
    await tester.pumpAndSettle();

    expect(repository.deletedIds, [project.id]);
    expect(find.text('movie'), findsNothing);
    expect(find.text('No projects yet'), findsOneWidget);
  });
}

class _ProjectRepository implements IProjectRepository {
  _ProjectRepository(Iterable<Project> projects)
    : _projects = projects.toList();

  final List<Project> _projects;
  final List<ProjectId> deletedIds = [];

  @override
  Future<void> delete(ProjectId id) async {
    deletedIds.add(id);
    _projects.removeWhere((project) => project.id == id);
  }

  @override
  Future<List<Project>> findAny() async => List.of(_projects);

  @override
  Future<Project> getById(ProjectId id) async {
    return _projects.singleWhere((project) => project.id == id);
  }

  @override
  Future<void> save(Project project) async {
    _projects.add(project);
  }
}
