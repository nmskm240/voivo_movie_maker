import 'package:json_annotation/json_annotation.dart';
import 'package:voivo_movie_maker/utils/json_converters.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';

part 'timeline_track.g.dart';

@JsonSerializable(explicitToJson: true)
class TimelineTrack {
  TimelineTrack({Iterable<TimelineClip> clips = const []})
    : clips = clips.toList();

  factory TimelineTrack.fromJson(Map<String, Object?> json) =>
      _$TimelineTrackFromJson(json);

  @TimelineClipJsonConverter()
  final List<TimelineClip> clips;

  Map<String, Object?> toJson() => _$TimelineTrackToJson(this);

  void addClip(TimelineClip clip) {
    if (contains(clip)) {
      throw ArgumentError.value(clip, "clip", "すでに登録済みのClip");
    }
    if (hasConflict(
      startFrame: clip.startFrame,
      endFrame: clip.endFrame,
      ignoringClipId: clip.id,
    )) {
      // FIXME: Track間移動も使っているため追加時のルールを指定できるようにして、例外にならないようにする必要がある
      throw ArgumentError.value(clip, "clip", "重複するClipがあります");
    }

    clips.add(clip);
    clips.sort((a, b) => a.startFrame.compareTo(b.startFrame));
  }

  void removeClip(TimelineClipId clipId) {
    clips.removeWhere((x) => x.id == clipId);
  }

  TimelineClip? findClip(TimelineClipId clipId) {
    try {
      return clips.singleWhere((clip) => clip.id == clipId);
    } on StateError {
      return null;
    }
  }

  bool contains(TimelineClip clip) {
    return clips.contains(clip);
  }

  bool containsById(TimelineClipId clipId) {
    return clips.any((clip) => clip.id == clipId);
  }

  TimelineClip? getActiveClipAt(int frame) {
    try {
      return clips.firstWhere((x) => x.isActiveAt(frame));
    } on StateError {
      return null;
    }
  }

  Iterable<TimelineClip> getActiveClipsAt((int start, int end) range) {
    return clips.where(
      (clip) => range.$1 < clip.endFrame && clip.startFrame < range.$2,
    );
  }

  bool canPlaceClip(TimelineClip clip, {int? startFrame, int? durationFrames}) {
    final resolvedStartFrame = startFrame ?? clip.startFrame;
    final resolvedDurationFrames = durationFrames ?? clip.durationFrames;
    final endFrame = resolvedStartFrame + resolvedDurationFrames;

    return !hasConflict(
      startFrame: resolvedStartFrame,
      endFrame: endFrame,
      ignoringClipId: clip.id,
    );
  }

  bool hasConflict({
    required int startFrame,
    required int endFrame,
    TimelineClipId? ignoringClipId,
  }) {
    return clips.any((clip) {
      if (clip.id == ignoringClipId) {
        return false;
      }

      return startFrame < clip.endFrame && clip.startFrame < endFrame;
    });
  }
}
