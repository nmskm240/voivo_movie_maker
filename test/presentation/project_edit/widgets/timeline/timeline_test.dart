// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/timeline.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/timeline_auto_scroll.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/timeline_clip.dart';

void main() {
  testWidgets('auto-scrolls while dragging a clip near the right edge', (
    tester,
  ) async {
    final project = Project.empty();
    project.timeline.tracks.first.addClip(
      TimelineClip(
        id: TimelineClipId.create(),
        startFrame: 0,
        durationFrames: 90,
      ),
    );
    final container = ProviderContainer(
      overrides: [
        projectRepositoryProvider.overrideWithValue(
          _ProjectRepository(project),
        ),
        projectIdProvider.overrideWithValue(project.id),
      ],
    );
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(body: SizedBox(width: 800, child: TimelineView())),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final clip = find.byType(TimelineClipView);
    final initialLeft = tester.getTopLeft(clip).dx;
    TimelineAutoScrollUpdate(
      const Offset(790, 100),
    ).dispatch(tester.element(clip));
    await tester.pump(const Duration(milliseconds: 16));
    await tester.pump(const Duration(seconds: 1));

    expect(tester.getTopLeft(clip).dx, lessThan(initialLeft));

    const TimelineAutoScrollEnd().dispatch(tester.element(clip));
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
