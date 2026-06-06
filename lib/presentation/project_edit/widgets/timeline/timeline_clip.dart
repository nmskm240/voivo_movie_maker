import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voivo_movie_maker/application/dtos/timeline_clip_info.dart';
import 'package:voivo_movie_maker/presentation/project_edit/states/timeline_select_state.dart';

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

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isSelected ? Colors.white : Colors.greenAccent,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
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
        ],
      ),
    );
  }
}
