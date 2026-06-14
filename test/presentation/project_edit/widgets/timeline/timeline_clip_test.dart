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
              child: TimelineClipView(clip: TimelineClipInfo.fromEntity(clip)),
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
