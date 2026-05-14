import 'package:flutter/material.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/text_clip.dart';
import 'package:voivo_movie_maker/features/inspector/widget/inspector_controls.dart';
import 'package:voivo_movie_maker/features/inspector/widget/text_clip_inspector.dart';

class SelectedClipInspector extends StatelessWidget {
  const SelectedClipInspector({required this.clip, super.key});

  final TimelineClip clip;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          clip.id.value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        InspectorReadOnlyField(
          label: 'Start',
          value: clip.startFrame.toString(),
        ),
        const SizedBox(height: 10),
        InspectorReadOnlyField(
          label: 'Duration',
          value: clip.durationFrames.toString(),
        ),
        const SizedBox(height: 18),
        switch (clip) {
          final TextClip clip => TextClipInspector(clipId: clip.id, clip: clip),
          _ => const SizedBox.shrink(),
        },
      ],
    );
  }
}
