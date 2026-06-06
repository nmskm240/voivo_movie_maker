import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voivo_movie_maker/application/dtos/timeline_info.dart';
import 'package:voivo_movie_maker/application/services/playback_controller.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/playhead.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/timeline_ruler.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/timeline_track.dart';

class TimelineView extends ConsumerStatefulWidget {
  const TimelineView({super.key, required this.timeline});

  final TimelineInfo timeline;

  @override
  ConsumerState<TimelineView> createState() => _TimelineViewState();
}

class _TimelineViewState extends ConsumerState<TimelineView> {
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

    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Scrollbar(
                controller: _horizontalScrollController,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _horizontalScrollController,
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: constraints.maxWidth,
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onHorizontalDragUpdate: (details) {
                                playbackController.seek(
                                  details.localPosition.dx.toInt(),
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
                                  itemCount: widget.timeline.tracks.length,
                                  itemBuilder: (context, index) {
                                    final track = widget.timeline.tracks[index];
                                    return TimelineTrackView(track: track);
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
                            onHorizontalDragUpdate: (details) {
                              playbackController.seek(
                                playbackState.currentFrame +
                                    details.delta.dx.round(),
                              );
                            },
                            child: const Playhead(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
