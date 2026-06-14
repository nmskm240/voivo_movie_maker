// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';

// Project imports:
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/update_shape_component_command.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/fields/color_form_field.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/fields/scrubbable_number_form_field.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/sections/inspector_section.dart';

class ShapeClipSection extends InspectorSection<ShapeComponent> {
  const ShapeClipSection(super.component, super.context, {super.key});

  @override
  Widget build(BuildContext context) {
    void updateSize({double? width, double? height}) {
      final nextWidth = width ?? component.size.width;
      final nextHeight = height ?? component.size.height;
      if (nextWidth <= 0 || nextHeight <= 0) {
        return;
      }
      this.context.execute(
        UpdateShapeComponentCommand(
          this.context.clipId,
          size: Size(nextWidth, nextHeight),
        ),
      );
    }

    return Column(
      children: [
        FormBuilderDropdown<ShapeType>(
          name: '${this.context.clipId.value}.shape.type',
          initialValue: component.shapeType,
          decoration: const InputDecoration(labelText: 'Type'),
          items: const [
            DropdownMenuItem(
              value: ShapeType.rectangle,
              child: Text('Rectangle'),
            ),
            DropdownMenuItem(value: ShapeType.ellipse, child: Text('Ellipse')),
          ],
          onChanged: (type) {
            if (type != null) {
              this.context.execute(
                UpdateShapeComponentCommand(
                  this.context.clipId,
                  shapeType: type,
                ),
              );
            }
          },
        ),
        Row(
          children: [
            Expanded(
              child: ScrubbableNumberFormField(
                name: '${this.context.clipId.value}.shape.width',
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
                name: '${this.context.clipId.value}.shape.height',
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
        ColorFormField(
          name: '${this.context.clipId.value}.shape.color',
          initialValue: component.color,
          decoration: const InputDecoration(labelText: 'Color'),
          onChanged: (color) {
            if (color != null) {
              this.context.execute(
                UpdateShapeComponentCommand(this.context.clipId, color: color),
              );
            }
          },
        ),
      ],
    );
  }
}
