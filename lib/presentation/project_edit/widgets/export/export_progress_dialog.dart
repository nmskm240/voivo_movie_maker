import 'package:flutter/material.dart';
import 'package:voivo_movie_maker/application/services/export/export_operation.dart';

class ExportProgressDialog extends StatelessWidget {
  const ExportProgressDialog({super.key, required this.operation});

  final ExportOperation operation;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: StreamBuilder<ExportProgress>(
        stream: operation.progress,
        initialData: operation.currentProgress,
        builder: (context, snapshot) {
          final progress = snapshot.data ?? operation.currentProgress;
          final percent = (progress.fraction * 100).round();
          final frameProgress =
              progress.completedFrames == null || progress.totalFrames == null
              ? null
              : '${progress.completedFrames} / ${progress.totalFrames} frames';
          final status = switch (progress.phase) {
            ExportPhase.rendering => '$percent%',
            ExportPhase.saving => 'Saving video...',
            ExportPhase.cancelling => 'Cancelling...',
          };
          return AlertDialog(
            title: const Text('Exporting video'),
            content: SizedBox(
              width: 320,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LinearProgressIndicator(value: progress.fraction),
                  const SizedBox(height: 12),
                  Text(status, textAlign: TextAlign.end),
                  if (frameProgress != null) ...[
                    const SizedBox(height: 4),
                    Text(frameProgress, textAlign: TextAlign.end),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: progress.phase == ExportPhase.rendering
                    ? operation.cancel
                    : null,
                child: const Text('Cancel'),
              ),
            ],
          );
        },
      ),
    );
  }
}
