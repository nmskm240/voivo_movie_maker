// Project imports:
import 'package:flutter/material.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/components/base.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/components/image.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/components/shape.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/components/text.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/components/transform.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/sections/inspector_section.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/sections/image_clip_section.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/sections/shape_clip_section.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/sections/text_clip_section.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/sections/transform_trait_section.dart';

typedef SectionBuilder =
    Widget Function(
      ClipComponent component, {
      required InspectorSectionContext context,
    });

class ComponentInspectorRegistry {
  static final _registry = <Type, SectionBuilder>{
    ImageComponent: (component, {required context}) =>
        ImageClipSection(component as ImageComponent, context),
    ShapeComponent: (component, {required context}) =>
        ShapeClipSection(component as ShapeComponent, context),
    TextComponent: (component, {required context}) =>
        TextClipSection(component as TextComponent, context),
    TransformComponent: (component, {required context}) =>
        TransformTraitSection(component as TransformComponent, context),
  };

  static Widget resolve(
    ClipComponent component, {
    required InspectorSectionContext context,
  }) {
    final builder = _registry[component.runtimeType];
    if (builder == null) {
      throw ArgumentError.value(component, "component", "Unregister component");
    }
    return builder.call(component, context: context);
  }
}
