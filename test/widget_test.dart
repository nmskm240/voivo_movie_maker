import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:voivo_movie_maker/data/mock_timeline.dart';
import 'package:voivo_movie_maker/main.dart';
import 'package:voivo_movie_maker/widgets/timeline.dart';

void main() {
  testWidgets('shows the editor mock layout', (WidgetTester tester) async {
    await tester.pumpWidget(const VoivoMovieMakerApp());

    expect(find.text('Voivo Movie Maker'), findsOneWidget);
    expect(find.text('インスペクター'), findsOneWidget);
    expect(find.text('タイムライン'), findsOneWidget);
    expect(find.text('プレビューする'), findsNothing);
    expect(find.byIcon(Icons.play_arrow), findsOneWidget);
  });

  testWidgets('selects a timeline clip and updates inspector', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const VoivoMovieMakerApp());

    expect(find.text('タイトル'), findsOneWidget);
    expect(find.text('字幕: こんにちは'), findsWidgets);

    await tester.tap(find.text('タイトル'));
    await tester.pump();

    expect(find.text('タイトル'), findsNWidgets(2));
    expect(find.text('Voivo Movie Maker'), findsWidgets);
  });

  testWidgets('scrubs preview frame by dragging empty timeline area', (
    WidgetTester tester,
  ) async {
    int? scrubbedFrame;
    int? movedStartFrame;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 800,
            height: 280,
            child: TimelinePane(
              timeline: mockProject.timeline,
              currentFrame: 540,
              selectedTrackIndex: 0,
              selectedClipIndex: 1,
              onSelectClip: (_, _) {},
              onScrubFrame: (frame) => scrubbedFrame = frame,
              onMoveClip: (_, _, startFrame) => movedStartFrame = startFrame,
            ),
          ),
        ),
      ),
    );

    final trackRect = tester.getRect(
      find.byKey(const ValueKey('timeline-track-0-surface')),
    );
    await tester.dragFrom(
      Offset(trackRect.right - 24, trackRect.center.dy),
      const Offset(-48, 0),
    );
    await tester.pump();

    expect(scrubbedFrame, isNotNull);
    expect(scrubbedFrame, greaterThan(900));
    expect(movedStartFrame, isNull);
  });

  testWidgets('moves clip by dragging the clip body', (
    WidgetTester tester,
  ) async {
    int? scrubbedFrame;
    int? movedTrackIndex;
    int? movedClipIndex;
    int? movedStartFrame;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 800,
            height: 280,
            child: TimelinePane(
              timeline: mockProject.timeline,
              currentFrame: 120,
              selectedTrackIndex: 0,
              selectedClipIndex: 0,
              onSelectClip: (_, _) {},
              onScrubFrame: (frame) => scrubbedFrame = frame,
              onMoveClip: (trackIndex, clipIndex, startFrame) {
                movedTrackIndex = trackIndex;
                movedClipIndex = clipIndex;
                movedStartFrame = startFrame;
              },
            ),
          ),
        ),
      ),
    );

    await tester.drag(
      find.byKey(const ValueKey('timeline-clip-clip-title')),
      const Offset(120, 0),
    );
    await tester.pump();

    expect(scrubbedFrame, isNull);
    expect(movedTrackIndex, 0);
    expect(movedClipIndex, 0);
    expect(movedStartFrame, greaterThan(120));
  });
}
