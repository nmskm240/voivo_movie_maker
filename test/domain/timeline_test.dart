// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/domain/timeline.dart';

void main() {
  test('creates an empty timeline with the initial number of tracks', () {
    final timeline = Timeline.empty();

    expect(timeline.tracks, hasLength(Timeline.initialTrackCount));
  });

  test('adds a track', () {
    final timeline = Timeline.empty();

    timeline.addTrack();

    expect(timeline.tracks, hasLength(Timeline.initialTrackCount + 1));
  });
}
