import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui';

import 'package:voivo_movie_maker/application/services/rendering/project_frame_builder.dart';
import 'package:voivo_movie_maker/application/services/rendering/project_frame_renderer.dart';
import 'package:voivo_movie_maker/domain/project.dart';

typedef WriteFrame = FutureOr<void> Function(Uint8List bytes);
typedef FrameProgress = void Function(int completedFrames, int totalFrames);

class ProjectFrameStreamWriter {
  const ProjectFrameStreamWriter({
    this.frameBuilder = const ProjectFrameBuilder(),
    this.renderer = const ProjectFrameRenderer(),
  });

  final ProjectFrameBuilder frameBuilder;
  final ProjectFrameRenderer renderer;

  Future<void> write(
    Project project,
    WriteFrame writeFrame, {
    FrameProgress? onProgress,
    void Function()? checkCancelled,
  }) async {
    final width = project.width.round();
    final height = project.height.round();
    final outputSize = Size(width.toDouble(), height.toDouble());
    final durationFrames = project.timeline.tracks
        .expand((track) => track.clips)
        .fold(
          project.fps,
          (duration, clip) => math.max(duration, clip.endFrame),
        );
    for (var frame = 0; frame < durationFrames; frame++) {
      checkCancelled?.call();
      final projectFrame = frameBuilder.build(project, frame);
      final recorder = PictureRecorder();
      final canvas = Canvas(recorder);
      renderer.paint(
        canvas: canvas,
        outputSize: outputSize,
        frame: projectFrame,
      );

      final picture = recorder.endRecording();
      final image = await picture.toImage(width, height);
      picture.dispose();
      try {
        final bytes = await image.toByteData(format: ImageByteFormat.rawRgba);
        if (bytes == null) {
          throw StateError('Failed to encode export frame $frame.');
        }
        await writeFrame(
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes),
        );
        onProgress?.call(frame + 1, durationFrames);
      } finally {
        image.dispose();
      }
    }
  }
}
