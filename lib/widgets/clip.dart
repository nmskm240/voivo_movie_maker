import 'package:flutter/material.dart';

import '../models/timeline.dart';

class TimelineClipView extends StatelessWidget {
  const TimelineClipView({
    super.key,
    required this.clip,
    required this.selected,
    required this.onTap,
  });

  final TimelineClip clip;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: clip.color,
            border: Border.all(
              color: selected ? Colors.white : Colors.black26,
              width: selected ? 2 : 1,
            ),
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            clip.title,
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
