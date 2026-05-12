import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voivo_movie_maker/application/providers/loaded_project_provider.dart';
import 'package:voivo_movie_maker/application/providers/playback_controller_provider.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';

class ProjectPreviewPane extends ConsumerWidget {
  const ProjectPreviewPane({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(loadedProjectProvider).project;
    final currentFrame = ref.watch(
      playbackControllerProvider.select((state) => state.currentFrame),
    );
    final activeClips = project.timeline
        .getActiveClipsAt(currentFrame)
        .toList();

    return ColoredBox(
      color: const Color(0xff18181b),
      child: Center(
        child: AspectRatio(
          aspectRatio: project.width / project.height,
          child: ClipRect(
            child: ColoredBox(
              color: Colors.black,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  for (final clip in activeClips) _PreviewClip(clip: clip),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PreviewClip extends StatelessWidget {
  const _PreviewClip({required this.clip});

  final TimelineClip clip;

  @override
  Widget build(BuildContext context) {
    return switch (clip) {
      final TextClip clip => _PreviewText(clip: clip),
      _ => const SizedBox.shrink(),
    };
  }
}

class _PreviewText extends StatelessWidget {
  const _PreviewText({required this.clip});

  final TextClip clip;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        clip.text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: clip.color,
          fontFamily: clip.fontFamily,
          fontSize: clip.size,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
