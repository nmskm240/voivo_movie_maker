// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/presentation/project_edit/widgets/voice_generation/voice_generation_progress_dialog.dart';

void main() {
  testWidgets('cannot be closed with the system back action', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () => showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (context) => const VoiceGenerationProgressDialog(),
            ),
            child: const Text('Open'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Creating voice'), findsOneWidget);
    await tester.binding.handlePopRoute();
    await tester.pump();
    expect(find.text('Creating voice'), findsOneWidget);

    await tester.tapAt(const Offset(5, 5));
    await tester.pump();
    expect(find.text('Creating voice'), findsOneWidget);
  });
}
