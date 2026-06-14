// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:voivo_movie_maker/domain/timeline_clips.dart';

class AddComponentButton extends StatelessWidget {
  const AddComponentButton({
    required this.clip,
    required this.onAdd,
    super.key,
  });

  final TimelineClip clip;
  final ValueChanged<ClipComponent> onAdd;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => _showComponentPicker(context),
      icon: const Icon(Icons.add),
      label: const Text('Add component'),
    );
  }

  Future<void> _showComponentPicker(BuildContext context) async {
    final candidates = _ComponentTemplate.values.map((template) {
      final component = template.create();
      return (
        template: template,
        component: component,
        enabled: clip.canAddComponent(component),
      );
    }).toList();
    final component = await showModalBottomSheet<ClipComponent>(
      context: context,
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            for (final candidate in candidates)
              ListTile(
                leading: Icon(candidate.template.icon),
                title: Text(candidate.component.label),
                subtitle: candidate.enabled
                    ? null
                    : const Text('Already added'),
                enabled: candidate.enabled,
                onTap: candidate.enabled
                    ? () => Navigator.of(context).pop(candidate.component)
                    : null,
              ),
          ],
        ),
      ),
    );
    if (component != null) {
      onAdd(component);
    }
  }
}

enum _ComponentTemplate {
  shape,
  text,
  transform;

  IconData get icon => switch (this) {
    shape => Icons.category_outlined,
    text => Icons.text_fields,
    transform => Icons.open_with,
  };

  ClipComponent create() => switch (this) {
    shape => ShapeComponent(),
    text => TextComponent(),
    transform => TransformComponent(),
  };
}
