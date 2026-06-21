// Dart imports:
import 'dart:ffi';
import 'dart:io';

// Package imports:
import 'package:ffi/ffi.dart';
import 'package:voicevox_core/voicevox_core.dart';

// Project imports:
import 'package:voivo_movie_maker/infra/voicevox_core/result.dart';

final class VoiceModelFile {
  const VoiceModelFile._(this.pointer);

  final Pointer<VoicevoxVoiceModelFile> pointer;

  static VoiceModelFile open(File file) {
    final out = calloc<Pointer<VoicevoxVoiceModelFile>>();
    try {
      checkVoicevoxResult(voicevoxVoiceModelFileOpen(file.path, out));
      return VoiceModelFile._(out.value);
    } finally {
      calloc.free(out);
    }
  }

  void dispose() {
    voicevoxVoiceModelFileDelete(pointer);
  }
}
