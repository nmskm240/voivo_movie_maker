import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voivo_movie_maker/presentation/widgets/assets/asset_list.dart';
import 'package:voivo_movie_maker/presentation/widgets/inspector/clip_inspector.dart';
import 'package:voivo_movie_maker/presentation/widgets/preview/timeline_audio_preview_sync.dart';
import 'package:voivo_movie_maker/presentation/widgets/preview/project_preview.dart';
import 'package:voivo_movie_maker/presentation/widgets/timeline/timeline.dart';
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
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
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
                      const Expanded(flex: 2, child: ProjectPreview()),
                      const Expanded(flex: 3, child: TimelinePane()),
                    ],
                  ),
                ),
                const SizedBox(width: 320, child: _EditorSidePane()),
              ],
            ),
            const TimelineAudioPreviewSync(),
          ],
        ),
      ),
    );
  }
}

class _EditorSidePane extends StatelessWidget {
  const _EditorSidePane();

  static final _selectedIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _selectedIndex,
      builder: (context, selectedIndex, child) {
        return Row(
          children: [
            Expanded(
              child: IndexedStack(
                index: selectedIndex,
                children: const [AssetListPane(), ClipInspectorPane()],
              ),
            ),
            const VerticalDivider(width: 1),
            _ActivityBar(
              selectedIndex: selectedIndex,
              onSelected: (index) => _selectedIndex.value = index,
            ),
          ],
        );
      },
    );
  }
}

class _ActivityBar extends StatelessWidget {
  const _ActivityBar({required this.selectedIndex, required this.onSelected});

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xff11161a),
      child: SizedBox(
        width: 48,
        child: Column(
          children: [
            const SizedBox(height: 8),
            _ActivityBarButton(
              selected: selectedIndex == 0,
              icon: Icons.folder_outlined,
              tooltip: 'Assets',
              onPressed: () => onSelected(0),
            ),
            _ActivityBarButton(
              selected: selectedIndex == 1,
              icon: Icons.tune,
              tooltip: 'Inspector',
              onPressed: () => onSelected(1),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityBarButton extends StatelessWidget {
  const _ActivityBarButton({
    required this.selected,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final bool selected;
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onSurfaceVariant;

    return Tooltip(
      message: tooltip,
      child: SizedBox(
        width: 48,
        height: 48,
        child: Stack(
          children: [
            if (selected)
              const Positioned(
                right: 0,
                top: 8,
                bottom: 8,
                child: SizedBox(
                  width: 3,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Color(0xff9ccc65)),
                  ),
                ),
              ),
            Center(
              child: IconButton(
                onPressed: onPressed,
                icon: Icon(icon),
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
