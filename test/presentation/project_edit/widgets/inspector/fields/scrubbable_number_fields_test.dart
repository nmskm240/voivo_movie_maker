// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vector_math/vector_math.dart';

// Project imports:
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/fields/scrubbable_number_form_field.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/fields/scrubbable_number_region.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/fields/vector2_form_field.dart';

void main() {
  testWidgets('scrubs a number by dragging its field', (tester) async {
    double? value;
    await tester.pumpWidget(
      _form(
        ScrubbableNumberFormField(
          name: 'width',
          label: 'Width',
          initialValue: 100,
          onChanged: (next) => value = next,
        ),
      ),
    );

    await tester.drag(find.byType(TextField), const Offset(25, 0));
    await tester.pump();

    expect(value, 125);
  });

  testWidgets('clamps a scrubbed number to its minimum', (tester) async {
    double? value;
    await tester.pumpWidget(
      _form(
        ScrubbableNumberFormField(
          name: 'width',
          label: 'Width',
          initialValue: 10,
          min: 0.01,
          onChanged: (next) => value = next,
        ),
      ),
    );

    await tester.drag(find.byType(TextField), const Offset(-25, 0));
    await tester.pump();

    expect(value, 0.01);
  });

  testWidgets('rounds a scrubbed number to its step', (tester) async {
    double? value;
    await tester.pumpWidget(
      _form(
        ScrubbableNumberFormField(
          name: 'scale',
          label: 'Scale',
          initialValue: 0.1,
          stepPerPixel: 0.01,
          onChanged: (next) => value = next,
        ),
      ),
    );

    await tester.drag(find.byType(TextField), const Offset(25, 0));
    await tester.pump();

    expect(value, 0.35);
    expect(find.widgetWithText(TextField, '0.35'), findsOneWidget);
  });

  testWidgets('focuses a scrubbable number field on tap', (tester) async {
    await tester.pumpWidget(
      _form(
        ScrubbableNumberFormField(
          name: 'width',
          label: 'Width',
          initialValue: 100,
        ),
      ),
    );

    final field = tester.widget<TextField>(find.byType(TextField));
    await tester.tap(find.byType(TextField));
    await tester.pump();

    expect(field.focusNode?.hasFocus, isTrue);
  });

  testWidgets('does not scrub a number on a vertical drag', (tester) async {
    double? value;
    await tester.pumpWidget(
      _form(
        ScrubbableNumberFormField(
          name: 'width',
          label: 'Width',
          initialValue: 100,
          onChanged: (next) => value = next,
        ),
      ),
    );

    await tester.drag(find.byType(TextField), const Offset(5, 25));
    await tester.pump();

    expect(value, isNull);
  });

  testWidgets('scrubs one Vector2 axis by dragging its half', (tester) async {
    Vector2? value;
    await tester.pumpWidget(
      _form(
        Vector2FormField(
          name: 'position',
          initialValue: Vector2(10, 20),
          onChanged: (next) => value = next,
        ),
      ),
    );

    final regions = find.byType(ScrubbableNumberRegion);
    expect(regions, findsNWidgets(2));

    await tester.drag(regions.first, const Offset(15, 0));
    await tester.pump();

    expect(value?.x, 25);
    expect(value?.y, 20);
  });
}

Widget _form(Widget field) {
  return MaterialApp(
    home: Scaffold(
      body: FormBuilder(child: SizedBox(width: 400, child: field)),
    ),
  );
}
