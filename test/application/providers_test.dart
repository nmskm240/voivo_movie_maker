// Dart imports:
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';

void main() {
  test('project image cache decode an asset only once', () async {
    final asset = ProjectAsset(name: 'image.png', kind: ProjectAssetKind.image);
    final store = _ProjectAssetStore(await _pngBytes(4, 3));
    final container = ProviderContainer(
      overrides: [projectAssetStoreProvider.overrideWithValue(store)],
    );
    addTearDown(container.dispose);

    final cache = container.read(projectImageCacheProvider);
    final images = await Future.wait([cache.load(asset), cache.load(asset)]);

    expect(store.loadCount, 1);
    expect(identical(images.first, images.last), isTrue);
    expect(cache.findById(asset.id), same(images.first));
  });

  test('project audio cache loads an asset only once', () async {
    final asset = ProjectAsset(name: 'voice.wav', kind: ProjectAssetKind.audio);
    final store = _ProjectAssetStore(Uint8List.fromList([1, 2, 3]));
    final container = ProviderContainer(
      overrides: [projectAssetStoreProvider.overrideWithValue(store)],
    );
    addTearDown(container.dispose);

    final cache = container.read(projectAudioCacheProvider);
    final audios = await Future.wait([cache.load(asset), cache.load(asset)]);

    expect(store.loadCount, 1);
    expect(identical(audios.first, audios.last), isTrue);
    expect(cache.findById(asset.id), same(audios.first));
    expect(audios.first, [1, 2, 3]);

    cache.evict(asset.id);
    store.bytes = Uint8List.fromList([4, 5]);
    final reloaded = await cache.load(asset);

    expect(store.loadCount, 2);
    expect(reloaded, [4, 5]);
  });
}

Future<Uint8List> _pngBytes(int width, int height) async {
  final recorder = PictureRecorder();
  Canvas(recorder).drawRect(
    Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
    Paint()..color = const Color(0xff2196f3),
  );
  final picture = recorder.endRecording();
  final image = await picture.toImage(width, height);
  picture.dispose();
  final data = await image.toByteData(format: ImageByteFormat.png);
  image.dispose();
  return data!.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}

class _ProjectAssetStore extends IProjectAssetStore {
  _ProjectAssetStore(this.bytes);

  Uint8List bytes;
  int loadCount = 0;

  @override
  Future<void> delete(ProjectAsset asset) async {}

  @override
  Stream<List<int>> load(ProjectAsset asset) {
    loadCount++;
    return Stream.value(bytes);
  }

  @override
  Future<ProjectAsset> save(File file) {
    throw UnimplementedError();
  }

  @override
  Future<void> replace(ProjectAsset asset, File file) {
    throw UnimplementedError();
  }
}
