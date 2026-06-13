// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:voivo_movie_maker/application/dtos/timeline_info.dart';
import 'package:voivo_movie_maker/domain/project.dart';

part 'project_info.freezed.dart';

@freezed
sealed class ProjectInfo with _$ProjectInfo {
  const factory ProjectInfo({
    required double width,
    required double height,
    required int fps,
    required int sampleRate,
    required TimelineInfo timeline,
  }) = _ProjectInfo;

  factory ProjectInfo.fromEntity(Project entity) {
    return ProjectInfo(
      width: entity.width,
      height: entity.height,
      fps: entity.fps,
      sampleRate: entity.sampleRate,
      timeline: TimelineInfo.fromEntity(entity.timeline),
    );
  }
}
