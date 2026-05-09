import '../../../models/timeline.dart';
import 'export_output_path_stub.dart'
    if (dart.library.io) 'export_output_path_io.dart';

Future<String> createDefaultExportOutputPath(Project project) {
  return createPlatformDefaultExportOutputPath(project);
}
