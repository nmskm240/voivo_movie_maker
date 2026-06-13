// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';
import 'package:voivo_movie_maker/domain/timeline_track.dart';

part 'timeline.g.dart';

@JsonSerializable(explicitToJson: true)
class Timeline {
  Timeline({Iterable<TimelineTrack> tracks = const []})
    : _tracks = tracks.toList();

  factory Timeline.fromJson(Map<String, Object?> json) =>
      _$TimelineFromJson(json);

  factory Timeline.empty() {
    return Timeline(tracks: List.generate(50, (index) => TimelineTrack()));
  }

  @JsonKey(name: 'tracks')
  final List<TimelineTrack> _tracks;

  Iterable<TimelineTrack> get tracks => _tracks;

  Map<String, Object?> toJson() => _$TimelineToJson(this);

  void moveClipToTrack(
    TimelineClipId clipId,
    int targetTrackIndex, {
    int? startFrame,
  }) {
    final sourceTrack = _tracks.singleWhere(
      (track) => track.containsById(clipId),
    );
    final targetTrack = _tracks.elementAt(targetTrackIndex);
    final clip = sourceTrack.findClip(clipId);
    if (clip == null) {
      return;
    }

    final resolvedStartFrame = startFrame ?? clip.startFrame;
    if (resolvedStartFrame < 0 ||
        !targetTrack.canPlaceClip(clip, startFrame: resolvedStartFrame)) {
      return;
    }

    sourceTrack.removeClip(clipId);
    clip.moveTo(resolvedStartFrame);
    targetTrack.addClip(clip);
  }

  Iterable<TimelineClip> getActiveClipsAt(int frame) {
    return tracks
        .map((x) => x.getActiveClipAt(frame))
        .where((x) => x != null)
        .map((x) => x as TimelineClip);
  }

  TimelineClip getClipById(TimelineClipId clipId) {
    return tracks
        .expand((track) => track.clips)
        .firstWhere((clip) => clip.id == clipId);
  }

  TimelineTrack getTrackByClipId(TimelineClipId clipId) {
    return tracks.firstWhere((track) => track.containsById(clipId));
  }
}
