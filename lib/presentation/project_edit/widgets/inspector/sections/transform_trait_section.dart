// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/update_clip_transform_command.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/fields/vector2_form_field.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/sections/inspector_section.dart';

class TransformTraitSection implements InspectorSection {
  @override
  Widget build(
    BuildContext context,
    ExecuteTimelineCommand execute,
    TimelineClip? clip,
  ) {
    final transform = clip?.component<TransformComponent>();
    if (clip == null || transform == null) {
      throw Error();
    }

    return Card(
      child: Column(
        children: [
          Vector2FormField(
            name: '${clip.id.value}.transform.position',
            initialValue: transform.position,
            decoration: const InputDecoration(labelText: 'Position'),
            onChanged: (position) {
              if (position == null) {
                return;
              }

              execute(UpdateClipTransformCommand(clip.id, position: position));
            },
          ),
          Vector2FormField(
            name: '${clip.id.value}.transform.scale',
            initialValue: transform.scale,
            decoration: const InputDecoration(labelText: 'Scale'),
            onChanged: (scale) {
              if (scale == null) {
                return;
              }

              execute(UpdateClipTransformCommand(clip.id, scale: scale));
            },
          ),
        ],
      ),
    );
  }

  @override
  bool isSupports(TimelineClip clip) {
    return clip.hasComponent<TransformComponent>();
  }
}
