// Dart imports:
import 'dart:async';
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/application/services/playback_controller.dart';
import 'package:voivo_movie_maker/application/services/rendering/project_frame_builder.dart';
import 'package:voivo_movie_maker/application/services/timeline_audio_player.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/preview/painters/project_preview_painter.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/view_model.dart';

class ProjectPreview extends ConsumerStatefulWidget {
  const ProjectPreview({super.key});

  @override
  ConsumerState<ProjectPreview> createState() => _ProjectPreviewState();
}

class _ProjectPreviewState extends ConsumerState<ProjectPreview> {
  late final TimelineAudioPlayer _timelineAudioPlayer;

  @override
  void initState() {
    super.initState();
    _timelineAudioPlayer = TimelineAudioPlayer();
  }

  @override
  void dispose() {
    unawaited(_timelineAudioPlayer.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projectSnapshot = ref.watch(projectProvider);
    final revision = ref.watch(
      timelineViewModelProvider.select((state) => state.value?.revision ?? 0),
    );
    final playback = ref.watch(playbackControllerProvider);
    final currentFrame = playback.currentFrame;
    final imageCacheRevision = ref
        .watch(projectImageCacheRevisionProvider)
        .value;
    final imageCache = ref.watch(projectImageCacheProvider);
    final audioCache = ref.watch(projectAudioCacheProvider);
    final videoFrameCacheRevision = ref
        .watch(projectVideoFrameCacheRevisionProvider)
        .value;
    final videoFrameCache = ref.watch(projectVideoFrameCacheProvider);

    return projectSnapshot.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      data: (project) {
        unawaited(
          _timelineAudioPlayer
              .sync(
                project: project,
                currentFrame: currentFrame,
                isPlaying: playback.isPlaying,
                loadAudio: audioCache.load,
              )
              .catchError((Object error, StackTrace stackTrace) {
                debugPrint('Could not preview audio: $error');
              }),
        );
        for (final clip in project.timeline.getActiveClipsAt(currentFrame)) {
          final imageComponent = clip.component<ImageComponent>();
          if (imageComponent == null ||
              imageCache.findById(imageComponent.assetId) != null) {
            continue;
          }
          final asset = project.assets.findById(imageComponent.assetId);
          if (asset != null) {
            unawaited(
              imageCache
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
        final videoFrames = <TimelineClipId, ui.Image>{};
        for (final clip in project.timeline.getActiveClipsAt(currentFrame)) {
          final videoComponent = clip.component<VideoComponent>();
          if (videoComponent == null) {
            continue;
          }
          final asset = project.assets.findById(videoComponent.assetId);
          if (asset == null || asset.kind != ProjectAssetKind.video) {
            continue;
          }
          final localFrame = currentFrame - clip.startFrame;
          final image = videoFrameCache.find(asset, localFrame);
          if (image != null) {
            videoFrames[clip.id] = image;
            continue;
          }
          unawaited(
            videoFrameCache
                .load(
                  asset,
                  frameNumber: localFrame,
                  position: Duration(
                    microseconds: (localFrame / project.fps * 1000000).round(),
                  ),
                )
                .then<void>(
                  (_) {},
                  onError: (Object error, StackTrace stackTrace) {
                    debugPrint(
                      'Could not decode video frame ${asset.name}: $error',
                    );
                  },
                ),
          );
        }
        final frame = ProjectFrameBuilder(
          imageAssets: imageCache.values,
          videoFrames: videoFrames,
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
                        images: imageCacheRevision,
                        videos: videoFrameCacheRevision,
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
