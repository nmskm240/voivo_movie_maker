// Dart imports:
import 'dart:math' as math;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:voivo_movie_maker/application/dtos/timeline_clip_info.dart';
import 'package:voivo_movie_maker/presentation/project_edit/states/timeline_select_state.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/timeline_auto_scroll.dart';
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
  double _resizeAutoScrollOffset = 0;
  double? _resizeGlobalX;
  int? _resizeStartFrame;
  int? _resizeDurationFrames;
  bool _resizingStart = false;

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
          clipBehavior: Clip.none,
          children: [
            Draggable<TimelineClipDragData>(
              data: TimelineClipDragData(widget.clip.id),
              maxSimultaneousDrags: 1,
              onDragStarted: () => ref
                  .read(timelineSelectionStateProvider.notifier)
                  .selectClip(widget.clip.id),
              onDragUpdate: (details) {
                TimelineAutoScrollUpdate(
                  details.globalPosition,
                ).dispatch(context);
              },
              onDragEnd: (_) => const TimelineAutoScrollEnd().dispatch(context),
              onDraggableCanceled: (_, _) =>
                  const TimelineAutoScrollEnd().dispatch(context),
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
                gripKey: ValueKey('${widget.clip.id.value}.resize-start-grip'),
                gripAlignment: Alignment.centerLeft,
                onDragStart: _startResize,
                onDragUpdate: _resizeStart,
                onDragEnd: _endResize,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: _ResizeHandle(
                key: ValueKey('${widget.clip.id.value}.resize-end'),
                gripKey: ValueKey('${widget.clip.id.value}.resize-end-grip'),
                gripAlignment: Alignment.centerRight,
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
    _resizeAutoScrollOffset = 0;
    _resizeGlobalX = details.globalPosition.dx;
    _resizeStartFrame = widget.clip.startFrame;
    _resizeDurationFrames = widget.clip.durationFrames;
    ref
        .read(timelineSelectionStateProvider.notifier)
        .selectClip(widget.clip.id);
  }

  void _resizeStart(DragUpdateDetails details) {
    _resizingStart = true;
    _resizeGlobalX = details.globalPosition.dx;
    TimelineAutoScrollUpdate(
      details.globalPosition,
      onScroll: _applyResizeAutoScroll,
    ).dispatch(context);
    _applyResizeStart();
  }

  void _applyResizeStart() {
    final deltaFrames = _resizeDeltaFrames();
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
    _resizingStart = false;
    _resizeGlobalX = details.globalPosition.dx;
    TimelineAutoScrollUpdate(
      details.globalPosition,
      onScroll: _applyResizeAutoScroll,
    ).dispatch(context);
    _applyResizeEnd();
  }

  void _applyResizeEnd() {
    final deltaFrames = _resizeDeltaFrames();
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

  int? _resizeDeltaFrames() {
    final resizeStartGlobalX = _resizeStartGlobalX;
    final resizeGlobalX = _resizeGlobalX;
    if (resizeStartGlobalX == null || resizeGlobalX == null) {
      return null;
    }
    return ((resizeGlobalX - resizeStartGlobalX + _resizeAutoScrollOffset) /
            widget.pixelsPerFrame)
        .round();
  }

  void _applyResizeAutoScroll(double delta) {
    _resizeAutoScrollOffset += delta;
    if (_resizingStart) {
      _applyResizeStart();
    } else {
      _applyResizeEnd();
    }
  }

  void _endResize(DragEndDetails details) {
    const TimelineAutoScrollEnd().dispatch(context);
    _resizeStartGlobalX = null;
    _resizeAutoScrollOffset = 0;
    _resizeGlobalX = null;
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
    required this.gripKey,
    required this.gripAlignment,
    required this.onDragStart,
    required this.onDragUpdate,
    required this.onDragEnd,
    super.key,
  });

  final Key gripKey;
  final Alignment gripAlignment;
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
        child: SizedBox(
          width: 24,
          height: double.infinity,
          child: Align(
            alignment: gripAlignment,
            child: FractionalTranslation(
              translation: Offset(gripAlignment.x / 2, 0),
              child: DecoratedBox(
                key: gripKey,
                decoration: const BoxDecoration(
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
                child: const SizedBox.square(dimension: 6),
              ),
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
    final color = clip.hasAudio ? const Color(0xff79d7ff) : Colors.greenAccent;
    final textColor = clip.hasAudio
        ? const Color(0xff082332)
        : const Color(0xff10210c);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isSelected ? Colors.white : color,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (clip.hasAudio)
              CustomPaint(
                painter: _AudioWaveformPainter(
                  color: textColor.withValues(alpha: 0.2),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  clip.id.value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AudioWaveformPainter extends CustomPainter {
  const _AudioWaveformPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) {
      return;
    }
    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;
    const spacing = 6.0;
    final centerY = size.height / 2;
    final maxAmplitude = size.height * 0.34;
    for (var x = 8.0; x < size.width - 8; x += spacing) {
      final progress = x / size.width;
      final wave =
          0.35 +
          0.45 * (0.5 + 0.5 * math.sin(progress * 18.8495559215)) +
          0.20 * (0.5 + 0.5 * math.sin(progress * 43.9822971503));
      final amplitude = (wave.clamp(0.18, 1.0)) * maxAmplitude;
      canvas.drawLine(
        Offset(x, centerY - amplitude),
        Offset(x, centerY + amplitude),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _AudioWaveformPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
