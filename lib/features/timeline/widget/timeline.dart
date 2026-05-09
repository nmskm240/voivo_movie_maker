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
  final _horizontalScrollController = ScrollController();
  final _verticalScrollController = ScrollController();

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    _verticalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final playbackState = ref.watch(playbackControllerProvider);
    final playbackController = ref.read(playbackControllerProvider.notifier);
    final timeline = ref.watch(timelineEditorProvider);
    final timelineEditor = ref.read(timelineEditorProvider.notifier);

    return Expanded(
      child: Scrollbar(
        controller: _horizontalScrollController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: _horizontalScrollController,
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: _timelineDurationFrames.toDouble(),
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
                    Expanded(
                      child: Scrollbar(
                        controller: _verticalScrollController,
                        thumbVisibility: true,
                        child: ListView.builder(
                          controller: _verticalScrollController,
                          itemExtent: TimelineTrackView.height,
                          itemCount: timeline.tracks.length,
                          itemBuilder: (context, index) {
                            final track = timeline.tracks[index];
                            return TimelineTrackView(
                              track: track,
                              index: index,
                              onSeekFrame: playbackController.seek,
                              onAddClip: (startFrame) {
                                timelineEditor.addTextClip(
                                  trackIndex: index,
                                  startFrame: startFrame,
                                );
                              },
                            );
                          },
                        ),
                      ),
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
