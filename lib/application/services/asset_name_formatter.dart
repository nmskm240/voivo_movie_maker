abstract final class AssetNameFormatter {
  static const maxDialogueLength = 40;

  static String voice({required String speakerName, required String dialogue}) {
    final safeSpeakerName = _sanitizeFileNamePart(speakerName);
    final safeDialogue = _sanitizeFileNamePart(
      String.fromCharCodes(dialogue.runes.take(maxDialogueLength)),
    );
    return '${safeSpeakerName.isEmpty ? 'VOICEVOX' : safeSpeakerName}_'
        '${safeDialogue.isEmpty ? 'voice' : safeDialogue}.wav';
  }

  static String _sanitizeFileNamePart(String value) {
    return value
        .replaceAll(RegExp(r'[/\\:*?"<>|\x00-\x1F]'), '_')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }
}
