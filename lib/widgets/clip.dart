import 'package:flutter/material.dart';

import '../models/timeline.dart';

class TimelineClipView extends StatefulWidget {
  const TimelineClipView({
    super.key,
    required this.clip,
    required this.selected,
    required this.timelineDurationFrames,
    required this.trackWidth,
    required this.onTap,
    required this.onDragStart,
    required this.onDragFrame,
  });

  final TextClip clip;
  final bool selected;
  final int timelineDurationFrames;
  final double trackWidth;
  final VoidCallback onTap;
  final VoidCallback onDragStart;
  final ValueChanged<int> onDragFrame;

  @override
  State<TimelineClipView> createState() => _TimelineClipViewState();
}

class _TimelineClipViewState extends State<TimelineClipView> {
  var _dragStartGlobalX = 0.0;
  var _dragStartFrame = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: ValueKey('timeline-clip-${widget.clip.id}'),
      onTap: widget.onTap,
      onHorizontalDragStart: (details) {
        _dragStartGlobalX = details.globalPosition.dx;
        _dragStartFrame = widget.clip.startFrame;
        widget.onDragStart();
      },
      onHorizontalDragUpdate: (details) {
        if (widget.trackWidth <= 0 || widget.timelineDurationFrames <= 0) {
          return;
        }

        final deltaX = details.globalPosition.dx - _dragStartGlobalX;
        final deltaFrames =
            (deltaX / widget.trackWidth * widget.timelineDurationFrames)
                .round();
        widget.onDragFrame(_dragStartFrame + deltaFrames);
      },
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: widget.clip.textColor,
            border: Border.all(
              color: widget.selected ? Colors.white : Colors.black26,
              width: widget.selected ? 2 : 1,
            ),
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            widget.clip.name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xff111416),
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
