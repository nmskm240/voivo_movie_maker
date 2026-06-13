import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voivo_movie_maker/application/services/export/export_operation.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/export/export_progress_dialog.dart';

void main() {
  testWidgets('shows progress and requests cancellation', (tester) async {
    final operation = ExportOperation();
    await tester.pumpWidget(
      MaterialApp(home: ExportProgressDialog(operation: operation)),
    );

    operation.reportProgress(0.42, completedFrames: 42, totalFrames: 100);
    await tester.pump();
    expect(find.text('42%'), findsOneWidget);
    expect(find.text('42 / 100 frames'), findsOneWidget);

    await tester.tap(find.text('Cancel'));
    await tester.pump();
    expect(operation.isCancelled, isTrue);
    expect(find.text('Cancelling...'), findsOneWidget);

    await operation.dispose();
  });

  testWidgets('shows the final save phase', (tester) async {
    final operation = ExportOperation();
    await tester.pumpWidget(
      MaterialApp(home: ExportProgressDialog(operation: operation)),
    );

    operation.reportSaving();
    await tester.pump();

    expect(find.text('Saving video...'), findsOneWidget);
    expect(
      tester.widget<TextButton>(find.byType(TextButton)).onPressed,
      isNull,
    );

    await operation.dispose();
  });
}
