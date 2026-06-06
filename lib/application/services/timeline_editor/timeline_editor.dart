import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/timeline_editor_command.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';

part 'timeline_editor.g.dart';

@Riverpod(dependencies: [project])
TimelineEditor timelineEditor(Ref ref) {
  final project = ref.watch(projectProvider).value;
  return TimelineEditor(project?.timeline);
}

class TimelineEditor {
  const TimelineEditor(this._timeline);

  final Timeline? _timeline;

  void execute(TimelineEditorCommand command) {
    if (_timeline == null) {
      throw Exception('No timeline available to execute command');
    }
    if (!command.canExecute(_timeline)) {
      throw Exception('Cannot execute command: ${command.runtimeType}');
    }

    command.execute(_timeline);
  }
}
