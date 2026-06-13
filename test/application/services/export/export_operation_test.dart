// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/application/services/export/export_operation.dart';

void main() {
  test('reports progress and cancels the attached export once', () async {
    final operation = ExportOperation();
    final progress = <ExportProgress>[];
    final subscription = operation.progress.listen(progress.add);
    var cancelCount = 0;
    operation.attachCancel(() => cancelCount++);

    operation.markStarted();
    operation.reportProgress(0.4);
    operation.cancel();
    operation.cancel();
    await Future<void>.delayed(Duration.zero);

    await expectLater(operation.started, completes);
    expect(progress.first.fraction, 0.4);
    expect(progress.last.phase, ExportPhase.cancelling);
    expect(cancelCount, 1);
    expect(
      operation.throwIfCancelled,
      throwsA(isA<ExportCancelledException>()),
    );

    await subscription.cancel();
    await operation.dispose();
  });

  test('cancels an export attached after cancellation', () async {
    final operation = ExportOperation();
    var cancelled = false;

    operation.cancel();
    operation.attachCancel(() => cancelled = true);

    expect(cancelled, isTrue);
    await operation.dispose();
  });

  test('reports the final save phase', () async {
    final operation = ExportOperation();

    operation.reportProgress(1, completedFrames: 90, totalFrames: 90);
    operation.reportSaving();

    expect(operation.currentProgress.fraction, 1);
    expect(operation.currentProgress.phase, ExportPhase.saving);
    expect(operation.currentProgress.completedFrames, 90);
    await operation.dispose();
  });
}
