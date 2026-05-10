import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voivo_movie_maker/features/preview/widget/project_preview.dart';
import 'package:voivo_movie_maker/features/timeline/widget/timeline.dart';
import 'package:voivo_movie_maker/application/providers/playback_controller_provider.dart';

class EditorScreen extends ConsumerStatefulWidget {
  const EditorScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _EditorScreenState();
  }
}

class _EditorScreenState extends ConsumerState<EditorScreen>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();

    final controller = ref.read(playbackControllerProvider.notifier);
    _ticker = createTicker(controller.onTick);
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(playbackControllerProvider);
    final playbackController = ref.read(playbackControllerProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(state.currentFrame.toString()),
            state.map(
              stopped: (stopped) {
                return TextButton.icon(
                  onPressed: () {
                    _ticker.start();
                    playbackController.play();
                  },
                  label: Text("start"),
                  icon: Icon(Icons.start),
                );
              },
              playing: (playing) {
                return TextButton.icon(
                  onPressed: () {
                    _ticker.stop();
                    playbackController.pause();
                  },
                  label: Text("stop"),
                  icon: Icon(Icons.stop),
                );
              },
            ),
            const Expanded(flex: 2, child: ProjectPreviewPane()),
            const Expanded(flex: 3, child: TimelinePane()),
          ],
        ),
      ),
    );
  }
}
