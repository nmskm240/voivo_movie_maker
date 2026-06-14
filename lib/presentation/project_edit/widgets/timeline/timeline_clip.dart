// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:voivo_movie_maker/application/dtos/timeline_clip_info.dart';
import 'package:voivo_movie_maker/presentation/project_edit/states/timeline_select_state.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/timeline_drag_data.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/view_model.dart';

class TimelineClipView extends ConsumerStatefulWidget {
  const TimelineClipView({
    required this.clip,
    required this.pixelsPerFrame,
    super.key,
  });

  final TimelineClipInfo clip;
  final double pixelsPerFrame;

  @override
  ConsumerState<TimelineClipView> createState() => _TimelineClipViewState();
}

class _TimelineClipViewState extends ConsumerState<TimelineClipView> {
  double? _resizeStartGlobalX;
  int? _resizeStartFrame;
  int? _resizeDurationFrames;

  @override
  Widget build(BuildContext context) {
    final isSelected = ref.watch(
      timelineSelectionStateProvider.select(
        (state) => state.clipId == widget.clip.id,
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final clipBody = _ClipBody(clip: widget.clip, isSelected: isSelected);

        return Stack(
          fit: StackFit.expand,
          children: [
            Draggable<TimelineClipDragData>(
              data: TimelineClipDragData(widget.clip.id),
              maxSimultaneousDrags: 1,
              onDragStarted: () => ref
                  .read(timelineSelectionStateProvider.notifier)
                  .selectClip(widget.clip.id),
              feedback: Material(
                color: Colors.transparent,
                child: SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: _ClipBody(clip: widget.clip, isSelected: true),
                ),
              ),
              childWhenDragging: Opacity(opacity: 0.25, child: clipBody),
              child: GestureDetector(
                onTap: () => ref
                    .read(timelineSelectionStateProvider.notifier)
                    .selectClip(widget.clip.id),
                onLongPress: () => _confirmRemoveClip(context),
                child: MouseRegion(
                  cursor: SystemMouseCursors.grab,
                  child: clipBody,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: _ResizeHandle(
                key: ValueKey('${widget.clip.id.value}.resize-start'),
                onDragStart: _startResize,
                onDragUpdate: _resizeStart,
                onDragEnd: _endResize,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: _ResizeHandle(
                key: ValueKey('${widget.clip.id.value}.resize-end'),
                onDragStart: _startResize,
                onDragUpdate: _resizeEnd,
                onDragEnd: _endResize,
              ),
            ),
          ],
        );
      },
    );
  }

  void _startResize(DragStartDetails details) {
    _resizeStartGlobalX = details.globalPosition.dx;
    _resizeStartFrame = widget.clip.startFrame;
    _resizeDurationFrames = widget.clip.durationFrames;
    ref
        .read(timelineSelectionStateProvider.notifier)
        .selectClip(widget.clip.id);
  }

  void _resizeStart(DragUpdateDetails details) {
    final deltaFrames = _resizeDeltaFrames(details);
    final startFrame = _resizeStartFrame;
    final durationFrames = _resizeDurationFrames;
    if (deltaFrames == null || startFrame == null || durationFrames == null) {
      return;
    }

    final endFrame = startFrame + durationFrames;
    final nextStartFrame = (startFrame + deltaFrames).clamp(0, endFrame - 1);
    ref
        .read(timelineViewModelProvider.notifier)
        .resizeClip(
          widget.clip.id,
          startFrame: nextStartFrame,
          durationFrames: endFrame - nextStartFrame,
        );
  }

  void _resizeEnd(DragUpdateDetails details) {
    final deltaFrames = _resizeDeltaFrames(details);
    final startFrame = _resizeStartFrame;
    final durationFrames = _resizeDurationFrames;
    if (deltaFrames == null || startFrame == null || durationFrames == null) {
      return;
    }

    final nextDurationFrames = (durationFrames + deltaFrames).clamp(
      1,
      0x7fffffff,
    );
    ref
        .read(timelineViewModelProvider.notifier)
        .resizeClip(
          widget.clip.id,
          startFrame: startFrame,
          durationFrames: nextDurationFrames,
        );
  }

  int? _resizeDeltaFrames(DragUpdateDetails details) {
    final resizeStartGlobalX = _resizeStartGlobalX;
    if (resizeStartGlobalX == null) {
      return null;
    }
    return ((details.globalPosition.dx - resizeStartGlobalX) /
            widget.pixelsPerFrame)
        .round();
  }

  void _endResize(DragEndDetails details) {
    _resizeStartGlobalX = null;
    _resizeStartFrame = null;
    _resizeDurationFrames = null;
  }

  Future<void> _confirmRemoveClip(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove clip?'),
        content: Text(
          'Clip ${widget.clip.id.value} will be removed from the timeline.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      ref.read(timelineViewModelProvider.notifier).removeClip(widget.clip.id);
    }
  }
}

class _ResizeHandle extends StatelessWidget {
  const _ResizeHandle({
    required this.onDragStart,
    required this.onDragUpdate,
    required this.onDragEnd,
    super.key,
  });

  final GestureDragStartCallback onDragStart;
  final GestureDragUpdateCallback onDragUpdate;
  final GestureDragEndCallback onDragEnd;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.resizeLeftRight,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onHorizontalDragStart: onDragStart,
        onHorizontalDragUpdate: onDragUpdate,
        onHorizontalDragEnd: onDragEnd,
        child: const SizedBox(
          width: 8,
          height: double.infinity,
          child: Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x66000000),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: SizedBox.square(dimension: 6),
            ),
          ),
        ),
      ),
    );
  }
}

class _ClipBody extends StatelessWidget {
  const _ClipBody({required this.clip, required this.isSelected});

  final TimelineClipInfo clip;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isSelected ? Colors.white : Colors.greenAccent,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            clip.id.value,
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
    );
  }
}
