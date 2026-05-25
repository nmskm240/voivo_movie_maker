import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:voicevox_flutter/voicevox_flutter.dart';
import 'package:voivo_movie_maker/application/dtos/speaker_style.dart';
import 'package:voivo_movie_maker/extensions/ffi_pointer.dart';

final voiceGeneratorProvider = FutureProvider<IVoiceGenerator>((ref) {
  throw UnimplementedError('voiceGeneratorProvider must be overridden.');
});

abstract interface class IVoiceGenerator {
  List<SpeakerStyle> get speakerStyles;

  Future<Uint8List> synthesize({required String text, required int speakerId});
}

final class VoicevoxCoreSpeechService implements IVoiceGenerator {
  const VoicevoxCoreSpeechService._({required this.speakerStyles});

  static Future<VoicevoxCoreSpeechService> create() async {
    await _initialize();
    return VoicevoxCoreSpeechService._(speakerStyles: _loadSpeakerStyles());
  }

  @override
  final List<SpeakerStyle> speakerStyles;

  @override
  Future<Uint8List> synthesize({
    required String text,
    required int speakerId,
  }) async {
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

  static List<SpeakerStyle> _loadSpeakerStyles() {
    final metasJson = VoicevoxFlutter.instance
        .voicevox_get_metas_json()
        .toDartString();
    final speakers = (jsonDecode(metasJson) as List<Object?>)
        .cast<Map<String, Object?>>();

    return speakers
        .expand((speaker) {
          final speakerName = speaker['name'] as String;
          final styles = (speaker['styles'] as List<Object?>)
              .cast<Map<String, Object?>>();
          return styles.map(
            (style) => SpeakerStyle.fromJson({
              ...style,
              'speakerName': speakerName,
              'styleName': style['name'],
            }),
          );
        })
        .toList(growable: false);
  }

  static Future<void> _initialize() async {
    final executableDirectory = p.dirname(Platform.resolvedExecutable);
    final modelDirectory = Directory(
      p.join(executableDirectory, 'voicevox/model'),
    );
    final openJtalkDirectory = Directory(
      p.join(executableDirectory, 'voicevox/open_jtalk_dic_utf_8-1.11'),
    );

    if (!modelDirectory.existsSync() || !openJtalkDirectory.existsSync()) {
      throw StateError(
        'Bundled VOICEVOX runtime files were not found under '
        '$executableDirectory/voicevox.',
      );
    }

    await VoicevoxFlutter.instance.initialize(
      modelPath: modelDirectory.path,
      openJdkDictPath: openJtalkDirectory.path,
      cpuNumThreads: Platform.numberOfProcessors.clamp(1, 4).toInt(),
      loadAllModels: true,
    );
  }
}
