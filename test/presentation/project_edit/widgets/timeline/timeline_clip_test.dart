// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/application/dtos/timeline_clip_info.dart';
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/timeline_auto_scroll.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/timeline_clip.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/view_model.dart';

void main() {
  testWidgets('removes a clip after long-press confirmation', (tester) async {
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

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 48,
              child: TimelineClipView(
                clip: TimelineClipInfo.fromEntity(clip),
                pixelsPerFrame: 10,
              ),
            ),
          ),
        ),
      ),
    );

    await tester.longPress(find.byType(TimelineClipView));
    await tester.pumpAndSettle();

    expect(find.text('Remove clip?'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Remove'));
    await tester.pumpAndSettle();

    expect(project.timeline.tracks.first.clips, isEmpty);
  });

  testWidgets('resizes a clip by dragging its end handle', (tester) async {
    final fixture = await _pumpClip(tester, startFrame: 10, durationFrames: 10);

    await tester.drag(
      find.byKey(ValueKey('${fixture.clip.id.value}.resize-end')),
      const Offset(30, 0),
    );
    await tester.pumpAndSettle();

    expect(fixture.clip.startFrame, 10);
    expect(fixture.clip.durationFrames, 13);
  });

  testWidgets('trims a clip by dragging its start handle', (tester) async {
    final fixture = await _pumpClip(tester, startFrame: 10, durationFrames: 10);

    await tester.drag(
      find.byKey(ValueKey('${fixture.clip.id.value}.resize-start')),
      const Offset(20, 0),
    );
    await tester.pumpAndSettle();

    expect(fixture.clip.startFrame, 12);
    expect(fixture.clip.durationFrames, 8);
  });

  testWidgets('extends a clip by the auto-scroll distance', (tester) async {
    final fixture = await _pumpClip(
      tester,
      startFrame: 10,
      durationFrames: 10,
      autoScrollDelta: 30,
    );

    await tester.drag(
      find.byKey(ValueKey('${fixture.clip.id.value}.resize-end')),
      const Offset(30, 0),
    );
    await tester.pumpAndSettle();

    expect(fixture.clip.durationFrames, 16);
  });

  testWidgets('shows a round grip on each resize handle', (tester) async {
    await _pumpClip(tester, startFrame: 10, durationFrames: 10);

    final roundGrips = find.byWidgetPredicate(
      (widget) =>
          widget is DecoratedBox &&
          widget.decoration is BoxDecoration &&
          (widget.decoration as BoxDecoration).shape == BoxShape.circle,
    );

    expect(roundGrips, findsNWidgets(2));
  });
}

Future<({TimelineClip clip, ProviderContainer container})> _pumpClip(
  WidgetTester tester, {
  required int startFrame,
  required int durationFrames,
  double autoScrollDelta = 0,
}) async {
  final project = Project.empty();
  final clip = TimelineClip(
    id: TimelineClipId.create(),
    startFrame: startFrame,
    durationFrames: durationFrames,
  );
  project.timeline.tracks.first.addClip(clip);
  final container = ProviderContainer(
    overrides: [
      projectRepositoryProvider.overrideWithValue(_ProjectRepository(project)),
      projectIdProvider.overrideWithValue(project.id),
    ],
  );
  addTearDown(container.dispose);

  final subscription = container.listen(timelineViewModelProvider, (_, _) {});
  addTearDown(subscription.close);
  await container.read(timelineViewModelProvider.future);
  var autoScrollApplied = false;

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        home: Scaffold(
          body: NotificationListener<TimelineAutoScrollUpdate>(
            onNotification: (notification) {
              if (!autoScrollApplied && autoScrollDelta != 0) {
                autoScrollApplied = true;
                notification.onScroll?.call(autoScrollDelta);
              }
              return false;
            },
            child: SizedBox(
              width: durationFrames * 10,
              height: 48,
              child: TimelineClipView(
                clip: TimelineClipInfo.fromEntity(clip),
                pixelsPerFrame: 10,
              ),
            ),
          ),
        ),
      ),
    ),
  );

  return (clip: clip, container: container);
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
