// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/infra/asset_store.dart';
import 'package:voivo_movie_maker/infra/project_directory.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/assets/asset_panel.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/export/export_button.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/clip_inspector.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/preview/playback_button.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/preview/project_preview.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/timeline.dart';

class EditorScreen extends ConsumerStatefulWidget {
  const EditorScreen({super.key, required this.projectId});

  final ProjectId projectId;

  @override
  ConsumerState<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends ConsumerState<EditorScreen> {
  late final ProjectDirectory _projectDirectory;
  late final DirectoryAssetStore _assetStore;

  @override
  void initState() {
    super.initState();
    _projectDirectory = ProjectDirectory.inProjects(
      ref.read(projectsDirectoryProvider),
      widget.projectId,
    );
    _assetStore = DirectoryAssetStore(_projectDirectory.assetsDirectory);
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        projectIdProvider.overrideWithValue(widget.projectId),
        projectAssetStoreProvider.overrideWithValue(_assetStore),
      ],
      child: const _EditorScreenBody(),
    );
  }
}

class _EditorScreenBody extends ConsumerWidget {
  const _EditorScreenBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [ExportButton()],
        title: PlaybackButton(),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(flex: 3, child: Container(color: const Color.fromARGB(255, 50, 50, 50), child: ProjectPreview())),
                  Expanded(flex: 2, child: TimelineView()),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      tabs: [
                        Tab(text: 'Inspector'),
                        Tab(text: 'Assets'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [ClipInspectorPane(), AssetPanel()],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
