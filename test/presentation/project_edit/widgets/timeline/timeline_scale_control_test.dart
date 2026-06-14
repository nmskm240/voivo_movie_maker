// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/timeline_scale_control.dart';

void main() {
  testWidgets('changes scale with buttons and slider', (tester) async {
    var value = 1.0;

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (context, setState) => SizedBox(
            width: 120,
            child: TimelineScaleControl(
              value: value,
              min: 0.25,
              max: 8,
              onChanged: (nextValue) => setState(() => value = nextValue),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(const ValueKey('timeline-scale-in')));
    await tester.pump();
    expect(value, 1.5);

    await tester.tap(find.byKey(const ValueKey('timeline-scale-out')));
    await tester.pump();
    expect(value, 1);

    await tester.drag(
      find.byKey(const ValueKey('timeline-scale-slider')),
      const Offset(100, 0),
    );
    await tester.pump();
    expect(value, greaterThan(1));
  });
}
