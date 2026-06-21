// Flutter imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/application/services/asset_name_formatter.dart';

void main() {
  group('AssetNameFormatter', () {
    test('builds a safe voice asset name and limits the dialogue length', () {
      final dialogue = List.filled(
        AssetNameFormatter.maxDialogueLength + 2,
        'あ',
      ).join();

      expect(
        AssetNameFormatter.voice(speakerName: 'ずんだもん/ノーマル', dialogue: dialogue),
        'ずんだもん_ノーマル_'
        '${List.filled(AssetNameFormatter.maxDialogueLength, 'あ').join()}'
        '.wav',
      );
    });

    test('uses defaults when sanitized parts are empty', () {
      expect(
        AssetNameFormatter.voice(speakerName: '   ', dialogue: ''),
        'VOICEVOX_voice.wav',
      );
    });
  });
}
