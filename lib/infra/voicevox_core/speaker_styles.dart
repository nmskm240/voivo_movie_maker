// Dart imports:
import 'dart:convert';
import 'dart:ffi';

// Package imports:
import 'package:ffi/ffi.dart';
import 'package:voicevox_core/voicevox_core.dart';

// Project imports:
import 'package:voivo_movie_maker/application/dtos/speaker_style.dart';

List<SpeakerStyle> loadVoicevoxSpeakerStyles(
  Pointer<VoicevoxSynthesizer> synthesizer,
) {
  final metas = voicevoxSynthesizerCreateMetasJson(synthesizer);
  try {
    final speakers =
        (jsonDecode(metas.cast<Utf8>().toDartString()) as List<Object?>)
            .cast<Map<String, Object?>>();
    return speakers
        .expand((speaker) {
          final speakerName = speaker['name'] as String;
          return (speaker['styles'] as List<Object?>)
              .cast<Map<String, Object?>>()
              .where(
                (style) => style['type'] == null || style['type'] == 'talk',
              )
              .map(
                (style) => SpeakerStyle(
                  speakerName: speakerName,
                  styleName: style['name'] as String,
                  id: (style['id'] as num).toInt(),
                ),
              );
        })
        .toList(growable: false);
  } finally {
    voicevoxJsonFree(metas);
  }
}
