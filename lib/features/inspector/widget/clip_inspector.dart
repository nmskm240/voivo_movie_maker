import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:voivo_movie_maker/application/controllers/timeline_editor/timeline_editor.dart';
import 'package:voivo_movie_maker/features/inspector/providers.dart';
import 'package:voivo_movie_maker/features/inspector/widget/sections/inspector_section.dart';
import 'package:voivo_movie_maker/features/inspector/widget/sections/inspector_section_registry.dart';

class ClipInspectorPane extends ConsumerWidget {
  const ClipInspectorPane({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clip = ref.watch(selectedTimelineClipProvider);
    final sections = clip == null
        ? <InspectorSection>[]
        : clipInspectorSectionsFor(clip);
    final editor = ref.read(timelineEditorProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: FormBuilder(
        key: ValueKey(clip?.id.value),
        child: ListView.separated(
          itemCount: sections.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            return sections[index].build(context, editor, clip);
          },
        ),
      ),
    );
  }
}
