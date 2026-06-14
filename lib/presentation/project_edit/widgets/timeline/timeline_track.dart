// Dart imports:
import 'dart:math' as math;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:voivo_movie_maker/application/dtos/timeline_track_info.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/timeline_clip.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/view_model.dart';

class TimelineTrackView extends ConsumerWidget {
  const TimelineTrackView({
    required this.trackIndex,
    required this.track,
    required this.pixelsPerFrame,
    this.selected = false,
    super.key,
  });

  final int trackIndex;
  final TimelineTrackInfo track;
  final double pixelsPerFrame;
  final bool selected;

  static const height = 56.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DragTarget<TimelineClipDragData>(
      onWillAcceptWithDetails: (_) => true,
      onAcceptWithDetails: (details) {
        final renderBox = context.findRenderObject()! as RenderBox;
        final localOffset = renderBox.globalToLocal(details.offset);
        final startFrame = math.max(
          0,
          (localOffset.dx / pixelsPerFrame).round(),
        );

        ref
            .read(timelineViewModelProvider.notifier)
            .moveClip(
              details.data.clipId,
              targetTrackIndex: trackIndex,
              startFrame: startFrame,
            );
      },
      builder: (context, candidateData, rejectedData) {
        return ColoredBox(
          color: candidateData.isEmpty
              ? Colors.transparent
              : Theme.of(
                  context,
                ).colorScheme.primaryContainer.withValues(alpha: 0.25),
          child: SizedBox(
            height: TimelineTrackView.height,
            child: Stack(
              children: [
                for (final clip in track.clips)
                  Positioned(
                    top: 4,
                    bottom: 4,
                    left: clip.startFrame * pixelsPerFrame,
                    width: clip.durationFrames * pixelsPerFrame,
                    child: TimelineClipView(
                      key: GlobalObjectKey(clip.id),
                      clip: clip,
                      pixelsPerFrame: pixelsPerFrame,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
