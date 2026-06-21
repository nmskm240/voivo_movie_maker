// Dart imports:
import 'dart:typed_data';
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/application/services/rendering/project_frame.dart';
import 'package:voivo_movie_maker/application/services/rendering/project_frame_renderer.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';

void main() {
  test('paints shapes through the shared frame renderer', () async {
    const size = Size(10, 10);
    final clip = TimelineClip(
      id: TimelineClipId.create(),
      startFrame: 0,
      components: [
        ShapeComponent(
          shapeType: ShapeType.ellipse,
          size: const Size(6, 6),
          color: Colors.red,
        ),
      ],
    );
    final recorder = PictureRecorder();

    const ProjectFrameRenderer().paint(
      canvas: Canvas(recorder),
      outputSize: size,
      frame: ProjectFrame(projectSize: size, frameNumber: 0, clips: [clip]),
    );
    final picture = recorder.endRecording();
    final image = await picture.toImage(10, 10);
    picture.dispose();
    final bytes = await image.toByteData(format: ImageByteFormat.rawRgba);
    image.dispose();

    expect(_pixel(bytes!, x: 5, y: 5, width: 10), const [244, 67, 54, 255]);
    expect(_pixel(bytes, x: 0, y: 0, width: 10), const [0, 0, 0, 255]);
  });

  test('paints decoded image assets', () async {
    const size = Size(10, 10);
    final assetId = AssetId.create();
    final sourceRecorder = PictureRecorder();
    Canvas(
      sourceRecorder,
    ).drawRect(const Rect.fromLTWH(0, 0, 2, 2), Paint()..color = Colors.blue);
    final sourcePicture = sourceRecorder.endRecording();
    final sourceImage = await sourcePicture.toImage(2, 2);
    sourcePicture.dispose();
    addTearDown(sourceImage.dispose);
    final clip = TimelineClip(
      id: TimelineClipId.create(),
      startFrame: 0,
      components: [ImageComponent(assetId: assetId, size: const Size(6, 6))],
    );
    final recorder = PictureRecorder();

    const ProjectFrameRenderer().paint(
      canvas: Canvas(recorder),
      outputSize: size,
      frame: ProjectFrame(
        projectSize: size,
        frameNumber: 0,
        clips: [clip],
        imageAssets: {assetId: sourceImage},
      ),
    );
    final picture = recorder.endRecording();
    final image = await picture.toImage(10, 10);
    picture.dispose();
    final bytes = await image.toByteData(format: ImageByteFormat.rawRgba);
    image.dispose();

    expect(_pixel(bytes!, x: 5, y: 5, width: 10), const [33, 150, 243, 255]);
    expect(_pixel(bytes, x: 0, y: 0, width: 10), const [0, 0, 0, 255]);
  });

  test('paints decoded video frames', () async {
    const size = Size(10, 10);
    final assetId = AssetId.create();
    final sourceRecorder = PictureRecorder();
    Canvas(
      sourceRecorder,
    ).drawRect(const Rect.fromLTWH(0, 0, 2, 2), Paint()..color = Colors.purple);
    final sourcePicture = sourceRecorder.endRecording();
    final sourceImage = await sourcePicture.toImage(2, 2);
    sourcePicture.dispose();
    addTearDown(sourceImage.dispose);
    final clip = TimelineClip(
      id: TimelineClipId.create(),
      startFrame: 0,
      components: [
        TransformComponent(),
        VideoComponent(assetId: assetId),
      ],
    );
    final recorder = PictureRecorder();

    const ProjectFrameRenderer().paint(
      canvas: Canvas(recorder),
      outputSize: size,
      frame: ProjectFrame(
        projectSize: size,
        frameNumber: 0,
        clips: [clip],
        videoFrames: {clip.id: sourceImage},
      ),
    );
    final picture = recorder.endRecording();
    final image = await picture.toImage(10, 10);
    picture.dispose();
    final bytes = await image.toByteData(format: ImageByteFormat.rawRgba);
    image.dispose();

    expect(_pixel(bytes!, x: 5, y: 5, width: 10), const [156, 39, 176, 255]);
  });
}

List<int> _pixel(
  ByteData bytes, {
  required int x,
  required int y,
  required int width,
}) {
  final offset = (y * width + x) * 4;
  return [
    bytes.getUint8(offset),
    bytes.getUint8(offset + 1),
    bytes.getUint8(offset + 2),
    bytes.getUint8(offset + 3),
  ];
}
