import 'package:flutter/material.dart';

import '../data/mock_timeline.dart';
import '../models/timeline.dart';
import '../widgets/inspector.dart';
import '../widgets/menu_bar.dart';
import '../widgets/preview.dart';
import '../widgets/timeline.dart';

class EditorMockScreen extends StatefulWidget {
  const EditorMockScreen({super.key});

  @override
  State<EditorMockScreen> createState() => _EditorMockScreenState();
}

class _EditorMockScreenState extends State<EditorMockScreen> {
  final List<TimelineTrack> tracks = mockTimelineTracks;

  int selectedTrackIndex = 1;
  int selectedClipIndex = 1;
  bool isPlaying = false;

  TimelineClip get selectedClip =>
      tracks[selectedTrackIndex].clips[selectedClipIndex];

  void selectClip(int trackIndex, int clipIndex) {
    setState(() {
      selectedTrackIndex = trackIndex;
      selectedClipIndex = clipIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            EditorMenuBar(
              isPlaying: isPlaying,
              onTogglePlay: () => setState(() => isPlaying = !isPlaying),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isCompact = constraints.maxWidth < 900;

                  if (isCompact) {
                    return Column(
                      children: [
                        const Expanded(child: PreviewPane()),
                        SizedBox(
                          height: 220,
                          child: InspectorPane(clip: selectedClip),
                        ),
                      ],
                    );
                  }

                  return Row(
                    children: [
                      const Expanded(flex: 7, child: PreviewPane()),
                      SizedBox(
                        width: 320,
                        child: InspectorPane(clip: selectedClip),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 280,
              child: TimelinePane(
                tracks: tracks,
                selectedTrackIndex: selectedTrackIndex,
                selectedClipIndex: selectedClipIndex,
                onSelectClip: selectClip,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
