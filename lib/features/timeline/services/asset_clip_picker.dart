import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voivo_movie_maker/application/controllers/timeline_editor/asset_clip_selection.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';

final assetClipPickerProvider = Provider<AssetClipPicker>((ref) {
  return const AssetClipPicker();
});

class AssetClipPicker {
  const AssetClipPicker();

  Future<AssetClipSelection?> pickFor(TimelineClipKind kind) {
    return switch (kind) {
      TimelineClipKind.image => pickImage(),
      TimelineClipKind.audio => pickAudio(),
      TimelineClipKind.text => Future.value(),
    };
  }

  Future<AssetClipSelection?> pickImage() async {
    final file = await _pickFile(FileType.image);
    if (file == null) {
      return null;
    }

    final image = await _decodeImage(file.bytes);
    final asset = ProjectAsset(
      id: AssetId.create(),
      name: file.name,
      kind: ProjectAssetKind.image,
    );

    return AssetClipSelection(
      asset: asset,
      bytes: file.bytes,
      size: _defaultClipSize(image),
    );
  }

  Future<AssetClipSelection?> pickAudio() async {
    final file = await _pickFile(FileType.audio);
    if (file == null) {
      return null;
    }

    final asset = ProjectAsset(
      id: AssetId.create(),
      name: file.name,
      kind: ProjectAssetKind.audio,
    );

    return AssetClipSelection(asset: asset, bytes: file.bytes);
  }

  Future<({String name, Uint8List bytes})?> _pickFile(FileType type) async {
    final result = await FilePicker.pickFiles(
      type: type,
      withData: true,
    );
    final file = result?.files.singleOrNull;
    if (file == null || (file.bytes == null && file.path == null)) {
      return null;
    }

    return (
      name: file.name,
      bytes: file.bytes ?? await file.xFile.readAsBytes(),
    );
  }

  Future<ui.Image> _decodeImage(Uint8List bytes) async {
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  ui.Size _defaultClipSize(ui.Image image) {
    const maxWidth = 640.0;
    const maxHeight = 360.0;
    final width = image.width.toDouble();
    final height = image.height.toDouble();
    final scale = math.min(1.0, math.min(maxWidth / width, maxHeight / height));

    return ui.Size(width * scale, height * scale);
  }
}
