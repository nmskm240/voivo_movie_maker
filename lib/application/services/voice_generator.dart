// Dart imports:
import 'dart:typed_data';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:voivo_movie_maker/application/dtos/speaker_style.dart';

final voiceGeneratorProvider = FutureProvider<IVoiceGenerator>((ref) {
  throw UnimplementedError('voiceGeneratorProvider must be overridden.');
});

abstract interface class IVoiceGenerator {
  Iterable<SpeakerStyle> get speakerStyles;

  Future<Uint8List> synthesize({required String text, required int speakerId});

  void dispose();
}
