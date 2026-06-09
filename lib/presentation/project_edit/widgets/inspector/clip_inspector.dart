import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/add_clip_component_command.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/remove_clip_component_command.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/timeline_editor_command.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/presentation/project_edit/states/timeline_select_state.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/sections/inspector_section_registry.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/view_model.dart';

class ClipInspectorPane extends ConsumerWidget {
  const ClipInspectorPane({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clipId = ref.watch(
      timelineSelectionStateProvider.select((state) => state.clipId),
    );
    ref.watch(
      timelineViewModelProvider.select((state) => state.value?.revision),
    );
    final timeline = ref.read(timelineProvider).value;
    final clip = timeline?.tracks
        .expand((track) => track.clips)
        .where((clip) => clip.id == clipId)
        .firstOrNull;
    if (clip == null) {
      return const Center(child: Text('Select a clip'));
    }

    final sections = clipInspectorSectionsFor(clip);
    final execute = ref.read(timelineViewModelProvider.notifier).execute;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: FormBuilder(
        key: ValueKey(clip.id.value),
        child: ListView(
          children: [
            Text('Components', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            for (final component in clip.components)
              _ComponentTile(
                component: component,
                onRemove: () => _removeComponent(execute, clip.id, component),
              ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () => _addComponent(context, execute, clip),
              icon: const Icon(Icons.add),
              label: const Text('Add component'),
            ),
            for (final section in sections) ...[
              const Divider(),
              section.build(context, execute, clip),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _addComponent(
    BuildContext context,
    void Function(TimelineEditorCommand) execute,
    TimelineClip clip,
  ) async {
    final available = _ComponentTemplate.values
        .where((template) => !template.existsIn(clip))
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
    if (template == null) {
      return;
    }

    execute(AddClipComponentCommand(clip.id, template.create()));
  }

  void _removeComponent(
    void Function(TimelineEditorCommand) execute,
    TimelineClipId clipId,
    ClipComponent component,
  ) {
    final command = switch (component) {
      AudioComponent() => RemoveClipComponentCommand<AudioComponent>(clipId),
      ImageComponent() => RemoveClipComponentCommand<ImageComponent>(clipId),
      TextComponent() => RemoveClipComponentCommand<TextComponent>(clipId),
      TransformComponent() => RemoveClipComponentCommand<TransformComponent>(
        clipId,
      ),
      AssetComponent() => RemoveClipComponentCommand<AssetComponent>(clipId),
      _ => throw UnsupportedError(
        'Unsupported component type: ${component.runtimeType}',
      ),
    };
    execute(command);
  }
}

enum _ComponentTemplate {
  text,
  transform,
  image,
  audio;

  String get label => switch (this) {
    text => 'Text',
    transform => 'Transform',
    image => 'Image',
    audio => 'Audio',
  };

  IconData get icon => switch (this) {
    text => Icons.text_fields,
    transform => Icons.open_with,
    image => Icons.image_outlined,
    audio => Icons.graphic_eq,
  };

  bool existsIn(TimelineClip clip) => switch (this) {
    text => clip.hasComponent<TextComponent>(),
    transform => clip.hasComponent<TransformComponent>(),
    image => clip.hasComponent<ImageComponent>(),
    audio => clip.hasComponent<AudioComponent>(),
  };

  ClipComponent create() => switch (this) {
    text => TextComponent(),
    transform => TransformComponent(),
    image => ImageComponent(),
    audio => AudioComponent(),
  };
}

class _ComponentTile extends StatelessWidget {
  const _ComponentTile({required this.component, required this.onRemove});

  final ClipComponent component;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(_labelFor(component)),
      trailing: IconButton(
        onPressed: onRemove,
        tooltip: 'Remove component',
        icon: const Icon(Icons.close),
      ),
    );
  }

  String _labelFor(ClipComponent component) => switch (component) {
    AssetComponent() => 'Asset',
    AudioComponent() => 'Audio',
    ImageComponent() => 'Image',
    TextComponent() => 'Text',
    TransformComponent() => 'Transform',
    _ => component.runtimeType.toString(),
  };
}
