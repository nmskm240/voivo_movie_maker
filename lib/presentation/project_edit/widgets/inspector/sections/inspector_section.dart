// Flutter imports:
import 'package:flutter/widgets.dart';

// Project imports:
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/timeline_editor_command.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';

typedef ExecuteTimelineCommand = void Function(TimelineEditorCommand command);

abstract class InspectorSection<T extends ClipComponent>
    extends StatelessWidget {
  final T component;
  final InspectorSectionContext context;

  const InspectorSection(this.component, this.context, {super.key});

  String get title => component.label;
}

class InspectorSectionContext {
  const InspectorSectionContext({
    required this.clipId,
    required this.execute,
    this.assets = const [],
  });

  final TimelineClipId clipId;
  final ExecuteTimelineCommand execute;
  final Iterable<ProjectAsset> assets;
}
