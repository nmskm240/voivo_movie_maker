import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';
import 'package:voivo_movie_maker/features/inspector/widget/sections/inspector_section.dart';
import 'package:voivo_movie_maker/features/inspector/widget/sections/text_clip_section.dart';
import 'package:voivo_movie_maker/features/inspector/widget/sections/transform_trait_section.dart';

List<InspectorSection> clipInspectorSectionsFor(TimelineClip clip) {
  final sections = switch (clip.kind) {
    TimelineClipKind.text => [TransformTraitSection(), TextClipSection()],
    TimelineClipKind.image => [TransformTraitSection()],
    TimelineClipKind.audio => <InspectorSection>[],
  };

  if (sections.any((section) => !section.isSupports(clip))) {
    throw Error();
  }

  return sections;
}
