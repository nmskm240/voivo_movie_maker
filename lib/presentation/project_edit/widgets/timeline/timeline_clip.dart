// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:voivo_movie_maker/application/dtos/timeline_clip_info.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';
import 'package:voivo_movie_maker/presentation/project_edit/states/timeline_select_state.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/view_model.dart';

class TimelineClipDragData {
  const TimelineClipDragData(this.clipId);

  final TimelineClipId clipId;
}

class TimelineClipView extends ConsumerStatefulWidget {
  const TimelineClipView({required this.clip, super.key});

  final TimelineClipInfo clip;

  @override
  ConsumerState<TimelineClipView> createState() => _TimelineClipViewState();
}

class _TimelineClipViewState extends ConsumerState<TimelineClipView> {
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

        return Draggable<TimelineClipDragData>(
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
        );
      },
    );
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
