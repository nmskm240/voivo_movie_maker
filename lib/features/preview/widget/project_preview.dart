import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voivo_movie_maker/application/providers/loaded_project_provider.dart';
import 'package:voivo_movie_maker/application/providers/playback_controller_provider.dart';
import 'package:voivo_movie_maker/features/preview/painters/project_preview_painter.dart';

class ProjectPreview extends ConsumerWidget {
  const ProjectPreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectSnapshot = ref.watch(loadedProjectProvider);
    final currentFrame = ref.watch(
      playbackControllerProvider.select((state) => state.currentFrame),
    );

    return projectSnapshot.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      data: (projectSnapshot) {
        final project = projectSnapshot.project;
        return Center(
          child: AspectRatio(
            aspectRatio: project.width / project.height,
            child: ClipRect(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: CustomPaint(
                      painter: ProjectPreviewPainter(
                        project,
                        currentFrame,
                        projectSnapshot.revision,
                      ),
                      child: const SizedBox.expand(),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
