import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/add_clip_component_command.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/remove_clip_component_command.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/presentation/project_edit/states/timeline_select_state.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/add_component_button.dart';
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
                onRemove: () =>
                    execute(RemoveClipComponentCommand(clip.id, component.id)),
              ),
            const SizedBox(height: 8),
            AddComponentButton(
              clip: clip,
              onAdd: (component) =>
                  execute(AddClipComponentCommand(clip.id, component)),
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
    ShapeComponent() => 'Shape',
    TextComponent() => 'Text',
    TransformComponent() => 'Transform',
    _ => component.runtimeType.toString(),
  };
}
