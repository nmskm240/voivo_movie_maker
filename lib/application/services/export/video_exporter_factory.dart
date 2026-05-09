import 'video_exporter.dart';
import 'video_exporter_factory_stub.dart'
    if (dart.library.ffi) 'video_exporter_factory_ffmpeg.dart';

VideoExporter createVideoExporter() {
  return createPlatformVideoExporter();
}
