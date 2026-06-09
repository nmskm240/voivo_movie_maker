import 'package:flutter/material.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/timeline_track.dart';

class TimelineTrackHeader extends StatelessWidget {
  const TimelineTrackHeader({
    required this.index,
    required this.selected,
    required this.onSelected,
    required this.onAddClip,
    super.key,
  });

  final int index;
  final bool selected;
  final VoidCallback onSelected;
  final VoidCallback onAddClip;

  static const width = 120.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: TimelineTrackView.height,
      child: Material(
        color: selected
            ? Theme.of(context).colorScheme.secondaryContainer
            : Theme.of(context).colorScheme.surfaceContainer,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: onSelected,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Track ${index + 1}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: selected
                            ? Theme.of(context).colorScheme.onSecondaryContainer
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: onAddClip,
              tooltip: 'Add clip to Track ${index + 1}',
              icon: const Icon(Icons.add, size: 18),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            ),
          ],
        ),
      ),
    );
  }
}
