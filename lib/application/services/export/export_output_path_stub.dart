import '../../../models/timeline.dart';

Future<String> createPlatformDefaultExportOutputPath(Project project) async {
  final timestamp = DateTime.now()
      .toIso8601String()
      .replaceAll(':', '')
      .replaceAll('.', '');
  return '${project.id}_$timestamp.mp4';
}
