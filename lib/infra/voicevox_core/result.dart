// Package imports:
import 'package:voicevox_core/voicevox_core.dart';

void checkVoicevoxResult(int resultCode) {
  if (resultCode == 0) return;
  throw StateError(
    voicevoxErrorResultToMessage(resultCode) ??
        'VOICEVOX Core failed with result code $resultCode.',
  );
}
