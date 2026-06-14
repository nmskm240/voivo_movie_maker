// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/timeline_editor_command.dart';
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/domain/project.dart';

part 'timeline_editor.g.dart';

@Riverpod(dependencies: [projectRepository])
TimelineEditor timelineEditor(Ref ref) {
  return TimelineEditor(ref.watch(projectRepositoryProvider));
}

class TimelineEditor {
  TimelineEditor(this._repository);

  final IProjectRepository _repository;
  Future<void> _saveQueue = Future.value();

  Future<void> execute(Project project, TimelineEditorCommand command) {
    if (!command.canExecute(project.timeline)) {
      throw Exception('Cannot execute command: ${command.runtimeType}');
    }

    command.execute(project.timeline);

    final save = _saveQueue.then((_) => _repository.save(project));
    _saveQueue = save.then<void>((_) {}, onError: (_, _) {});
    return save;
  }
}
