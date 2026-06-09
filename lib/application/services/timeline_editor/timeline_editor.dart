import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/timeline_editor_command.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';

part 'timeline_editor.g.dart';

@Riverpod(dependencies: [CurrentTimeline])
TimelineEditor timelineEditor(Ref ref) {
  final timeline = ref.watch(timelineProvider).value;
  return TimelineEditor(
    timeline,
    onChanged: ref.read(timelineProvider.notifier).notifyChanged,
  );
}

class TimelineEditor {
  const TimelineEditor(this._timeline, {required void Function() onChanged})
    : _onChanged = onChanged;

  final Timeline? _timeline;
  final void Function() _onChanged;

  void execute(TimelineEditorCommand command) {
    if (_timeline == null) {
      throw Exception('No timeline available to execute command');
    }
    if (!command.canExecute(_timeline)) {
      throw Exception('Cannot execute command: ${command.runtimeType}');
    }

    command.execute(_timeline);
    _onChanged();
  }
}
