import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/application/services/playback_controller.dart';
import 'package:voivo_movie_maker/domain/project.dart';

void main() {
  testWidgets('can play after the project finishes loading', (tester) async {
    final project = Project.empty();
    final repository = _DelayedProjectRepository();
    final container = ProviderContainer(
      overrides: [
        projectRepositoryProvider.overrideWithValue(repository),
        projectIdProvider.overrideWithValue(project.id),
      ],
    );
    final subscription = container.listen(
      playbackControllerProvider,
      (_, _) {},
    );
    try {
      expect(container.read(playbackControllerProvider).fps, 0);

      repository.complete(project);
      await container.read(projectProvider.future);
      await tester.pump();

      final controller = container.read(playbackControllerProvider.notifier);
      expect(container.read(playbackControllerProvider).fps, project.fps);
      expect(() => controller.play(), returnsNormally);
      controller.pause();
    } finally {
      subscription.close();
      container.dispose();
      await tester.pump();
    }
  });
}

class _DelayedProjectRepository implements IProjectRepository {
  final _project = Completer<Project>();

  void complete(Project project) => _project.complete(project);

  @override
  Future<List<Project>> findAny() async => [await _project.future];

  @override
  Future<Project> getById(ProjectId id) => _project.future;

  @override
  Future<void> save(Project project) async {}
}
