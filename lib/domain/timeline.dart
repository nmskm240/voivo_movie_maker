import 'package:voivo_movie_maker/domain/timeline_clip.dart';
import 'package:voivo_movie_maker/domain/timeline_track.dart';

class Timeline {
  Timeline({Iterable<TimelineTrack> tracks = const []})
    : _tracks = tracks.toList();

  final List<TimelineTrack> _tracks;

  Iterable<TimelineTrack> get tracks => _tracks;

  Iterable<TimelineClip> getActiveClipsAt(int frame) {
    return tracks
        .map((x) => x.getActiveClipAt(frame))
        .where((x) => x != null)
        .map((x) => x as TimelineClip);
  }
}
