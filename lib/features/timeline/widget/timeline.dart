import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voivo_movie_maker/features/timeline/controllers/timeline_editor.dart';
import 'package:voivo_movie_maker/features/timeline/providers.dart';
import 'package:voivo_movie_maker/features/timeline/widget/playhead.dart';
import 'package:voivo_movie_maker/features/timeline/widget/timeline_auto_scroller.dart';
import 'package:voivo_movie_maker/features/timeline/widget/timeline_ruler.dart';
import 'package:voivo_movie_maker/features/timeline/widget/timeline_track.dart';
import 'package:voivo_movie_maker/application/providers/playback_controller_provider.dart';

const _timelineDurationFrames = 3600;

class TimelinePane extends ConsumerStatefulWidget {
  const TimelinePane({super.key});

  @override
  ConsumerState<TimelinePane> createState() => _TimelinePaneState();
}

class _TimelinePaneState extends ConsumerState<TimelinePane> {
  final _horizontalScrollController = ScrollController();
  final _verticalScrollController = ScrollController();
  final _trackListKey = GlobalKey();
  final _timelineViewportKey = GlobalKey();

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
    final timeline = ref.watch(timelineInfoProvider);
    final timelineEditor = ref.read(timelineEditorProvider);
    final autoScroller = TimelineAutoScroller(
      viewportKey: _timelineViewportKey,
      horizontalScrollController: _horizontalScrollController,
      verticalScrollController: _verticalScrollController,
      timelineDurationFrames: _timelineDurationFrames,
    );

    return Expanded(
      child: KeyedSubtree(
        key: _timelineViewportKey,
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
                            autoScroller.frameAtGlobalPosition(
                              details.globalPosition,
                            ),
                          );
                        },
                        onHorizontalDragUpdate: (details) {
                          autoScroller.autoScrollForDrag(
                            details.globalPosition,
                            vertical: false,
                          );
                          playbackController.seek(
                            autoScroller.frameAtGlobalPosition(
                              details.globalPosition,
                            ),
                          );
                        },
                        child: const TimelineRuler(),
                      ),
                      Expanded(
                        child: Scrollbar(
                          controller: _verticalScrollController,
                          thumbVisibility: true,
                          child: ListView.builder(
                            key: _trackListKey,
                            controller: _verticalScrollController,
                            itemExtent: TimelineTrackView.height,
                            itemCount: timeline.tracks.length,
                            itemBuilder: (context, index) {
                              final track = timeline.tracks[index];
                              return TimelineTrackView(
                                track: track,
                                index: index,
                                trackCount: timeline.tracks.length,
                                trackListKey: _trackListKey,
                                horizontalScrollController:
                                    _horizontalScrollController,
                                trackScrollController:
                                    _verticalScrollController,
                                onAutoScroll: autoScroller.autoScrollForDrag,
                                onSeekFrame: playbackController.seek,
                                onAddClip: (startFrame) {
                                  timelineEditor.addNewClipToTrack(
                                    targetTrackIndex: index,
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
                    left: playbackState.currentFrame.toDouble() - 5,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onPanDown: (details) {
                        playbackController.seek(
                          autoScroller.frameAtGlobalPosition(
                            details.globalPosition,
                          ),
                        );
                      },
                      onHorizontalDragUpdate: (details) {
                        autoScroller.autoScrollForDrag(
                          details.globalPosition,
                          vertical: false,
                        );
                        playbackController.seek(
                          autoScroller.frameAtGlobalPosition(
                            details.globalPosition,
                          ),
                        );
                      },
                      child: const SizedBox(
                        width: 12,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              bottom: 0,
                              left: 5,
                              width: 2,
                              child: Playhead(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
