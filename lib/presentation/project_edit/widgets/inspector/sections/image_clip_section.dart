// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';

// Project imports:
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/update_image_component_command.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/fields/scrubbable_number_form_field.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/sections/inspector_section.dart';

class ImageClipSection extends InspectorSection<ImageComponent> {
  const ImageClipSection(super.component, super.context, {super.key});

  @override
  Widget build(BuildContext context) {
    final imageAssets = this.context.assets
        .where((asset) => asset.kind == ProjectAssetKind.image)
        .toList();
    final currentAssetExists = imageAssets.any(
      (asset) => asset.id == component.assetId,
    );

    void updateSize({double? width, double? height}) {
      final size = Size(
        width ?? component.size.width,
        height ?? component.size.height,
      );
      this.context.execute(
        UpdateImageComponentCommand(this.context.clipId, size: size),
      );
    }

    return Column(
      children: [
        FormBuilderDropdown<AssetId>(
          name: '${this.context.clipId.value}.image.asset',
          initialValue: component.assetId,
          decoration: const InputDecoration(labelText: 'Asset'),
          items: [
            if (!currentAssetExists)
              DropdownMenuItem(
                value: component.assetId,
                child: const Text('Missing asset'),
              ),
            for (final asset in imageAssets)
              DropdownMenuItem(value: asset.id, child: Text(asset.name)),
          ],
          onChanged: (assetId) {
            if (assetId != null) {
              this.context.execute(
                UpdateImageComponentCommand(
                  this.context.clipId,
                  assetId: assetId,
                ),
              );
            }
          },
        ),
        Row(
          children: [
            Expanded(
              child: ScrubbableNumberFormField(
                name: '${this.context.clipId.value}.image.width',
                label: 'Width',
                initialValue: component.size.width,
                min: 0.01,
                onChanged: (width) {
                  if (width != null) {
                    updateSize(width: width);
                  }
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ScrubbableNumberFormField(
                name: '${this.context.clipId.value}.image.height',
                label: 'Height',
                initialValue: component.size.height,
                min: 0.01,
                onChanged: (height) {
                  if (height != null) {
                    updateSize(height: height);
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
