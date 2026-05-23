import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voivo_movie_maker/application/providers/loaded_project_provider.dart';
import 'package:voivo_movie_maker/application/providers/playback_controller_provider.dart';
import 'package:voivo_movie_maker/features/preview/painters/project_preview_painter.dart';

class ProjectPreview extends ConsumerWidget {
  const ProjectPreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(loadedProjectProvider).project;
    final currentFrame = ref.watch(
      playbackControllerProvider.select((state) => state.currentFrame),
    );

    return Center(
      child: AspectRatio(
        aspectRatio: project.width / project.height,
        child: ClipRect(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: CustomPaint(
                  painter: ProjectPreviewPainter(project, currentFrame),
                  child: const SizedBox.expand(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
