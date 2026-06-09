import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/timeline_editor_command.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';

part 'timeline_editor.g.dart';

@riverpod
TimelineEditor timelineEditor(Ref ref) => const TimelineEditor();

class TimelineEditor {
  const TimelineEditor();

  void execute(Timeline timeline, TimelineEditorCommand command) {
    if (!command.canExecute(timeline)) {
      throw Exception('Cannot execute command: ${command.runtimeType}');
    }

    command.execute(timeline);
  }
}
