// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/view_model.dart';

void main() {
  test('adds a clip after the timeline has loaded', () async {
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

    final subscription = container.listen(timelineViewModelProvider, (_, _) {});
    addTearDown(subscription.close);
    await container.read(timelineViewModelProvider.future);

    container.read(timelineViewModelProvider.notifier).addClip(0);

    expect(project.timeline.tracks.first.clips, hasLength(1));
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
