import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voicevox_flutter/voicevox_flutter.dart';

final voicevoxSpeechServiceProvider = Provider<VoicevoxSpeechService>((ref) {
  return VoicevoxSpeechService();
});

final class VoicevoxSpeechService {
  Future<void>? _initializing;

  Future<Uint8List> synthesize({
    required String text,
    required int speakerId,
  }) async {
    await _ensureInitialized();

    final tempDir = await getTemporaryDirectory();
    final outputFile = File(
      p.join(
        tempDir.path,
        'voicevox_${DateTime.now().microsecondsSinceEpoch}.wav',
      ),
    );

    try {
      await Future<void>(() {
        VoicevoxFlutter.instance.tts(
          text,
          speakerId: speakerId,
          outputPath: outputFile.path,
        );
      });
      return await outputFile.readAsBytes();
    } finally {
      if (await outputFile.exists()) {
        await outputFile.delete();
      }
    }
  }

  Future<void> _ensureInitialized() {
    return _initializing ??= _initialize();
  }

  Future<void> _initialize() async {
    final paths = _VoicevoxRuntimePaths.discover();
    await VoicevoxFlutter.instance.initialize(
      modelPath: paths.modelDirectory.path,
      openJdkDictPath: paths.openJtalkDirectory.path,
      cpuNumThreads: Platform.numberOfProcessors.clamp(1, 4).toInt(),
      loadAllModels: true,
    );
  }
}

final class _VoicevoxRuntimePaths {
  const _VoicevoxRuntimePaths({
    required this.modelDirectory,
    required this.openJtalkDirectory,
  });

  final Directory modelDirectory;
  final Directory openJtalkDirectory;

  static _VoicevoxRuntimePaths discover() {
    final modelDirectory = _firstExistingDirectory(
      environmentKey: 'VOICEVOX_MODEL_DIR',
      relativeCandidates: const [
        'voicevox/model',
        'assets/voicevox/model',
      ],
    );
    final openJtalkDirectory = _firstExistingDirectory(
      environmentKey: 'VOICEVOX_OPEN_JTALK_DICT_DIR',
      relativeCandidates: const [
        'voicevox/open_jtalk_dic_utf_8-1.11',
        'assets/voicevox/open_jtalk_dic_utf_8-1.11',
      ],
    );

    if (modelDirectory == null || openJtalkDirectory == null) {
      throw StateError(
        'VOICEVOX runtime files were not found. Set VOICEVOX_MODEL_DIR and '
        'VOICEVOX_OPEN_JTALK_DICT_DIR, or place them under voicevox/ in the '
        'project or app bundle directory.',
      );
    }

    return _VoicevoxRuntimePaths(
      modelDirectory: modelDirectory,
      openJtalkDirectory: openJtalkDirectory,
    );
  }

  static Directory? _firstExistingDirectory({
    required String environmentKey,
    required List<String> relativeCandidates,
  }) {
    final environmentPath = Platform.environment[environmentKey];
    if (environmentPath != null && environmentPath.isNotEmpty) {
      final directory = Directory(environmentPath);
      if (directory.existsSync()) {
        return directory;
      }
    }

    final roots = <String>{
      Directory.current.path,
      p.dirname(Platform.resolvedExecutable),
    };

    for (final root in roots) {
      for (final relativeCandidate in relativeCandidates) {
        final directory = Directory(p.join(root, relativeCandidate));
        if (directory.existsSync()) {
          return directory;
        }
      }
    }

    return null;
  }
}
