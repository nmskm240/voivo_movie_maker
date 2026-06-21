// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:skeletonizer/skeletonizer.dart';

// Project imports:
import 'package:voivo_movie_maker/application/dtos/speaker_style.dart';
import 'package:voivo_movie_maker/application/services/voice_generator.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/voice_generation/voice_generation_progress_dialog.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/voice_generation/voice_editor_view_model.dart';

class VoiceEditor extends ConsumerStatefulWidget {
  const VoiceEditor({required this.onCreated, super.key});

  static const _textFieldName = 'text';
  static const _speakerFieldName = 'speaker';

  final Future<void> Function(ProjectAsset asset) onCreated;
  @override
  ConsumerState<VoiceEditor> createState() => _VoiceEditorState();
}

class _VoiceEditorState extends ConsumerState<VoiceEditor> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final voiceGenerator = ref.watch(voiceGeneratorProvider);
    final generation = ref.watch(voiceEditorViewModelProvider);
    final generating = generation.isLoading;
    if (voiceGenerator.hasError) {
      return SizedBox(
        height: 56,
        child: Row(
          children: [
            const Icon(Icons.error_outline),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'VOICEVOX is unavailable: ${voiceGenerator.error}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              onPressed: () => ref.invalidate(voiceGeneratorProvider),
              tooltip: 'Retry VOICEVOX',
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
      );
    }
    final styles = voiceGenerator.maybeWhen(
      data: (generator) => generator.speakerStyles,
      orElse: () => const <SpeakerStyle>[],
    );

    return SizedBox(
      height: 56,
      width: double.infinity,
      child: Skeletonizer(
        enabled: voiceGenerator.isLoading,
        child: FormBuilder(
          key: _formKey,
          child: Row(
            spacing: 18,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 260,
                child: FormBuilderDropdown<int>(
                  name: VoiceEditor._speakerFieldName,
                  initialValue: styles.isNotEmpty ? styles.first.id : null,
                  isExpanded: true,
                  menuMaxHeight: 280,
                  enabled: styles.isNotEmpty,
                  decoration: const InputDecoration(
                    labelText: 'Speaker',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  items: [
                    for (final style in styles)
                      DropdownMenuItem(
                        value: style.id,
                        child: Text(
                          style.label,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                  validator: FormBuilderValidators.required(),
                ),
              ),
              Expanded(
                child: FormBuilderTextField(
                  name: VoiceEditor._textFieldName,
                  decoration: const InputDecoration(
                    labelText: 'Text',
                    isDense: true,
                  ),
                  validator: FormBuilderValidators.required(),
                ),
              ),
              FilledButton.icon(
                onPressed: voiceGenerator.hasValue && !generating
                    ? _onSubmit
                    : null,
                icon: generating
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.graphic_eq),
                label: const Text('Generate'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onSubmit() async {
    final state = _formKey.currentState!;
    if (!state.saveAndValidate()) {
      return;
    }

    var dialogIsOpen = false;
    try {
      dialogIsOpen = true;
      unawaited(
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (context) => const VoiceGenerationProgressDialog(),
        ),
      );
      final dialogue = state.value[VoiceEditor._textFieldName] as String;
      final speakerId = state.value[VoiceEditor._speakerFieldName] as int;
      final asset = await ref
          .read(voiceEditorViewModelProvider.notifier)
          .generate(dialogue: dialogue, speakerId: speakerId);
      if (!mounted) {
        return;
      }
      await widget.onCreated(asset);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Voice generation failed: $error')),
        );
      }
    } finally {
      if (dialogIsOpen && mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    }
  }
}
