import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voivo_movie_maker/features/timeline/widget/playhead.dart';
import 'package:voivo_movie_maker/features/timeline/widget/timeline_ruler.dart';
import 'package:voivo_movie_maker/features/timeline/widget/timeline_track.dart';
import 'package:voivo_movie_maker/application/providers/playback_controller_provider.dart';
import 'package:voivo_movie_maker/application/providers/timeline_editor_provider.dart';

const _timelineDurationFrames = 3600;

class TimelinePane extends ConsumerStatefulWidget {
  const TimelinePane({super.key});

  @override
  ConsumerState<TimelinePane> createState() => _TimelinePaneState();
}

class _TimelinePaneState extends ConsumerState<TimelinePane> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final playbackState = ref.watch(playbackControllerProvider);
    final playbackController = ref.read(playbackControllerProvider.notifier);
    final timeline = ref.watch(timelineEditorProvider);
    final timelineEditor = ref.read(timelineEditorProvider.notifier);
    final tracksHeight = timeline.tracks.length * TimelineTrackView.height;

    return Expanded(
      child: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: _timelineDurationFrames.toDouble(),
            height: TimelineRuler.height + tracksHeight,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onPanDown: (details) {
                        playbackController.seek(
                          details.localPosition.dx.floor(),
                        );
                      },
                      onHorizontalDragUpdate: (details) {
                        playbackController.seek(
                          details.localPosition.dx.floor(),
                        );
                      },
                      child: const TimelineRuler(),
                    ),
                    for (final (trackIndex, track) in timeline.tracks.indexed)
                      TimelineTrackView(
                        track: track,
                        index: trackIndex,
                        onSeekFrame: playbackController.seek,
                        onAddClip: (startFrame) {
                          timelineEditor.addTextClip(
                            trackIndex: trackIndex,
                            startFrame: startFrame,
                          );
                        },
                      ),
                  ],
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: playbackState.currentFrame.toDouble(),
                  child: const IgnorePointer(child: Playhead()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
