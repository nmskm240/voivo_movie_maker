import 'dart:async';

import 'package:flutter/material.dart';

import '../data/mock_timeline.dart';
import '../models/timeline.dart';
import '../services/export/export_output_path.dart';
import '../services/export/video_exporter.dart';
import '../services/export/video_exporter_factory.dart';
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
  final Project project = mockProject;

  int selectedTrackIndex = 0;
  int selectedClipIndex = 1;
  int currentFrame = 540;
  bool isPlaying = false;
  bool isExporting = false;
  Timer? playbackTimer;
  final VideoExporter exporter = createVideoExporter();

  Timeline get timeline => project.timeline;

  TextClip get selectedClip =>
      timeline.tracks[selectedTrackIndex].clips[selectedClipIndex];

  void selectClip(int trackIndex, int clipIndex) {
    final clip = timeline.tracks[trackIndex].clips[clipIndex];

    setState(() {
      selectedTrackIndex = trackIndex;
      selectedClipIndex = clipIndex;
      currentFrame = clip.startFrame;
    });
  }

  void togglePlayback() {
    if (isPlaying) {
      stopPlayback();
      return;
    }

    setState(() => isPlaying = true);
    playbackTimer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() {
        currentFrame = (currentFrame + project.settings.fps ~/ 10) %
            timeline.durationFrames;
      });
    });
  }

  void stopPlayback() {
    playbackTimer?.cancel();
    playbackTimer = null;
    setState(() => isPlaying = false);
  }

  Future<void> exportVideo() async {
    if (isExporting) {
      return;
    }

    setState(() => isExporting = true);

    try {
      final outputPath = await createDefaultExportOutputPath(project);
      final result = await exporter.export(project, outputPath);

      if (!mounted) {
        return;
      }

      final message = result.success
          ? '動画を書き出しました: ${result.outputPath}'
          : '書き出しに失敗しました: ${result.returnCode}';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('書き出しに失敗しました: $error')),
      );
    } finally {
      if (mounted) {
        setState(() => isExporting = false);
      }
    }
  }

  @override
  void dispose() {
    playbackTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            EditorMenuBar(
              isPlaying: isPlaying,
              onTogglePlay: togglePlayback,
              onExport: exportVideo,
              isExporting: isExporting,
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isCompact = constraints.maxWidth < 900;

                  if (isCompact) {
                    return Column(
                      children: [
                        Expanded(
                          child: PreviewPane(
                            project: project,
                            currentFrame: currentFrame,
                          ),
                        ),
                        SizedBox(
                          height: 220,
                          child: InspectorPane(clip: selectedClip),
                        ),
                      ],
                    );
                  }

                  return Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: PreviewPane(
                          project: project,
                          currentFrame: currentFrame,
                        ),
                      ),
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
                timeline: timeline,
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
