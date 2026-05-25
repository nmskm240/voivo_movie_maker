import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:voivo_movie_maker/application/dtos/speaker_style.dart';
import 'package:voivo_movie_maker/application/services/voice_generator.dart';

class VoiceEditor extends ConsumerWidget {
  VoiceEditor({required this.onCreated, super.key});

  static const _textFieldName = 'text';
  static const _speakerFieldName = 'speaker';

  final Future<void> Function(Uint8List selection) onCreated;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voiceGenerator = ref.watch(voiceGeneratorProvider);
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
                onPressed: voiceGenerator.hasValue
                    ? () => _onSubmit(voiceGenerator.requireValue)
                    : null,
                icon: const Icon(Icons.graphic_eq),
                label: const Text('Generate'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onSubmit(IVoiceGenerator voiceGenerator) async {
    final state = _formKey.currentState!;
    if (!state.saveAndValidate()) {
      return;
    }

    final audioBytes = await voiceGenerator.synthesize(
      text: state.value[VoiceEditor._textFieldName],
      speakerId: state.value[VoiceEditor._speakerFieldName],
    );
    await onCreated(audioBytes);
  }
}
