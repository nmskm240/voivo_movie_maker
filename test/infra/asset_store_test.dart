// Dart imports:
import 'dart:io';
import 'dart:typed_data';

// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

// Project imports:
import 'package:voivo_movie_maker/infra/asset_store.dart';

void main() {
  test('saves into the assets directory and deletes idempotently', () async {
    final temporaryDirectory = await Directory.systemTemp.createTemp(
      'asset_store_test',
    );
    addTearDown(() => temporaryDirectory.delete(recursive: true));
    final source = File(p.join(temporaryDirectory.path, 'source.png'));
    await source.writeAsBytes(_pngBytes);
    final assetsDirectory = Directory(
      p.join(temporaryDirectory.path, 'project', 'assets'),
    );
    final store = DirectoryAssetStore(assetsDirectory);

    final asset = await store.save(source);
    final storedFile = File(p.join(assetsDirectory.path, asset.fileName));

    expect(await storedFile.readAsBytes(), _pngBytes);
    await store.delete(asset);
    await store.delete(asset);
    expect(await storedFile.exists(), isFalse);
  });
}

final _pngBytes = Uint8List.fromList([
  0x89,
  0x50,
  0x4e,
  0x47,
  0x0d,
  0x0a,
  0x1a,
  0x0a,
]);
