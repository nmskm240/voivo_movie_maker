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
  test('project image resources decode an asset only once', () async {
    final asset = ProjectAsset(name: 'image.png', kind: ProjectAssetKind.image);
    final store = _ProjectAssetStore(await _pngBytes(4, 3));
    final container = ProviderContainer(
      overrides: [projectAssetStoreProvider.overrideWithValue(store)],
    );
    addTearDown(container.dispose);

    final resources = container.read(projectImageResourcesProvider);
    final images = await Future.wait([
      resources.load(asset),
      resources.load(asset),
    ]);

    expect(store.loadCount, 1);
    expect(identical(images.first, images.last), isTrue);
    expect(resources.findById(asset.id), same(images.first));
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

class _ProjectAssetStore implements IProjectAssetStore {
  _ProjectAssetStore(this.bytes);

  final Uint8List bytes;
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
}
