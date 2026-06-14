// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';

// Project imports:
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/update_text_clip_command.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/fields/color_form_field.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/sections/inspector_section.dart';

class TextClipSection extends InspectorSection<TextComponent> {
  const TextClipSection(super.component, super.context, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormBuilderTextField(
          name: '${this.context.clipId.value}.text',
          initialValue: component.text,
          maxLines: 4,
          onChanged: (text) {
            this.context.execute(
              UpdateTextClipCommand(this.context.clipId, text: text),
            );
          },
        ),
        ColorFormField(
          name: '${this.context.clipId.value}.color',
          initialValue: component.color,
          decoration: const InputDecoration(labelText: 'Color'),
          onChanged: (color) {
            if (color == null) {
              return;
            }

            this.context.execute(
              UpdateTextClipCommand(this.context.clipId, textColor: color),
            );
          },
        ),
      ],
    );
  }
}
