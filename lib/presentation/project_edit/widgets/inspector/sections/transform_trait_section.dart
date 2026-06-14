// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/update_clip_transform_command.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/fields/vector2_form_field.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/sections/inspector_section.dart';

class TransformTraitSection extends InspectorSection<TransformComponent> {
  const TransformTraitSection(super.component, super.context, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Vector2FormField(
          name: '${this.context.clipId.value}.transform.position',
          initialValue: component.position,
          stepPerPixel: 1,
          decoration: const InputDecoration(labelText: 'Position'),
          onChanged: (position) {
            if (position == null) {
              return;
            }

            this.context.execute(
              UpdateClipTransformCommand(
                this.context.clipId,
                position: position,
              ),
            );
          },
        ),
        Vector2FormField(
          name: '${this.context.clipId.value}.transform.scale',
          initialValue: component.scale,
          stepPerPixel: 0.01,
          min: 0.01,
          decoration: const InputDecoration(labelText: 'Scale'),
          onChanged: (scale) {
            if (scale == null) {
              return;
            }

            this.context.execute(
              UpdateClipTransformCommand(this.context.clipId, scale: scale),
            );
          },
        ),
      ],
    );
  }
}
