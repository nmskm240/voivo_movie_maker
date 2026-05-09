import 'package:flutter/material.dart';
import 'package:voivo_movie_maker/application/dtos/timeline_clip_info.dart';

class TimelineClipView extends StatelessWidget {
  const TimelineClipView({
    required this.clip,
    required this.onMoveStart,
    required this.onMoveUpdate,
    required this.onStartResizeStart,
    required this.onStartResizeUpdate,
    required this.onEndResizeStart,
    required this.onEndResizeUpdate,
    super.key,
  });

  final TimelineClipInfo clip;
  final GestureDragStartCallback onMoveStart;
  final GestureDragUpdateCallback onMoveUpdate;
  final GestureDragStartCallback onStartResizeStart;
  final GestureDragUpdateCallback onStartResizeUpdate;
  final GestureDragStartCallback onEndResizeStart;
  final GestureDragUpdateCallback onEndResizeUpdate;

  static const _handleWidth = 8.0;

  @override
  Widget build(BuildContext context) {
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
              onHorizontalDragStart: onMoveStart,
              onHorizontalDragUpdate: onMoveUpdate,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    clip.id,
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
            onDragStart: onStartResizeStart,
            onDragUpdate: onStartResizeUpdate,
          ),
          _ResizeHandle(
            side: _ResizeHandleSide.end,
            onDragStart: onEndResizeStart,
            onDragUpdate: onEndResizeUpdate,
          ),
        ],
      ),
    );
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
