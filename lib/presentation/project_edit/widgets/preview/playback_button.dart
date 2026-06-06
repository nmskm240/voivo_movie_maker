import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/application/services/playback_controller.dart';

class PlaybackButton extends ConsumerWidget {
  const PlaybackButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fps = ref.watch(
      projectProvider.select((project) => project.value?.fps),
    );
    if (fps == null) {
      return IconButton(onPressed: null, icon: const Icon(Icons.play_arrow));
    }

    final playbackInfo = ref.watch(playbackControllerProvider);
    final controller = ref.read(playbackControllerProvider.notifier);
    return IconButton(
      onPressed: playbackInfo.isPlaying ? controller.pause : controller.play,
      icon: Icon(playbackInfo.isPlaying ? Icons.pause : Icons.play_arrow),
    );
  }
}
