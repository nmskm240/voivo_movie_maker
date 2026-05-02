import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:voivo_movie_maker/main.dart';

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
}
