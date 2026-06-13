// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:voivo_movie_maker/application/dtos/project_info.dart';
import 'package:voivo_movie_maker/application/providers.dart';

part "view_model.freezed.dart";
part "view_model.g.dart";

@freezed
sealed class ProjectEditState with _$ProjectEditState {
  const factory ProjectEditState({required ProjectInfo project}) =
      _ProjectEditState;
}

@Riverpod(dependencies: [project])
class ProjectEditViewModel extends _$ProjectEditViewModel {
  @override
  Future<ProjectEditState> build() async {
    final project = await ref.watch(projectProvider.future);
    return ProjectEditState(project: ProjectInfo.fromEntity(project));
  }
}
