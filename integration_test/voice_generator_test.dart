// Flutter imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

// Project imports:
import 'package:voivo_movie_maker/infra/voicevox_core/voicevox_core.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('initializes VOICEVOX Core and synthesizes WAV audio', (
    tester,
  ) async {
    final generator = await VoicevoxCore.create();
    addTearDown(generator.dispose);

    expect(generator.speakerStyles, isNotEmpty);
    final wav = await generator.synthesize(
      text: 'こんにちは',
      speakerId: generator.speakerStyles.first.id,
    );

    expect(wav, hasLength(greaterThan(44)));
    expect(String.fromCharCodes(wav.take(4)), 'RIFF');
  });
}
