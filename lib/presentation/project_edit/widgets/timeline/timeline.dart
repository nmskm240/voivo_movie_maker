import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:voivo_movie_maker/application/services/playback_controller.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';
import 'package:voivo_movie_maker/presentation/project_edit/states/timeline_select_state.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/playhead.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/timeline_ruler.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/timeline_track.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/timeline_track_header.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/view_model.dart';

class TimelineView extends ConsumerStatefulWidget {
  const TimelineView({super.key});

  @override
  ConsumerState<TimelineView> createState() => _TimelineViewState();
}

class _TimelineViewState extends ConsumerState<TimelineView> {
  final _horizontalScrollControllers = LinkedScrollControllerGroup();
  final _verticalScrollControllers = LinkedScrollControllerGroup();

  late final ScrollController _rulerHorizontalScrollController;
  late final ScrollController _bodyHorizontalScrollController;
  late final ScrollController _trackHeaderVerticalScrollController;
  late final ScrollController _bodyVerticalScrollController;

  @override
  void initState() {
    super.initState();
    _rulerHorizontalScrollController = _horizontalScrollControllers.addAndGet();
    _bodyHorizontalScrollController = _horizontalScrollControllers.addAndGet();
    _bodyHorizontalScrollController.addListener(_syncHorizontalScrollOffset);
    _trackHeaderVerticalScrollController = _verticalScrollControllers
        .addAndGet();
    _bodyVerticalScrollController = _verticalScrollControllers.addAndGet();
  }

  @override
  void dispose() {
    _bodyHorizontalScrollController.removeListener(_syncHorizontalScrollOffset);
    _rulerHorizontalScrollController.dispose();
    _bodyHorizontalScrollController.dispose();
    _trackHeaderVerticalScrollController.dispose();
    _bodyVerticalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timelineState = ref.watch(
      timelineViewModelProvider.select(
        (state) => state.whenData(
          (state) =>
              (timeline: state.timeline, pixelsPerFrame: state.pixelsPerFrame),
        ),
      ),
    );
    final playbackState = ref.watch(playbackControllerProvider);
    final playbackController = ref.read(playbackControllerProvider.notifier);
    final selectedTrackIndex = ref.watch(
      timelineSelectionStateProvider.select(
        (selection) => selection.trackIndex,
      ),
    );

    return timelineState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      data: (timelineState) => LayoutBuilder(
        builder: (context, constraints) {
          final timeline = timelineState.timeline;
          final pixelsPerFrame = timelineState.pixelsPerFrame;
          final availableTimelineWidth =
              constraints.maxWidth - TimelineTrackHeader.width;
          final durationFrames = timeline.tracks
              .expand((track) => track.clips)
              .fold(
                0,
                (duration, clip) =>
                    math.max(duration, clip.startFrame + clip.durationFrames),
              );
          final timelineWidth = math.max(
            availableTimelineWidth,
            durationFrames * pixelsPerFrame + 64,
          );

          return Column(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: TimelineTrackHeader.width,
                    height: TimelineRuler.height,
                  ),
                  const VerticalDivider(),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _rulerHorizontalScrollController,
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: timelineWidth,
                        child: TimelineRulerGestureArea(
                          pixelsPerFrame: pixelsPerFrame,
                          onSeek: playbackController.seek,
                          onZoom: ref
                              .read(timelineViewModelProvider.notifier)
                              .setPixelsPerFrame,
                          child: TimelineRuler(pixelsPerFrame: pixelsPerFrame),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      width: TimelineTrackHeader.width,
                      child: ListView.separated(
                        controller: _trackHeaderVerticalScrollController,
                        itemCount: timeline.tracks.length,
                        itemBuilder: (context, index) => TimelineTrackHeader(
                          index: index,
                          selected: selectedTrackIndex == index,
                          onSelected: () => ref
                              .read(timelineSelectionStateProvider.notifier)
                              .selectTrack(index),
                          onAddClip: () => _showAddClipSheet(index),
                        ),
                        separatorBuilder: (context, index) => const Divider(),
                      ),
                    ),
                    const VerticalDivider(),
                    Expanded(
                      child: Scrollbar(
                        controller: _bodyHorizontalScrollController,
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                          controller: _bodyHorizontalScrollController,
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: timelineWidth,
                            child: Stack(
                              children: [
                                Scrollbar(
                                  controller: _bodyVerticalScrollController,
                                  thumbVisibility: true,
                                  child: ListView.separated(
                                    controller: _bodyVerticalScrollController,
                                    itemCount: timeline.tracks.length,
                                    itemBuilder: (context, index) {
                                      final track = timeline.tracks[index];
                                      return TimelineTrackView(
                                        track: track,
                                        pixelsPerFrame: pixelsPerFrame,
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const Divider(),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  left:
                                      playbackState.currentFrame *
                                          pixelsPerFrame -
                                      5,
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onHorizontalDragUpdate: (details) {
                                      playbackController.seek(
                                        playbackState.currentFrame +
                                            (details.delta.dx / pixelsPerFrame)
                                                .round(),
                                      );
                                    },
                                    child: const Playhead(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _syncHorizontalScrollOffset() {
    ref
        .read(timelineViewModelProvider.notifier)
        .setHorizontalScrollOffset(_bodyHorizontalScrollController.offset);
  }

  Future<void> _showAddClipSheet(int trackIndex) async {
    ref.read(timelineSelectionStateProvider.notifier).selectTrack(trackIndex);

    final kind = await showModalBottomSheet<TimelineClipKind>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ClipKindTile(
                kind: TimelineClipKind.text,
                icon: Icons.text_fields,
                label: 'Text',
              ),
              _ClipKindTile(
                kind: TimelineClipKind.image,
                icon: Icons.image_outlined,
                label: 'Image',
              ),
              _ClipKindTile(
                kind: TimelineClipKind.audio,
                icon: Icons.graphic_eq,
                label: 'Audio',
              ),
            ],
          ),
        );
      },
    );
    if (!mounted || kind == null) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Track ${trackIndex + 1} に ${kind.name} clip を追加するUIを選択しました',
        ),
      ),
    );
  }
}

class _ClipKindTile extends StatelessWidget {
  const _ClipKindTile({
    required this.kind,
    required this.icon,
    required this.label,
  });

  final TimelineClipKind kind;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () => Navigator.of(context).pop(kind),
    );
  }
}
