import 'package:voivo_movie_maker/domain/timeline_clip.dart';

class TimelineTrack {
  TimelineTrack({required this.id, Iterable<TimelineClip> clips = const []})
    : _clips = clips.toList();

  final String id;
  final List<TimelineClip> _clips;

  Iterable<TimelineClip> get clips => _clips;

  void addClip(TimelineClip clip) {
    if (_clips.contains(clip)) {
      return;
    }
    _clips.add(clip);
  }

  void removeClip(String id) {
    _clips.removeWhere((x) => x.id == id);
  }

  TimelineClip? getActiveClipAt(int frame) {
    try {
      return _clips.firstWhere((x) => x.isActiveAt(frame));
    } on StateError {
      return null;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TimelineTrack && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
