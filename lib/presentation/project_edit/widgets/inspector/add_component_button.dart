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
    final available = _ComponentTemplate.values
        .where((template) => clip.canAddComponent(template.create()))
        .toList();
    final template = await showModalBottomSheet<_ComponentTemplate>(
      context: context,
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            for (final template in available)
              ListTile(
                leading: Icon(template.icon),
                title: Text(template.label),
                onTap: () => Navigator.of(context).pop(template),
              ),
            if (available.isEmpty)
              const ListTile(title: Text('All components are already added')),
          ],
        ),
      ),
    );
    if (template != null) {
      onAdd(template.create());
    }
  }
}

enum _ComponentTemplate {
  shape,
  text,
  transform;

  String get label => switch (this) {
    shape => 'Shape',
    text => 'Text',
    transform => 'Transform',
  };

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
