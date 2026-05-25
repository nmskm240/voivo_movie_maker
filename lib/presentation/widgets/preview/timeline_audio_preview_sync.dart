import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voivo_movie_maker/application/providers/loaded_project_provider.dart';
import 'package:voivo_movie_maker/application/providers/playback_controller_provider.dart';
import 'package:voivo_movie_maker/application/services/timeline_audio_preview_service.dart';

class TimelineAudioPreviewSync extends ConsumerWidget {
  const TimelineAudioPreviewSync({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playback = ref.watch(playbackControllerProvider);
    final project = ref.watch(
      loadedProjectProvider.select(
        (value) => value.whenOrNull(data: (snapshot) => snapshot.project),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final service = ref.read(timelineAudioPreviewServiceProvider);
      if (project == null) {
        service.stopAll();
        return;
      }

      service.sync(playback: playback, project: project).catchError((error) {
        debugPrint('Failed to sync timeline audio preview: $error');
      });
    });

    return const SizedBox.shrink();
  }
}
