import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voivo_movie_maker/application/dtos/timeline_clip_info.dart';
import 'package:voivo_movie_maker/application/providers/timeline_clip_editor_provider.dart';

class TimelineClipView extends ConsumerStatefulWidget {
  const TimelineClipView({
    required this.trackIndex,
    required this.clip,
    super.key,
  });

  final int trackIndex;
  final TimelineClipInfo clip;

  static const _handleWidth = 8.0;

  @override
  ConsumerState<TimelineClipView> createState() => _TimelineClipViewState();
}

class _TimelineClipViewState extends ConsumerState<TimelineClipView> {
  double _dragStartGlobalX = 0;
  int _dragStartFrame = 0;
  int _dragStartDurationFrames = 1;
  int _dragStartEndFrame = 1;

  @override
  Widget build(BuildContext context) {
    final editor = ref.read(
      timelineClipEditorProvider((
        trackIndex: widget.trackIndex,
        clipId: widget.clip.id,
      )),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xff78c257),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xffb7eaa0)),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onHorizontalDragStart: _startDrag,
              onHorizontalDragUpdate: (details) {
                editor.moveTo(_dragStartFrame + _deltaFrames(details));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.clip.id,
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
              final startFrame = (_dragStartFrame + _deltaFrames(details))
                  .clamp(0, _dragStartEndFrame - 1);
              editor.resizeTo(
                startFrame: startFrame,
                durationFrames: _dragStartEndFrame - startFrame,
              );
            },
          ),
          _ResizeHandle(
            side: _ResizeHandleSide.end,
            onDragStart: _startDrag,
            onDragUpdate: (details) {
              final nextDurationFrames =
                  _dragStartDurationFrames + _deltaFrames(details);
              editor.resizeTo(
                startFrame: _dragStartFrame,
                durationFrames: nextDurationFrames < 1 ? 1 : nextDurationFrames,
              );
            },
          ),
        ],
      ),
    );
  }

  void _startDrag(DragStartDetails details) {
    _dragStartGlobalX = details.globalPosition.dx;
    _dragStartFrame = widget.clip.startFrame;
    _dragStartDurationFrames = widget.clip.durationFrames;
    _dragStartEndFrame = widget.clip.startFrame + widget.clip.durationFrames;
  }

  int _deltaFrames(DragUpdateDetails details) {
    return (details.globalPosition.dx - _dragStartGlobalX).round();
  }
}

class _ResizeHandle extends StatelessWidget {
  const _ResizeHandle({
    required this.side,
    required this.onDragStart,
    required this.onDragUpdate,
  });

  final _ResizeHandleSide side;
  final GestureDragStartCallback onDragStart;
  final GestureDragUpdateCallback onDragUpdate;

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
        child: const DecoratedBox(
          decoration: BoxDecoration(color: Color(0x44ffffff)),
        ),
      ),
    );
  }
}

enum _ResizeHandleSide { start, end }
