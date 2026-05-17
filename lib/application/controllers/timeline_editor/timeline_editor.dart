import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:voivo_movie_maker/application/controllers/timeline_editor/commands/timeline_editor_command.dart';
import 'package:voivo_movie_maker/application/providers/loaded_project_provider.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';

part 'timeline_editor.g.dart';

@riverpod
TimelineEditor timelineEditor(Ref ref) {
  final timeline = ref.watch(loadedProjectProvider).project.timeline;
  final markChanged = ref.read(loadedProjectProvider.notifier).markChanged;
  return TimelineEditor(timeline, markChanged);
}

class TimelineEditor {
  const TimelineEditor(this._timeline, this._markChanged);

  final Timeline _timeline;
  final void Function() _markChanged;

  void execute(TimelineEditorCommand command) {
    if (!command.canExecute(_timeline)) {
      return;
    }

    command.execute(_timeline);
    _markChanged();
  }
}
