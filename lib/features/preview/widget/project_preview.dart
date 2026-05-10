import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voivo_movie_maker/application/providers/loaded_project_provider.dart';
import 'package:voivo_movie_maker/application/providers/playback_controller_provider.dart';
import 'package:voivo_movie_maker/domain/timeline_clip.dart';
import 'package:voivo_movie_maker/domain/timeline_clip_contents.dart';

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
    return switch (clip.content) {
      final TextContent content => _PreviewText(content: content),
    };
  }
}

class _PreviewText extends StatelessWidget {
  const _PreviewText({required this.content});

  final TextContent content;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        content.text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: content.textColor,
          fontFamily: content.fontFamily,
          fontSize: content.fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
