// Dart imports:
import 'dart:io';
import 'dart:typed_data';

// Project imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/utils/extensions/stream.dart';

part 'project_asset_importer.g.dart';

@Riverpod(dependencies: [projectAssetStore])
ProjectAssetImporter projectAssetImporter(Ref ref) {
  return ProjectAssetImporter(ref.watch(projectAssetStoreProvider));
}

final class ProjectAssetImporter {
  const ProjectAssetImporter(this._store);

  final IProjectAssetStore _store;

  Future<ImportedAsset> importFile(Project project, File file) async {
    ProjectAsset? asset;
    Uint8List? overwrittenBytes;
    var assetWasCreated = false;
    var overwriteWasApplied = false;
    final fileName = file.uri.pathSegments.last;
    asset = project.assets.findByName(fileName);
    if (asset == null) {
      asset = await _store.save(file);
      project.assets.add(asset);
      assetWasCreated = true;
    } else {
      overwrittenBytes = await _store.load(asset).toUint8List();
      await _store.replace(asset, file);
      overwriteWasApplied = true;
    }
    return ImportedAsset(
      asset: asset,
      rollback: () => _rollBackAsset(
        project,
        asset!,
        file,
        overwrittenBytes,
        assetWasCreated: assetWasCreated,
        overwriteWasApplied: overwriteWasApplied,
      ),
    );
  }

  Future<void> _rollBackAsset(
    Project project,
    ProjectAsset asset,
    File sourceFile,
    Uint8List? overwrittenBytes, {
    required bool assetWasCreated,
    required bool overwriteWasApplied,
  }) async {
    if (assetWasCreated) {
      project.assets.remove(asset.id);
      await _store.delete(asset);
      return;
    }
    if (!overwriteWasApplied || overwrittenBytes == null) {
      return;
    }
    await sourceFile.writeAsBytes(overwrittenBytes);
    await _store.replace(asset, sourceFile);
  }
}

final class ImportedAsset {
  const ImportedAsset({
    required this.asset,
    required Future<void> Function() rollback,
  }) : _rollback = rollback;

  final ProjectAsset asset;
  final Future<void> Function() _rollback;

  Future<void> rollback() => _rollback();
}
