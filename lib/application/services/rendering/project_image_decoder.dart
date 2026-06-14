// Dart imports:
import 'dart:typed_data';
import 'dart:ui';

// Project imports:
import 'package:voivo_movie_maker/domain/project_assets.dart';

Future<Image> decodeProjectImage(
  IProjectAssetStore store,
  ProjectAsset asset,
) async {
  final bytes = BytesBuilder(copy: false);
  await for (final chunk in store.load(asset)) {
    bytes.add(chunk);
  }
  final codec = await instantiateImageCodec(bytes.takeBytes());
  try {
    return (await codec.getNextFrame()).image;
  } finally {
    codec.dispose();
  }
}
