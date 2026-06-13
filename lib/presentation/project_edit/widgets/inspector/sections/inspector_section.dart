// Flutter imports:
import 'package:flutter/widgets.dart';

// Project imports:
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/timeline_editor_command.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';

typedef ExecuteTimelineCommand = void Function(TimelineEditorCommand command);

abstract interface class InspectorSection {
  bool isSupports(TimelineClip clip);
  Widget build(
    BuildContext context,
    ExecuteTimelineCommand execute,
    TimelineClip? clip,
  );
}
