import 'ffmpeg_kit_video_exporter.dart';
import 'video_exporter.dart';

VideoExporter createPlatformVideoExporter() {
  return const FfmpegKitVideoExporter();
}
