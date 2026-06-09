import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/update_text_clip_command.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/fields/color_form_field.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/sections/inspector_section.dart';

class TextClipSection implements InspectorSection {
  @override
  Widget build(
    BuildContext context,
    ExecuteTimelineCommand execute,
    TimelineClip? clip,
  ) {
    final text = clip?.component<TextComponent>();
    if (clip == null || text == null) {
      throw Error();
    }

    return Card(
      child: Column(
        children: [
          FormBuilderTextField(
            name: '${clip.id.value}.text',
            initialValue: text.text,
            maxLines: 4,
            onChanged: (text) {
              execute(UpdateTextClipCommand(clip.id, text: text));
            },
          ),
          ColorFormField(
            name: '${clip.id.value}.color',
            initialValue: text.color,
            decoration: const InputDecoration(labelText: 'Color'),
            onChanged: (color) {
              if (color == null) {
                return;
              }

              execute(UpdateTextClipCommand(clip.id, textColor: color));
            },
          ),
        ],
      ),
    );
  }

  @override
  bool isSupports(TimelineClip clip) {
    return clip.hasComponent<TextComponent>();
  }
}
