import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';

part "loaded_project_provider.g.dart";

@riverpod
class LoadedProject extends _$LoadedProject {
  @override
  Project build() {
    return Project.empty();
  }

  void updateTimeline(Timeline timeline) {
    state = Project(timeline: timeline);
  }
}
