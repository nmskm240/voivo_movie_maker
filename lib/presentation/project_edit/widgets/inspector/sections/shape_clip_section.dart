import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/update_shape_component_command.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/fields/color_form_field.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/sections/inspector_section.dart';

class ShapeClipSection implements InspectorSection {
  @override
  Widget build(
    BuildContext context,
    ExecuteTimelineCommand execute,
    TimelineClip? clip,
  ) {
    final shape = clip?.component<ShapeComponent>();
    if (clip == null || shape == null) {
      throw Error();
    }

    void updateSize({double? width, double? height}) {
      final nextWidth = width ?? shape.size.width;
      final nextHeight = height ?? shape.size.height;
      if (nextWidth <= 0 || nextHeight <= 0) {
        return;
      }
      execute(
        UpdateShapeComponentCommand(clip.id, size: Size(nextWidth, nextHeight)),
      );
    }

    return Card(
      child: Column(
        children: [
          FormBuilderDropdown<ShapeType>(
            name: '${clip.id.value}.shape.type',
            initialValue: shape.shapeType,
            decoration: const InputDecoration(labelText: 'Shape'),
            items: const [
              DropdownMenuItem(
                value: ShapeType.rectangle,
                child: Text('Rectangle'),
              ),
              DropdownMenuItem(
                value: ShapeType.ellipse,
                child: Text('Ellipse'),
              ),
            ],
            onChanged: (type) {
              if (type != null) {
                execute(UpdateShapeComponentCommand(clip.id, shapeType: type));
              }
            },
          ),
          Row(
            children: [
              Expanded(
                child: FormBuilderTextField(
                  name: '${clip.id.value}.shape.width',
                  initialValue: shape.size.width.toString(),
                  decoration: const InputDecoration(labelText: 'Width'),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onChanged: (value) {
                    final width = double.tryParse(value ?? '');
                    if (width != null) {
                      updateSize(width: width);
                    }
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FormBuilderTextField(
                  name: '${clip.id.value}.shape.height',
                  initialValue: shape.size.height.toString(),
                  decoration: const InputDecoration(labelText: 'Height'),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onChanged: (value) {
                    final height = double.tryParse(value ?? '');
                    if (height != null) {
                      updateSize(height: height);
                    }
                  },
                ),
              ),
            ],
          ),
          ColorFormField(
            name: '${clip.id.value}.shape.color',
            initialValue: shape.color,
            decoration: const InputDecoration(labelText: 'Color'),
            onChanged: (color) {
              if (color != null) {
                execute(UpdateShapeComponentCommand(clip.id, color: color));
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  bool isSupports(TimelineClip clip) {
    return clip.hasComponent<ShapeComponent>();
  }
}
