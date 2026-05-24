import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voivo_movie_maker/application/controllers/timeline_editor/commands/move_clip_command.dart';
import 'package:voivo_movie_maker/application/controllers/timeline_editor/commands/resize_clip_command.dart';
import 'package:voivo_movie_maker/application/controllers/timeline_editor/timeline_editor.dart';
import 'package:voivo_movie_maker/application/dtos/timeline_clip_info.dart';
import 'package:voivo_movie_maker/application/providers/loaded_project_provider.dart';
import 'package:voivo_movie_maker/features/inspector/providers.dart';

class TimelineClipView extends ConsumerStatefulWidget {
  const TimelineClipView({
    required this.trackIndex,
    required this.trackCount,
    required this.trackListKey,
    required this.horizontalScrollController,
    required this.trackScrollController,
    required this.trackHeight,
    required this.onAutoScroll,
    required this.clip,
    super.key,
  });

  final int trackIndex;
  final int trackCount;
  final GlobalKey trackListKey;
  final ScrollController horizontalScrollController;
  final ScrollController trackScrollController;
  final double trackHeight;
  final void Function(Offset globalPosition, {bool horizontal, bool vertical})
  onAutoScroll;
  final TimelineClipInfo clip;

  static const _handleWidth = 8.0;

  @override
  ConsumerState<TimelineClipView> createState() => _TimelineClipViewState();
}

class _TimelineClipViewState extends ConsumerState<TimelineClipView> {
  double _dragStartGlobalX = 0;
  double _dragStartHorizontalScrollOffset = 0;
  int _dragStartFrame = 0;
  int _dragStartDurationFrames = 1;
  int _dragStartEndFrame = 1;

  @override
  Widget build(BuildContext context) {
    final editor = ref.watch(timelineEditorProvider);
    final selectedClipId = ref.watch(selectedTimelineClipIdProvider);
    final isSelected = selectedClipId == widget.clip.id;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xff78c257),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isSelected ? const Color(0xffffffff) : const Color(0xffb7eaa0),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _selectClip,
              onPanStart: _startDrag,
              onPanUpdate: (details) {
                widget.onAutoScroll(details.globalPosition);
                editor.execute(
                  MoveClipCommand(
                    widget.clip.id,
                    startFrame: _dragStartFrame + _deltaFrames(details),
                    targetTrackIndex: _trackIndexAt(details.globalPosition),
                  ),
                  save: false,
                );
              },
              onPanEnd: (_) => _saveProject(),
              onPanCancel: _saveProject,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.clip.id.value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xff10210c),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
          _ResizeHandle(
            side: _ResizeHandleSide.start,
            onDragStart: _startDrag,
            onDragUpdate: (details) {
              widget.onAutoScroll(details.globalPosition, vertical: false);
              final startFrame = (_dragStartFrame + _deltaFrames(details))
                  .clamp(0, _dragStartEndFrame - 1);
              editor.execute(
                ResizeClipCommand(
                  widget.clip.id,
                  startFrame: startFrame,
                  durationFrames: _dragStartEndFrame - startFrame,
                ),
                save: false,
              );
            },
            onDragEnd: (_) => _saveProject(),
            onDragCancel: _saveProject,
          ),
          _ResizeHandle(
            side: _ResizeHandleSide.end,
            onDragStart: _startDrag,
            onDragUpdate: (details) {
              widget.onAutoScroll(details.globalPosition, vertical: false);
              final nextDurationFrames =
                  _dragStartDurationFrames + _deltaFrames(details);
              editor.execute(
                ResizeClipCommand(
                  widget.clip.id,
                  startFrame: _dragStartFrame,
                  durationFrames: nextDurationFrames < 1
                      ? 1
                      : nextDurationFrames,
                ),
                save: false,
              );
            },
            onDragEnd: (_) => _saveProject(),
            onDragCancel: _saveProject,
          ),
        ],
      ),
    );
  }

  void _startDrag(DragStartDetails details) {
    _selectClip();
    _dragStartGlobalX = details.globalPosition.dx;
    _dragStartHorizontalScrollOffset =
        widget.horizontalScrollController.hasClients
        ? widget.horizontalScrollController.offset
        : 0;
    _dragStartFrame = widget.clip.startFrame;
    _dragStartDurationFrames = widget.clip.durationFrames;
    _dragStartEndFrame = widget.clip.startFrame + widget.clip.durationFrames;
  }

  int _deltaFrames(DragUpdateDetails details) {
    final scrollDelta = widget.horizontalScrollController.hasClients
        ? widget.horizontalScrollController.offset -
              _dragStartHorizontalScrollOffset
        : 0;
    return (details.globalPosition.dx - _dragStartGlobalX + scrollDelta)
        .round();
  }

  int _trackIndexAt(Offset globalPosition) {
    final context = widget.trackListKey.currentContext;
    if (context == null || widget.trackCount == 0) {
      return widget.trackIndex;
    }

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      return widget.trackIndex;
    }

    final localPosition = renderBox.globalToLocal(globalPosition);
    final scrollOffset = widget.trackScrollController.hasClients
        ? widget.trackScrollController.offset
        : 0.0;
    return ((localPosition.dy + scrollOffset) / widget.trackHeight)
        .floor()
        .clamp(0, widget.trackCount - 1);
  }

  void _selectClip() {
    ref.read(selectedTimelineClipIdProvider.notifier).select(widget.clip.id);
  }

  void _saveProject() {
    ref.read(loadedProjectProvider.notifier).save();
  }
}

class _ResizeHandle extends StatelessWidget {
  const _ResizeHandle({
    required this.side,
    required this.onDragStart,
    required this.onDragUpdate,
    required this.onDragEnd,
    required this.onDragCancel,
  });

  final _ResizeHandleSide side;
  final GestureDragStartCallback onDragStart;
  final GestureDragUpdateCallback onDragUpdate;
  final GestureDragEndCallback onDragEnd;
  final GestureDragCancelCallback onDragCancel;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      bottom: 0,
      left: side == _ResizeHandleSide.start ? 0 : null,
      right: side == _ResizeHandleSide.end ? 0 : null,
      width: TimelineClipView._handleWidth,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onHorizontalDragStart: onDragStart,
        onHorizontalDragUpdate: onDragUpdate,
        onHorizontalDragEnd: onDragEnd,
        onHorizontalDragCancel: onDragCancel,
        child: const DecoratedBox(
          decoration: BoxDecoration(color: Color(0x44ffffff)),
        ),
      ),
    );
  }
}

enum _ResizeHandleSide { start, end }
