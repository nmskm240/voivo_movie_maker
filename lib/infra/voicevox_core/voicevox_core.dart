// Dart imports:
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

// Package imports:
import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as p;
import 'package:voicevox_core/voicevox_core.dart';

// Project imports:
import 'package:voivo_movie_maker/application/dtos/speaker_style.dart';
import 'package:voivo_movie_maker/application/services/voice_generator.dart';

import 'native_handles.dart';
import 'result.dart';
import 'runtime_assets.dart';
import 'speaker_styles.dart';
import 'voice_model_file.dart';

final class VoicevoxCore implements IVoiceGenerator {
  VoicevoxCore._({
    required VoicevoxNativeHandles handles,
    required this.speakerStyles,
  }) : _handles = handles;

  final VoicevoxNativeHandles _handles;
  bool _disposed = false;

  @override
  final List<SpeakerStyle> speakerStyles;

  static Future<VoicevoxCore> create() async {
    _ensureSupportedPlatform();
    _configureDynamicLibrary();
    final runtimeAssets = await VoicevoxRuntimeAssets.extract();
    final handles = await VoicevoxNativeHandles.create(runtimeAssets);

    try {
      await _loadModels(handles.synthesizer, runtimeAssets.modelDirectory);
      return VoicevoxCore._(
        handles: handles,
        speakerStyles: loadVoicevoxSpeakerStyles(handles.synthesizer),
      );
    } catch (_) {
      handles.dispose();
      rethrow;
    }
  }

  @override
  Future<Uint8List> synthesize({
    required String text,
    required int speakerId,
  }) async {
    if (_disposed) {
      throw StateError('VOICEVOX Core has already been disposed.');
    }
    if (text.trim().isEmpty) {
      throw ArgumentError.value(text, 'text', 'Text cannot be empty');
    }

    final wavLength = calloc<Uint64>();
    final wav = calloc<Pointer<Uint8>>();
    try {
      checkVoicevoxResult(
        voicevoxSynthesizerTts(
          _handles.synthesizer,
          text,
          speakerId,
          voicevoxMakeDefaultTtsOptions(),
          wavLength,
          wav,
        ),
      );
      return Uint8List.fromList(wav.value.asTypedList(wavLength.value));
    } finally {
      voicevoxWavFree(wav.value);
      calloc.free(wavLength);
      calloc.free(wav);
    }
  }

  @override
  void dispose() {
    if (_disposed) return;
    _disposed = true;
    _handles.dispose();
  }

  static void _ensureSupportedPlatform() {
    if (!Platform.isAndroid && !Platform.isIOS) {
      throw UnsupportedError('VOICEVOX Core is supported on Android and iOS.');
    }
  }

  static void _configureDynamicLibrary() {
    final library = VoicevoxCoreDynamicLibraryService();
    library.set(
      'core',
      Platform.isAndroid
          ? 'libvoicevox_core.so'
          : 'voicevox_core.framework/voicevox_core',
    );
  }

  static Future<void> _loadModels(
    Pointer<VoicevoxSynthesizer> synthesizer,
    Directory modelDirectory,
  ) async {
    final modelFiles = await modelDirectory
        .list()
        .where((entry) => entry is File && p.extension(entry.path) == '.vvm')
        .cast<File>()
        .toList();
    if (modelFiles.isEmpty) {
      throw StateError('No VOICEVOX voice models were found.');
    }

    for (final file in modelFiles) {
      final model = VoiceModelFile.open(file);
      try {
        checkVoicevoxResult(
          voicevoxSynthesizerLoadVoiceModel(synthesizer, model.pointer),
        );
      } finally {
        model.dispose();
      }
    }
  }
}
