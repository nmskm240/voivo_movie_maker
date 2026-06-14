// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/export/export_button.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/clip_inspector.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/preview/playback_button.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/preview/project_preview.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/timeline.dart';

class EditorScreen extends StatelessWidget {
  const EditorScreen({super.key, required this.projectId});

  final ProjectId projectId;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [projectIdProvider.overrideWithValue(projectId)],
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
                  Expanded(flex: 3, child: ProjectPreview()),
                  Expanded(flex: 2, child: TimelineView()),
                ],
              ),
            ),
            Expanded(flex: 2, child: ClipInspectorPane()),
          ],
        ),
      ),
    );
  }
}
