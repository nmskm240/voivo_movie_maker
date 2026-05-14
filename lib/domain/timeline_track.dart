import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';

class TimelineTrack {
  TimelineTrack({Iterable<TimelineClip> clips = const []})
    : _clips = clips.toList();

  final List<TimelineClip> _clips;

  Iterable<TimelineClip> get clips => _clips;

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

    _clips.add(clip);
    _clips.sort((a, b) => a.startFrame.compareTo(b.startFrame));
  }

  void removeClip(TimelineClipId clipId) {
    _clips.removeWhere((x) => x.id == clipId);
  }

  TimelineClip? findClip(TimelineClipId clipId) {
    try {
      return _clips.singleWhere((clip) => clip.id == clipId);
    } on StateError {
      return null;
    }
  }

  bool contains(TimelineClip clip) {
    return _clips.contains(clip);
  }

  bool containsById(TimelineClipId clipId) {
    return _clips.any((clip) => clip.id == clipId);
  }

  TimelineClip? getActiveClipAt(int frame) {
    try {
      return _clips.firstWhere((x) => x.isActiveAt(frame));
    } on StateError {
      return null;
    }
  }

  Iterable<TimelineClip> getActiveClipsAt((int start, int end) range) {
    return _clips.where(
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
    return _clips.any((clip) {
      if (clip.id == ignoringClipId) {
        return false;
      }

      return startFrame < clip.endFrame && clip.startFrame < endFrame;
    });
  }
}
