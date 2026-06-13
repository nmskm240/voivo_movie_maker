// Project imports:
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/sections/inspector_section.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/sections/shape_clip_section.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/sections/text_clip_section.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/sections/transform_trait_section.dart';

List<InspectorSection> clipInspectorSectionsFor(TimelineClip clip) {
  return <InspectorSection>[
    TransformTraitSection(),
    ShapeClipSection(),
    TextClipSection(),
  ].where((section) => section.isSupports(clip)).toList();
}
