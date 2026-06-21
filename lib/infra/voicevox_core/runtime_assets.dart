// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/services.dart';

// Package imports:
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

final class VoicevoxRuntimeAssets {
  const VoicevoxRuntimeAssets(this.rootDirectory);

  static const assetRoot = 'assets/voicevox';

  final Directory rootDirectory;

  Directory get modelDirectory =>
      Directory(p.join(rootDirectory.path, 'models'));
  String get dictionaryPath => p.join(rootDirectory.path, 'dict');

  static Future<VoicevoxRuntimeAssets> extract() async {
    final supportDirectory = await getApplicationSupportDirectory();
    final runtimeAssets = VoicevoxRuntimeAssets(
      Directory(p.join(supportDirectory.path, 'voicevox')),
    );
    final assets = await _loadBundledAssetPaths();
    _ensureVoiceModelsAreBundled(assets);
    await runtimeAssets._copyMissingAssets(assets);
    return runtimeAssets;
  }

  static Future<List<String>> _loadBundledAssetPaths() async {
    final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    return manifest
        .listAssets()
        .where((asset) => asset.startsWith('$assetRoot/'))
        .where((asset) => !asset.endsWith('.gitkeep'))
        .toList(growable: false);
  }

  static void _ensureVoiceModelsAreBundled(List<String> assets) {
    if (assets.any((asset) => asset.endsWith('.vvm'))) return;
    throw StateError(
      'VOICEVOX voice models are not bundled. See docs/voicevox-mobile.md.',
    );
  }

  Future<void> _copyMissingAssets(List<String> assets) async {
    for (final asset in assets) {
      final destination = _fileForAsset(asset);
      if (await destination.exists()) continue;
      await destination.parent.create(recursive: true);
      final data = await rootBundle.load(asset);
      await destination.writeAsBytes(data.buffer.asUint8List(), flush: true);
    }
  }

  File _fileForAsset(String asset) {
    final relativePath = p.relative(asset, from: assetRoot);
    return File(p.join(rootDirectory.path, relativePath));
  }
}
