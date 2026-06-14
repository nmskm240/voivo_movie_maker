// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/presentation/project_edit/states/timeline_select_state.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/clip_inspector.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/view_model.dart';

void main() {
  testWidgets('reopens a collapsed inspector section', (tester) async {
    final project = Project.empty();
    final clip = TimelineClip(id: TimelineClipId.create(), startFrame: 0);
    project.timeline.tracks.first.addClip(clip);
    final container = ProviderContainer(
      overrides: [
        projectRepositoryProvider.overrideWithValue(
          _ProjectRepository(project),
        ),
        projectIdProvider.overrideWithValue(project.id),
      ],
    );
    addTearDown(container.dispose);

    final subscription = container.listen(timelineViewModelProvider, (_, _) {});
    addTearDown(subscription.close);
    await container.read(timelineViewModelProvider.future);
    container.read(timelineSelectionStateProvider.notifier).selectClip(clip.id);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: Scaffold(body: ClipInspectorPane())),
      ),
    );
    await tester.pumpAndSettle();

    final section = find.byType(ExpansionTile);
    expect(section, findsOneWidget);

    await tester.tap(section);
    await tester.pumpAndSettle();
    await tester.tap(section);
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Position'), findsOneWidget);
  });
}

class _ProjectRepository implements IProjectRepository {
  const _ProjectRepository(this.project);

  final Project project;

  @override
  Future<List<Project>> findAny() async => [project];

  @override
  Future<Project> getById(ProjectId id) async => project;

  @override
  Future<void> save(Project project) async {}
}
