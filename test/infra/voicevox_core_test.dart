// Flutter imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/infra/voicevox_core/voicevox_core.dart';

void main() {
  test('rejects unsupported desktop platforms', () async {
    await expectLater(VoicevoxCore.create(), throwsA(isA<UnsupportedError>()));
  });
}
