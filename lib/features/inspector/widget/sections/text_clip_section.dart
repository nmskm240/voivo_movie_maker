import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:voivo_movie_maker/application/controllers/timeline_editor/commands/update_text_clip_command.dart';
import 'package:voivo_movie_maker/application/controllers/timeline_editor/timeline_editor.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/features/inspector/widget/fields/color_form_field.dart';
import 'package:voivo_movie_maker/features/inspector/widget/sections/inspector_section.dart';

class TextClipSection implements InspectorSection {
  @override
  Widget build(BuildContext context, TimelineEditor editor, TimelineClip? clip) {
    if (clip is! TextClip) {
      throw Error();
    }

    return Card(
      child: Column(
        children: [
          FormBuilderTextField(
            name: '${clip.id.value}.text',
            initialValue: clip.text,
            maxLines: 4,
            onChanged: (text) {
              editor.execute(UpdateTextClipCommand(clip.id, text: text));
            },
          ),
          ColorFormField(
            name: '${clip.id.value}.color',
            initialValue: clip.color,
            decoration: const InputDecoration(labelText: 'Color'),
            onChanged: (color) {
              if (color == null) {
                return;
              }

              editor.execute(UpdateTextClipCommand(clip.id, textColor: color));
            },
          ),
        ],
      ),
    );
  }

  @override
  bool isSupports(TimelineClip clip) {
    return clip is TextClip;
  }
}
