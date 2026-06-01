import 'package:flutter/material.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/update_clip_transform_command.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/timeline_editor.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/fields/vector2_form_field.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/sections/inspector_section.dart';

class TransformTraitSection implements InspectorSection {
  @override
  Widget build(BuildContext context, TimelineEditor editor, TimelineClip? clip) {
    if (clip is! WithTransform) {
      throw Error();
    }

    return Card(
      child: Column(
        children: [
          Vector2FormField(
            name: '${clip.id.value}.transform.position',
            initialValue: clip.transform.position,
            decoration: const InputDecoration(labelText: 'Position'),
            onChanged: (position) {
              if (position == null) {
                return;
              }

              editor.execute(
                UpdateClipTransformCommand(clip.id, position: position),
              );
            },
          ),
          Vector2FormField(
            name: '${clip.id.value}.transform.scale',
            initialValue: clip.transform.scale,
            decoration: const InputDecoration(labelText: 'Scale'),
            onChanged: (scale) {
              if (scale == null) {
                return;
              }

              editor.execute(UpdateClipTransformCommand(clip.id, scale: scale));
            },
          ),
        ],
      ),
    );
  }

  @override
  bool isSupports(TimelineClip clip) {
    return clip is WithTransform;
  }
}
