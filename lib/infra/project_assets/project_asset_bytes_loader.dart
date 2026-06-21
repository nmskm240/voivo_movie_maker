// Dart imports:
import 'dart:typed_data';

// Project imports:
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/utils/extensions/stream.dart';

Future<Uint8List> loadProjectAssetBytes(
  IProjectAssetStore store,
  ProjectAsset asset,
) => store.load(asset).toUint8List();
