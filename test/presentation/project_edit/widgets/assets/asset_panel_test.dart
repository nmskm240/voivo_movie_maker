// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/assets/asset_panel.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/timeline_drag_data.dart';

void main() {
  testWidgets('shows imported assets as draggable items and an import FAB', (
    tester,
  ) async {
    final project = Project.empty();
    project.assets.add(
      ProjectAsset(name: 'image.png', kind: ProjectAssetKind.image),
    );
    project.assets.add(
      ProjectAsset(name: 'voice.wav', kind: ProjectAssetKind.audio),
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
        child: const MaterialApp(home: Scaffold(body: AssetPanel())),
      ),
    );
    await tester.pump();

    expect(find.text('image.png'), findsOneWidget);
    expect(find.text('voice.wav'), findsOneWidget);
    expect(find.byType(Draggable<TimelineDragData>), findsNWidgets(2));
    expect(find.byTooltip('Import asset'), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    await tester.pump();
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
