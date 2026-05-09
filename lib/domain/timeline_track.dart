import 'package:voivo_movie_maker/domain/timeline_clip.dart';

class TimelineTrack {
  TimelineTrack({Iterable<TimelineClip> clips = const []})
    : _clips = clips.toList();

  final List<TimelineClip> _clips;

  Iterable<TimelineClip> get clips => _clips;

  void addClip(TimelineClip clip) {
    if (_clips.contains(clip)) {
      return;
    }
    _clips.add(clip);
  }

  void removeClip(String clipId) {
    _clips.removeWhere((x) => x.id == clipId);
  }

  TimelineClip? getActiveClipAt(int frame) {
    try {
      return _clips.firstWhere((x) => x.isActiveAt(frame));
    } on StateError {
      return null;
    }
  }
}
