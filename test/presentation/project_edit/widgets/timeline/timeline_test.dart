// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/timeline.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/timeline_auto_scroll.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/timeline_clip.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/view_model.dart';

void main() {
  testWidgets('adds a timeline track from the track list footer', (
    tester,
  ) async {
    final project = Project.empty();
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

    await tester.tap(find.byKey(const ValueKey('add-timeline-track')));
    await tester.pumpAndSettle();

    expect(project.timeline.tracks, hasLength(Timeline.initialTrackCount + 1));
    expect(find.text('Track 6'), findsOneWidget);
  });

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
    expect(
      tester.getSize(find.byKey(const ValueKey('playhead-drag-handle'))).width,
      32,
    );
    final initialLeft = tester.getTopLeft(clip).dx;
    TimelineAutoScrollUpdate(
      const Offset(790, 100),
    ).dispatch(tester.element(clip));
    await tester.pump(const Duration(milliseconds: 16));
    await tester.pump(const Duration(seconds: 1));

    expect(tester.getTopLeft(clip).dx, lessThan(initialLeft));

    const TimelineAutoScrollEnd().dispatch(tester.element(clip));
  });

  testWidgets('adjusts the timeline scale and keeps the viewport center', (
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
    await tester.tap(find.byKey(const ValueKey('timeline-scale-in')));
    await tester.pumpAndSettle();

    expect(
      container.read(timelineViewModelProvider).value?.pixelsPerFrame,
      1.5,
    );
    expect(tester.getTopLeft(clip).dx, lessThan(initialLeft));
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

  @override
  Future<void> delete(ProjectId id) async {}
}
