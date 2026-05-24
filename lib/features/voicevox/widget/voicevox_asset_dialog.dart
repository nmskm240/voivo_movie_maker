import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voivo_movie_maker/application/controllers/timeline_editor/asset_clip_selection.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/features/voicevox/services/voicevox_speech_service.dart';

Future<AssetClipSelection?> showVoicevoxAssetDialog(BuildContext context) {
  return showDialog<AssetClipSelection>(
    context: context,
    builder: (context) => const VoicevoxAssetDialog(),
  );
}

class VoicevoxAssetDialog extends ConsumerStatefulWidget {
  const VoicevoxAssetDialog({super.key});

  @override
  ConsumerState<VoicevoxAssetDialog> createState() =>
      _VoicevoxAssetDialogState();
}

class _VoicevoxAssetDialogState extends ConsumerState<VoicevoxAssetDialog> {
  final _textController = TextEditingController();
  final _speakerIdController = TextEditingController(text: '0');
  bool _isGenerating = false;
  String? _errorText;

  @override
  void dispose() {
    _textController.dispose();
    _speakerIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('VOICEVOX'),
      content: SizedBox(
        width: 420,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _textController,
              minLines: 4,
              maxLines: 8,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Text',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _speakerIdController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Speaker ID',
                border: OutlineInputBorder(),
              ),
            ),
            if (_errorText != null) ...[
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _errorText!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isGenerating ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton.icon(
          onPressed: _isGenerating ? null : _generate,
          icon: _isGenerating
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.graphic_eq),
          label: const Text('Generate'),
        ),
      ],
    );
  }

  Future<void> _generate() async {
    final text = _textController.text.trim();
    final speakerId = int.tryParse(_speakerIdController.text);
    if (text.isEmpty || speakerId == null) {
      setState(() => _errorText = 'Text and speaker ID are required.');
      return;
    }

    setState(() {
      _isGenerating = true;
      _errorText = null;
    });

    try {
      final bytes = await ref.read(voicevoxSpeechServiceProvider).synthesize(
            text: text,
            speakerId: speakerId,
          );
      if (!mounted) {
        return;
      }

      Navigator.of(context).pop(
        AssetClipSelection(
          asset: ProjectAsset(
            id: AssetId.create(),
            name: _assetNameFor(text),
            kind: ProjectAssetKind.audio,
          ),
          bytes: Uint8List.fromList(bytes),
        ),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _errorText = error.toString();
        _isGenerating = false;
      });
    }
  }

  String _assetNameFor(String text) {
    final normalized = text
        .replaceAll(RegExp(r'\s+'), '_')
        .replaceAll(RegExp(r'[^0-9A-Za-z_\-]'), '')
        .trim();
    final title = normalized.isEmpty ? 'voice' : normalized;
    final clipped = title.length > 24 ? title.substring(0, 24) : title;
    return 'voicevox_${DateTime.now().microsecondsSinceEpoch}_$clipped.wav';
  }
}
