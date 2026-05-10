import 'package:voivo_movie_maker/domain/timeline_clip.dart';
import 'package:voivo_movie_maker/domain/timeline_track.dart';

class Timeline {
  Timeline({Iterable<TimelineTrack> tracks = const []})
    : _tracks = tracks.toList();

  factory Timeline.empty() {
    return Timeline(tracks: List.generate(50, (index) => TimelineTrack()));
  }

  final List<TimelineTrack> _tracks;

  Iterable<TimelineTrack> get tracks => _tracks;

  void moveClipToTrack(String clipId, int targetTrackIndex) {
    final sourceTrack = _tracks.singleWhere(
      (track) => track.containsById(clipId),
    );
    final targetTrack = _tracks.elementAt(targetTrackIndex);
    final clip = sourceTrack.findClip(clipId);
    if (clip == null) {
      return;
    }

    if (!targetTrack.canPlaceClip(clip)) {
      return;
    }

    targetTrack.addClip(clip);
    sourceTrack.removeClip(clipId);
  }

  Iterable<TimelineClip> getActiveClipsAt(int frame) {
    return tracks
        .map((x) => x.getActiveClipAt(frame))
        .where((x) => x != null)
        .map((x) => x as TimelineClip);
  }

  TimelineClip getClipById(String clipId) {
    return tracks
        .expand((track) => track.clips)
        .firstWhere((clip) => clip.id == clipId);
  }

  TimelineTrack getTrackByClipId(String clipId) {
    return tracks.firstWhere((track) => track.containsById(clipId));
  }
}
