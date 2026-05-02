import '../../models/timeline.dart';
import 'video_exporter.dart';

VideoExporter createPlatformVideoExporter() {
  return const UnsupportedVideoExporter();
}

class UnsupportedVideoExporter implements VideoExporter {
  const UnsupportedVideoExporter();

  @override
  Future<ExportResult> export(Project project, String outputPath) async {
    return ExportResult(
      success: false,
      outputPath: outputPath,
      command: '',
      logs: 'Video export is not available on this platform.',
      returnCode: -1,
    );
  }
}
