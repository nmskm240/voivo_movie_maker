// Dart imports:
import 'dart:io';
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter_test/flutter_test.dart';

// Package imports:
import 'package:path/path.dart' as p;

// Project imports:
import 'package:voivo_movie_maker/application/services/project_asset_importer.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';

void main() {
  test('adds a new asset and rolls it back', () async {
    final directory = await Directory.systemTemp.createTemp(
      'project_asset_importer_test',
    );
    addTearDown(() => directory.delete(recursive: true));
    final file = File(p.join(directory.path, 'voice.wav'));
    await file.writeAsBytes([1, 2, 3]);
    final project = Project.empty();
    final asset = ProjectAsset(name: 'voice.wav', kind: ProjectAssetKind.audio);
    final store = _ProjectAssetStore(asset);

    final result = await ProjectAssetImporter(store).importFile(project, file);

    expect(result.asset, same(asset));
    expect(project.assets.findById(asset.id), same(asset));
    expect(store.saved, isTrue);

    await result.rollback();

    expect(project.assets.findById(asset.id), isNull);
    expect(store.deleted, isTrue);
  });

  test('overwrites an existing asset and rolls it back', () async {
    final directory = await Directory.systemTemp.createTemp(
      'project_asset_importer_test',
    );
    addTearDown(() => directory.delete(recursive: true));
    final file = File(p.join(directory.path, 'voice.wav'));
    await file.writeAsBytes([1, 2, 3]);
    final project = Project.empty();
    final asset = ProjectAsset(name: 'voice.wav', kind: ProjectAssetKind.audio);
    project.assets.add(asset);
    final store = _ProjectAssetStore(asset, bytes: [9, 9]);

    final result = await ProjectAssetImporter(store).importFile(project, file);

    expect(result.asset, same(asset));
    expect(project.assets.assets, [asset]);
    expect(store.saved, isFalse);
    expect(store.replaced, isTrue);
    expect(store.bytes, [1, 2, 3]);

    await result.rollback();

    expect(project.assets.assets, [asset]);
    expect(store.bytes, [9, 9]);
  });
}

final class _ProjectAssetStore extends IProjectAssetStore {
  _ProjectAssetStore(this.asset, {List<int> bytes = const []})
    : bytes = Uint8List.fromList(bytes);

  final ProjectAsset asset;
  Uint8List bytes;
  bool saved = false;
  bool replaced = false;
  bool deleted = false;

  @override
  Future<void> delete(ProjectAsset asset) async {
    deleted = true;
  }

  @override
  Stream<List<int>> load(ProjectAsset asset) => Stream.value(bytes);

  @override
  Future<void> replace(ProjectAsset asset, File file) async {
    replaced = true;
    bytes = await file.readAsBytes();
  }

  @override
  Future<ProjectAsset> save(File file) async {
    saved = true;
    return asset;
  }
}
