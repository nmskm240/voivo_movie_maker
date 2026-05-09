import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:voivo_movie_maker/main.dart';
import 'package:voivo_movie_maker/view_models/editor_timeline_view_model.dart';
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
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(
            body: SizedBox(width: 800, height: 280, child: TimelinePane()),
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

    final state = container.read(editorTimelineViewModelProvider);
    expect(state.currentFrame, greaterThan(900));
    expect(state.timeline.tracks[0].clips[0].startFrame, 120);
  });

  testWidgets('moves clip by dragging the clip body', (
    WidgetTester tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(
            body: SizedBox(width: 800, height: 280, child: TimelinePane()),
          ),
        ),
      ),
    );

    await tester.drag(
      find.byKey(const ValueKey('timeline-clip-clip-title')),
      const Offset(120, 0),
    );
    await tester.pump();

    final state = container.read(editorTimelineViewModelProvider);
    expect(state.selectedTrackIndex, 0);
    expect(state.selectedClipIndex, 0);
    expect(state.currentFrame, greaterThan(120));
    expect(state.timeline.tracks[0].clips[0].startFrame, greaterThan(120));
  });

  testWidgets('extends clip duration by dragging the right edge', (
    WidgetTester tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(
            body: SizedBox(width: 800, height: 280, child: TimelinePane()),
          ),
        ),
      ),
    );

    await tester.drag(
      find.byKey(const ValueKey('timeline-clip-clip-title-end-handle')),
      const Offset(80, 0),
    );
    await tester.pump();

    final clip = container
        .read(editorTimelineViewModelProvider)
        .timeline
        .tracks[0]
        .clips[0];
    expect(clip.startFrame, 120);
    expect(clip.durationFrames, greaterThan(240));
  });

  testWidgets('trims clip start by dragging the left edge', (
    WidgetTester tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(
            body: SizedBox(width: 800, height: 280, child: TimelinePane()),
          ),
        ),
      ),
    );

    await tester.drag(
      find.byKey(const ValueKey('timeline-clip-clip-title-start-handle')),
      const Offset(80, 0),
    );
    await tester.pump();

    final clip = container
        .read(editorTimelineViewModelProvider)
        .timeline
        .tracks[0]
        .clips[0];
    expect(clip.startFrame, greaterThan(120));
    expect(clip.durationFrames, lessThan(240));
    expect(clip.endFrame, 360);
  });
}
