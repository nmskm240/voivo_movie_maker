// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/add_clip_component_command.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/remove_clip_component_command.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/presentation/project_edit/states/timeline_select_state.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/add_component_button.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/sections/inspector_section.dart';
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
    final assets = ref.watch(projectProvider).value?.assets.assets ?? const [];
    final timeline = ref.read(timelineProvider).value;
    final clip = timeline?.tracks
        .expand((track) => track.clips)
        .where((clip) => clip.id == clipId)
        .firstOrNull;
    if (clip == null) {
      return const Center(child: Text('Select a clip'));
    }

    final execute = ref.read(timelineViewModelProvider.notifier).execute;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: FormBuilder(
        key: ValueKey(clip.id.value),
        child: ListView(
          children: [
            Text('Components', style: Theme.of(context).textTheme.titleLarge),
            for (final component in clip.components)
              ExpansionTile(
                key: ValueKey('${clip.id.value}.${component.id.value}'),
                initiallyExpanded: true,
                tilePadding: EdgeInsets.zero,
                childrenPadding: const EdgeInsets.only(bottom: 8),
                title: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onLongPress: clip.canRemoveComponent(component.id)
                      ? () => _confirmRemoveComponent(
                          context,
                          component: component,
                          onConfirm: () => execute(
                            RemoveClipComponentCommand(clip.id, component.id),
                          ),
                        )
                      : null,
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(component.label),
                  ),
                ),
                children: [
                  ComponentInspectorRegistry.resolve(
                    component,
                    context: InspectorSectionContext(
                      clipId: clipId!,
                      execute: execute,
                      assets: assets,
                    ),
                  ),
                ],
              ),
            AddComponentButton(
              clip: clip,
              onAdd: (component) =>
                  execute(AddClipComponentCommand(clip.id, component)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmRemoveComponent(
    BuildContext context, {
    required ClipComponent component,
    required VoidCallback onConfirm,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remove ${component.label}?'),
        content: const Text('This component will be removed from the clip.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      onConfirm();
    }
  }
}
