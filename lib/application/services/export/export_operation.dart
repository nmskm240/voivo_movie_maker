import 'dart:async';

enum ExportPhase { rendering, saving, cancelling }

class ExportProgress {
  const ExportProgress({
    required this.fraction,
    this.completedFrames,
    this.totalFrames,
    this.phase = ExportPhase.rendering,
  });

  final double fraction;
  final int? completedFrames;
  final int? totalFrames;
  final ExportPhase phase;
}

class ExportCancelledException implements Exception {
  const ExportCancelledException();

  @override
  String toString() => 'Export was cancelled.';
}

class ExportOperation {
  final _started = Completer<void>();
  final _progress = StreamController<ExportProgress>.broadcast();

  ExportProgress _current = const ExportProgress(fraction: 0);
  void Function()? _cancelExport;
  var _isCancelled = false;

  Future<void> get started => _started.future;
  Stream<ExportProgress> get progress => _progress.stream;
  ExportProgress get currentProgress => _current;
  bool get isCancelled => _isCancelled;

  void markStarted() {
    if (!_started.isCompleted) {
      _started.complete();
    }
  }

  void reportProgress(
    double fraction, {
    int? completedFrames,
    int? totalFrames,
  }) {
    if (_isCancelled) {
      return;
    }
    _emit(
      ExportProgress(
        fraction: fraction.clamp(0, 1),
        completedFrames: completedFrames,
        totalFrames: totalFrames,
      ),
    );
  }

  void attachCancel(void Function() cancelExport) {
    _cancelExport = cancelExport;
    if (_isCancelled) {
      cancelExport();
    }
  }

  void reportSaving() {
    if (_isCancelled) {
      return;
    }
    _emit(
      ExportProgress(
        fraction: 1,
        completedFrames: _current.completedFrames,
        totalFrames: _current.totalFrames,
        phase: ExportPhase.saving,
      ),
    );
  }

  void detachCancel() {
    _cancelExport = null;
  }

  void cancel() {
    if (_isCancelled) {
      return;
    }
    _isCancelled = true;
    _emit(
      ExportProgress(
        fraction: _current.fraction,
        completedFrames: _current.completedFrames,
        totalFrames: _current.totalFrames,
        phase: ExportPhase.cancelling,
      ),
    );
    _cancelExport?.call();
  }

  void throwIfCancelled() {
    if (_isCancelled) {
      throw const ExportCancelledException();
    }
  }

  Future<void> dispose() => _progress.close();

  void _emit(ExportProgress progress) {
    _current = progress;
    if (!_progress.isClosed) {
      _progress.add(progress);
    }
  }
}
