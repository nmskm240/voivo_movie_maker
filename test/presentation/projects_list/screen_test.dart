// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/presentation/projects_list/screen.dart';
import 'package:voivo_movie_maker/presentation/router.dart';

void main() {
  testWidgets('refreshes the list after creating a project and returning', (
    tester,
  ) async {
    final repository = _ProjectRepository(
      [],
      saveDelay: const Duration(milliseconds: 10),
    );
    final router = GoRouter(
      initialLocation: ProjectListRoute.path,
      routes: [
        GoRoute(
          path: ProjectListRoute.path,
          name: ProjectListRoute.name,
          builder: (context, state) => const ProjectListScreen(),
          routes: [
            GoRoute(
              path: 'projects/:projectId',
              name: ProjectEditorRoute.name,
              builder: (context, state) =>
                  const Scaffold(body: Text('Project editor')),
            ),
          ],
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [projectRepositoryProvider.overrideWithValue(repository)],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('No projects yet'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'new movie');
    await tester.tap(find.widgetWithText(FilledButton, 'Create'));
    await tester.pumpAndSettle();

    expect(find.text('Project editor'), findsOneWidget);

    router.pop();
    await tester.pumpAndSettle();

    expect(find.text('new movie'), findsOneWidget);
    expect(repository.findAnyCount, 2);
  });

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
  _ProjectRepository(
    Iterable<Project> projects, {
    this.saveDelay = Duration.zero,
  }) : _projects = projects.toList();

  final List<Project> _projects;
  final Duration saveDelay;
  final List<ProjectId> deletedIds = [];
  int findAnyCount = 0;

  @override
  Future<void> delete(ProjectId id) async {
    deletedIds.add(id);
    _projects.removeWhere((project) => project.id == id);
  }

  @override
  Future<List<Project>> findAny() async {
    findAnyCount++;
    return List.of(_projects);
  }

  @override
  Future<Project> getById(ProjectId id) async {
    return _projects.singleWhere((project) => project.id == id);
  }

  @override
  Future<void> save(Project project) async {
    await Future<void>.delayed(saveDelay);
    _projects.add(project);
  }
}
