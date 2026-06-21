// Dart imports:
import 'dart:ffi';
import 'dart:io';

// Package imports:
import 'package:ffi/ffi.dart';
import 'package:voicevox_core/voicevox_core.dart';

// Project imports:
import 'package:voivo_movie_maker/infra/voicevox_core/result.dart';
import 'package:voivo_movie_maker/infra/voicevox_core/runtime_assets.dart';

final class VoicevoxNativeHandles {
  const VoicevoxNativeHandles({
    required this.openJtalk,
    required this.synthesizer,
  });

  final Pointer<OpenJtalkRc> openJtalk;
  final Pointer<VoicevoxSynthesizer> synthesizer;

  static Future<VoicevoxNativeHandles> create(
    VoicevoxRuntimeAssets runtimeAssets,
  ) async {
    final onnxruntime = _loadOnnxruntime();
    final openJtalk = _createOpenJtalk(runtimeAssets.dictionaryPath);
    try {
      return VoicevoxNativeHandles(
        openJtalk: openJtalk,
        synthesizer: _createSynthesizer(
          onnxruntime: onnxruntime,
          openJtalk: openJtalk,
        ),
      );
    } catch (_) {
      voicevoxOpenJtalkRcDelete(openJtalk);
      rethrow;
    }
  }

  void dispose() {
    voicevoxSynthesizerDelete(synthesizer);
    voicevoxOpenJtalkRcDelete(openJtalk);
  }

  static Pointer<VoicevoxOnnxruntime> _loadOnnxruntime() {
    final out = calloc<Pointer<VoicevoxOnnxruntime>>();
    try {
      checkVoicevoxResult(
        Platform.isIOS
            ? voicevoxOnnxruntimeInitOnce(out)
            : voicevoxOnnxruntimeLoadOnce(
                voicevoxMakeDefaultLoadOnnxruntimeOptions(),
                out,
              ),
      );
      return out.value;
    } finally {
      calloc.free(out);
    }
  }

  static Pointer<OpenJtalkRc> _createOpenJtalk(String dictionaryPath) {
    final out = calloc<Pointer<OpenJtalkRc>>();
    try {
      checkVoicevoxResult(voicevoxOpenJtalkRcNew(dictionaryPath, out));
      return out.value;
    } finally {
      calloc.free(out);
    }
  }

  static Pointer<VoicevoxSynthesizer> _createSynthesizer({
    required Pointer<VoicevoxOnnxruntime> onnxruntime,
    required Pointer<OpenJtalkRc> openJtalk,
  }) {
    final out = calloc<Pointer<VoicevoxSynthesizer>>();
    try {
      final options = voicevoxMakeDefaultInitializeOptions()
        ..accelerationMode = 1
        ..cpuNumThreads = Platform.numberOfProcessors.clamp(1, 4);
      checkVoicevoxResult(
        voicevoxSynthesizerNew(onnxruntime, openJtalk, options, out),
      );
      return out.value;
    } finally {
      calloc.free(out);
    }
  }
}
