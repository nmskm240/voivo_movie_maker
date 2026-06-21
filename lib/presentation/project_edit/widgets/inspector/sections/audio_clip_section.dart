// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';

// Project imports:
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/update_audio_component_command.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/fields/scrubbable_number_form_field.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/sections/inspector_section.dart';

class AudioClipSection extends InspectorSection<AudioComponent> {
  const AudioClipSection(super.component, super.context, {super.key});

  @override
  Widget build(BuildContext context) {
    final audioAssets = this.context.assets
        .where((asset) => asset.kind == ProjectAssetKind.audio)
        .toList();
    final currentAssetExists = audioAssets.any(
      (asset) => asset.id == component.assetId,
    );

    return Column(
      children: [
        FormBuilderDropdown<AssetId>(
          name: '${this.context.clipId.value}.audio.asset',
          initialValue: component.assetId,
          decoration: const InputDecoration(labelText: 'Asset'),
          items: [
            if (!currentAssetExists)
              DropdownMenuItem(
                value: component.assetId,
                child: const Text('Missing asset'),
              ),
            for (final asset in audioAssets)
              DropdownMenuItem(value: asset.id, child: Text(asset.name)),
          ],
          onChanged: (assetId) {
            if (assetId != null) {
              this.context.execute(
                UpdateAudioComponentCommand(
                  this.context.clipId,
                  assetId: assetId,
                ),
              );
            }
          },
        ),
        ScrubbableNumberFormField(
          name: '${this.context.clipId.value}.audio.volume',
          label: 'Volume',
          initialValue: component.volume,
          min: 0,
          stepPerPixel: 0.01,
          onChanged: (volume) {
            if (volume != null) {
              this.context.execute(
                UpdateAudioComponentCommand(
                  this.context.clipId,
                  volume: volume,
                ),
              );
            }
          },
        ),
        FormBuilderSwitch(
          name: '${this.context.clipId.value}.audio.muted',
          title: const Text('Muted'),
          initialValue: component.muted,
          onChanged: (muted) {
            if (muted != null) {
              this.context.execute(
                UpdateAudioComponentCommand(this.context.clipId, muted: muted),
              );
            }
          },
        ),
      ],
    );
  }
}
