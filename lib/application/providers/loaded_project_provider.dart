import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:voivo_movie_maker/domain/project.dart';

part "loaded_project_provider.freezed.dart";
part "loaded_project_provider.g.dart";

@freezed
sealed class ProjectSnapshot with _$ProjectSnapshot {
  const factory ProjectSnapshot({
    required Project project,
    @Default(0) int revision,
  }) = _ProjectSnapshot;
}

@riverpod
class LoadedProject extends _$LoadedProject {
  @override
  ProjectSnapshot build() {
    return ProjectSnapshot(project: Project.empty());
  }

  void markChanged() {
    state = state.copyWith(revision: state.revision + 1);
  }
}
