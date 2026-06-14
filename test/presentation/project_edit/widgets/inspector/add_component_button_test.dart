// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/add_component_button.dart';

void main() {
  testWidgets('disables components already added to the clip', (tester) async {
    ClipComponent? addedComponent;
    final clip = TimelineClip(id: TimelineClipId.create(), startFrame: 0);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AddComponentButton(
            clip: clip,
            onAdd: (component) => addedComponent = component,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Add component'));
    await tester.pumpAndSettle();

    expect(find.text('Shape'), findsOneWidget);
    expect(find.text('Text'), findsOneWidget);
    expect(find.text('Transform'), findsOneWidget);
    expect(find.text('Already added'), findsOneWidget);

    final transformTile = tester.widget<ListTile>(
      find.ancestor(
        of: find.text('Transform'),
        matching: find.byType(ListTile),
      ),
    );
    expect(transformTile.enabled, isFalse);

    await tester.tap(find.text('Transform'));
    await tester.pumpAndSettle();

    expect(addedComponent, isNull);
    expect(find.text('Shape'), findsOneWidget);

    await tester.tap(find.text('Text'));
    await tester.pumpAndSettle();

    expect(addedComponent, isA<TextComponent>());
    expect(find.text('Shape'), findsNothing);
  });
}
