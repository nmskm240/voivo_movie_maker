// Dart imports:
import 'dart:math' as math;

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

// Project imports:
import 'package:voivo_movie_maker/application/services/playback_controller.dart';
import 'package:voivo_movie_maker/constants.dart';
import 'package:voivo_movie_maker/presentation/project_edit/states/timeline_select_state.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/playhead.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/timeline_auto_scroll.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/timeline_ruler.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/timeline_track.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/timeline_track_header.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/view_model.dart';

class TimelineView extends ConsumerStatefulWidget {
  const TimelineView({super.key});

  @override
  ConsumerState<TimelineView> createState() => _TimelineViewState();
}

class _TimelineViewState extends ConsumerState<TimelineView>
    with SingleTickerProviderStateMixin {
  static const _autoScrollEdgeWidth = 64.0;
  static const _maxAutoScrollSpeed = 900.0;

  final _horizontalScrollControllers = LinkedScrollControllerGroup();
  final _verticalScrollControllers = LinkedScrollControllerGroup();
  final _timelineViewportKey = GlobalKey();

  late final Ticker _autoScrollTicker;
  late final ScrollController _rulerHorizontalScrollController;
  late final ScrollController _bodyHorizontalScrollController;
  late final ScrollController _trackHeaderVerticalScrollController;
  late final ScrollController _bodyVerticalScrollController;
  double _minimumTimelineWidth = 0;
  double _extensionChunkWidth = 0;
  Offset? _dragGlobalPosition;
  ValueChanged<double>? _onAutoScroll;
  Duration? _lastAutoScrollElapsed;

  @override
  void initState() {
    super.initState();
    _autoScrollTicker = createTicker(_autoScroll);
    _rulerHorizontalScrollController = _horizontalScrollControllers.addAndGet();
    _bodyHorizontalScrollController = _horizontalScrollControllers.addAndGet();
    _bodyHorizontalScrollController.addListener(_extendTimelineIfNeeded);
    _trackHeaderVerticalScrollController = _verticalScrollControllers
        .addAndGet();
    _bodyVerticalScrollController = _verticalScrollControllers.addAndGet();
  }

  @override
  void dispose() {
    _autoScrollTicker.dispose();
    _bodyHorizontalScrollController.removeListener(_extendTimelineIfNeeded);
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
    final fps = ref.watch(
      playbackControllerProvider.select((playback) => playback.fps),
    );
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
          final minimumTimelineWidth =
              fps * timelineExtensionDuration.inSeconds * pixelsPerFrame;
          _extensionChunkWidth = minimumTimelineWidth;
          final durationFrames = timeline.tracks
              .expand((track) => track.clips)
              .fold(
                0,
                (duration, clip) =>
                    math.max(duration, clip.startFrame + clip.durationFrames),
              );
          final timelineWidth = math.max(
            availableTimelineWidth,
            math.max(
              durationFrames * pixelsPerFrame + 64,
              math.max(minimumTimelineWidth, _minimumTimelineWidth),
            ),
          );

          return ScrollConfiguration(
            behavior: ScrollConfiguration.of(
              context,
            ).copyWith(overscroll: false),
            child: Column(
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
                        physics: const ClampingScrollPhysics(),
                        child: SizedBox(
                          width: timelineWidth,
                          child: TimelineRulerGestureArea(
                            pixelsPerFrame: pixelsPerFrame,
                            onSeek: playbackController.seek,
                            onZoom: ref
                                .read(timelineViewModelProvider.notifier)
                                .setPixelsPerFrame,
                            child: TimelineRuler(
                              fps: fps,
                              pixelsPerFrame: pixelsPerFrame,
                            ),
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
                          physics: const ClampingScrollPhysics(),
                          itemCount: timeline.tracks.length,
                          itemBuilder: (context, index) => TimelineTrackHeader(
                            index: index,
                            selected: selectedTrackIndex == index,
                            onSelected: () => ref
                                .read(timelineSelectionStateProvider.notifier)
                                .selectTrack(index),
                            onAddClip: () => ref
                                .read(timelineViewModelProvider.notifier)
                                .addClip(index),
                          ),
                          separatorBuilder: (context, index) => const Divider(),
                        ),
                      ),
                      const VerticalDivider(),
                      Expanded(
                        child: NotificationListener<TimelineAutoScrollUpdate>(
                          onNotification: _handleAutoScrollUpdate,
                          child: NotificationListener<TimelineAutoScrollEnd>(
                            onNotification: _handleAutoScrollEnd,
                            child: SizedBox(
                              key: _timelineViewportKey,
                              child: Scrollbar(
                                controller: _bodyHorizontalScrollController,
                                thumbVisibility: true,
                                child: SingleChildScrollView(
                                  controller: _bodyHorizontalScrollController,
                                  scrollDirection: Axis.horizontal,
                                  physics: const ClampingScrollPhysics(),
                                  child: SizedBox(
                                    width: timelineWidth,
                                    child: Stack(
                                      children: [
                                        Scrollbar(
                                          controller:
                                              _bodyVerticalScrollController,
                                          thumbVisibility: true,
                                          child: ListView.separated(
                                            controller:
                                                _bodyVerticalScrollController,
                                            physics:
                                                const ClampingScrollPhysics(),
                                            itemCount: timeline.tracks.length,
                                            itemBuilder: (context, index) {
                                              final track =
                                                  timeline.tracks[index];
                                              return TimelineTrackView(
                                                trackIndex: index,
                                                track: track,
                                                pixelsPerFrame: pixelsPerFrame,
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    const Divider(),
                                          ),
                                        ),
                                        Playhead(
                                          pixelsPerFrame: pixelsPerFrame,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _extendTimelineIfNeeded() {
    if (!_bodyHorizontalScrollController.hasClients ||
        _extensionChunkWidth <= 0) {
      return;
    }

    final position = _bodyHorizontalScrollController.position;
    if (position.extentAfter > _extensionChunkWidth / 20) {
      return;
    }

    final nextWidth =
        position.maxScrollExtent +
        position.viewportDimension +
        _extensionChunkWidth;
    if (nextWidth <= _minimumTimelineWidth) {
      return;
    }
    setState(() => _minimumTimelineWidth = nextWidth);
  }

  bool _handleAutoScrollUpdate(TimelineAutoScrollUpdate notification) {
    _dragGlobalPosition = notification.globalPosition;
    _onAutoScroll = notification.onScroll;
    if (!_autoScrollTicker.isActive) {
      _lastAutoScrollElapsed = null;
      _autoScrollTicker.start();
    }
    return false;
  }

  bool _handleAutoScrollEnd(TimelineAutoScrollEnd notification) {
    _dragGlobalPosition = null;
    _onAutoScroll = null;
    _lastAutoScrollElapsed = null;
    _autoScrollTicker.stop();
    return false;
  }

  void _autoScroll(Duration elapsed) {
    final dragPosition = _dragGlobalPosition;
    final viewportContext = _timelineViewportKey.currentContext;
    if (dragPosition == null ||
        viewportContext == null ||
        !_bodyHorizontalScrollController.hasClients) {
      return;
    }

    final lastElapsed = _lastAutoScrollElapsed;
    _lastAutoScrollElapsed = elapsed;
    if (lastElapsed == null) {
      return;
    }

    final viewport = viewportContext.findRenderObject()! as RenderBox;
    final localX = viewport.globalToLocal(dragPosition).dx;
    final direction = switch (localX) {
      < _autoScrollEdgeWidth => -1.0 + localX / _autoScrollEdgeWidth,
      _ when localX > viewport.size.width - _autoScrollEdgeWidth =>
        1.0 -
            (viewport.size.width - localX).clamp(0, _autoScrollEdgeWidth) /
                _autoScrollEdgeWidth,
      _ => 0.0,
    }.clamp(-1.0, 1.0);
    if (direction == 0) {
      _lastAutoScrollElapsed = null;
      _autoScrollTicker.stop();
      return;
    }

    final deltaSeconds =
        (elapsed - lastElapsed).inMicroseconds / Duration.microsecondsPerSecond;
    final position = _bodyHorizontalScrollController.position;
    final currentOffset = _bodyHorizontalScrollController.offset;
    final nextOffset =
        (currentOffset + direction * _maxAutoScrollSpeed * deltaSeconds).clamp(
          position.minScrollExtent,
          position.maxScrollExtent,
        );
    _bodyHorizontalScrollController.jumpTo(nextOffset);
    _onAutoScroll?.call(nextOffset - currentOffset);
  }
}
