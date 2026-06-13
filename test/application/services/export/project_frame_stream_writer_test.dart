import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:voivo_movie_maker/application/services/rendering/project_frame.dart';
import 'package:voivo_movie_maker/application/services/export/project_frame_stream_writer.dart';
import 'package:voivo_movie_maker/application/services/rendering/project_frame_renderer.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';

void main() {
  test('streams one raw RGBA frame for every project frame', () async {
    final project = Project(
      width: 16,
      height: 8,
      fps: 2,
      assets: ProjectAssetCatalog(),
      timeline: Timeline(),
    );
    final frames = <Uint8List>[];
    final progress = <(int, int)>[];

    await const ProjectFrameStreamWriter().write(
      project,
      frames.add,
      onProgress: (completedFrames, totalFrames) {
        progress.add((completedFrames, totalFrames));
      },
    );

    expect(frames, hasLength(2));
    expect(frames.every((frame) => frame.length == 16 * 8 * 4), isTrue);
    expect(progress, [(1, 2), (2, 2)]);
  });

  test('checks cancellation before rendering each frame', () async {
    final project = Project(
      width: 16,
      height: 8,
      fps: 2,
      assets: ProjectAssetCatalog(),
      timeline: Timeline(),
    );
    var framesWritten = 0;

    await expectLater(
      const ProjectFrameStreamWriter().write(
        project,
        (_) => framesWritten++,
        checkCancelled: () {
          if (framesWritten == 1) {
            throw StateError('cancelled');
          }
        },
      ),
      throwsStateError,
    );

    expect(framesWritten, 1);
  });

  test('renders every project frame', () async {
    final renderer = _CountingRenderer();
    final project = Project(
      width: 16,
      height: 8,
      fps: 3,
      assets: ProjectAssetCatalog(),
      timeline: Timeline(),
    );

    await ProjectFrameStreamWriter(renderer: renderer).write(project, (_) {});

    expect(renderer.paintCount, 3);
  });
}

class _CountingRenderer extends ProjectFrameRenderer {
  var paintCount = 0;

  @override
  void paint({
    required Canvas canvas,
    required Size outputSize,
    required ProjectFrame frame,
  }) {
    paintCount++;
    super.paint(canvas: canvas, outputSize: outputSize, frame: frame);
  }
}
