import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voivo_movie_maker/application/providers/loaded_project_provider.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/features/inspector/providers.dart';
import 'package:voivo_movie_maker/features/inspector/widget/empty_inspector.dart';
import 'package:voivo_movie_maker/features/inspector/widget/selected_clip_inspector.dart';

class ClipInspectorPane extends ConsumerWidget {
  const ClipInspectorPane({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedClipId = ref.watch(selectedTimelineClipIdProvider);
    final project = ref.watch(loadedProjectProvider).project;
    final clip = selectedClipId == null
        ? null
        : _findClip(
            project.timeline.tracks.expand((track) => track.clips),
            selectedClipId,
          );

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Color(0xff202124),
        border: Border(left: BorderSide(color: Color(0xff34363a))),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: clip == null
            ? const EmptyInspector()
            : SelectedClipInspector(clip: clip),
      ),
    );
  }

  TimelineClip? _findClip(Iterable<TimelineClip> clips, String clipId) {
    for (final clip in clips) {
      if (clip.id == clipId) {
        return clip;
      }
    }
    return null;
  }
}
