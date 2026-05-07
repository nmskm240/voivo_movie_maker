import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/export/export_output_path.dart';
import '../../services/export/video_exporter.dart';
import '../../services/export/video_exporter_factory.dart';
import '../../view_models/editor_timeline_view_model.dart';
import '../../widgets/inspector.dart';
import '../../widgets/menu_bar.dart';
import '../../widgets/preview.dart';
import '../../widgets/timeline.dart';

class EditorMockScreen extends ConsumerStatefulWidget {
  const EditorMockScreen({super.key});

  @override
  ConsumerState<EditorMockScreen> createState() => _EditorMockScreenState();
}

class _EditorMockScreenState extends ConsumerState<EditorMockScreen> {
  final VideoExporter exporter = createVideoExporter();

  Future<void> exportVideo() async {
    final editorState = ref.read(editorTimelineViewModelProvider);
    final viewModel = ref.read(editorTimelineViewModelProvider.notifier);

    if (editorState.isExporting) {
      return;
    }

    viewModel.setExporting(true);

    try {
      final project = ref.read(editorTimelineViewModelProvider).project;
      final outputPath = await createDefaultExportOutputPath(project);
      final result = await exporter.export(project, outputPath);

      if (!mounted) {
        return;
      }

      final message = result.success
          ? '動画を書き出しました: ${result.outputPath}'
          : '書き出しに失敗しました: ${result.returnCode}';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('書き出しに失敗しました: $error')));
    } finally {
      if (mounted) {
        viewModel.setExporting(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final editorState = ref.watch(editorTimelineViewModelProvider);
    final viewModel = ref.read(editorTimelineViewModelProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            EditorMenuBar(
              isPlaying: editorState.isPlaying,
              onTogglePlay: viewModel.togglePlayback,
              onExport: exportVideo,
              isExporting: editorState.isExporting,
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
                            project: editorState.project,
                            currentFrame: editorState.currentFrame,
                          ),
                        ),
                        SizedBox(
                          height: 220,
                          child: InspectorPane(clip: editorState.selectedClip),
                        ),
                      ],
                    );
                  }

                  return Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: PreviewPane(
                          project: editorState.project,
                          currentFrame: editorState.currentFrame,
                        ),
                      ),
                      SizedBox(
                        width: 320,
                        child: InspectorPane(clip: editorState.selectedClip),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 280, child: const TimelinePane()),
          ],
        ),
      ),
    );
  }
}
