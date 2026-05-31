import 'dart:io';

import 'package:file_magic_number/file_magic_number.dart';
import 'package:path/path.dart' as p;
import 'package:voivo_movie_maker/domain/project_assets.dart';

final class ProjectAssetFactory {
  static Future<ProjectAsset> fromFile(File file) async {
    final type = await FileMagicNumber.detectFileTypeFromPathOrBlob(file.path);

    final kind = switch (type) {
      FileMagicNumberType.jpg || FileMagicNumberType.png =>
        ProjectAssetKind.image,
      FileMagicNumberType.mp4 || FileMagicNumberType.avi =>
        ProjectAssetKind.video,
      FileMagicNumberType.mp3 || FileMagicNumberType.wav =>
        ProjectAssetKind.audio,
      _ => throw ArgumentError.value(
        file.path,
        'file',
        'Unsupported file type',
      ),
    };

    return ProjectAsset(
      name: p.basename(file.path),
      kind: kind,
    );
  }
}