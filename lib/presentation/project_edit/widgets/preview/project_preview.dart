// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/application/services/playback_controller.dart';
import 'package:voivo_movie_maker/application/services/rendering/project_frame_builder.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/preview/painters/project_preview_painter.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/view_model.dart';

class ProjectPreview extends ConsumerWidget {
  const ProjectPreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectSnapshot = ref.watch(projectProvider);
    final revision = ref.watch(
      timelineViewModelProvider.select((state) => state.value?.revision ?? 0),
    );
    final currentFrame = ref.watch(
      playbackControllerProvider.select((playback) => playback.currentFrame),
    );
    final imageResourcesRevision = ref
        .watch(projectImageResourcesRevisionProvider)
        .value;
    final imageResources = ref.watch(projectImageResourcesProvider);

    return projectSnapshot.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      data: (project) {
        for (final clip in project.timeline.getActiveClipsAt(currentFrame)) {
          final imageComponent = clip.component<ImageComponent>();
          if (imageComponent == null ||
              imageResources.findById(imageComponent.assetId) != null) {
            continue;
          }
          final asset = project.assets.findById(imageComponent.assetId);
          if (asset != null) {
            unawaited(
              imageResources
                  .load(asset)
                  .then<void>(
                    (_) {},
                    onError: (Object error, StackTrace stackTrace) {
                      debugPrint('Could not load ${asset.name}: $error');
                    },
                  ),
            );
          }
        }
        final frame = ProjectFrameBuilder(
          imageAssets: imageResources.images,
        ).build(project, currentFrame);
        return Center(
          child: AspectRatio(
            aspectRatio: frame.projectSize.aspectRatio,
            child: ClipRect(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: CustomPaint(
                      painter: ProjectPreviewPainter(frame, (
                        timeline: revision,
                        images: imageResourcesRevision,
                      )),
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
