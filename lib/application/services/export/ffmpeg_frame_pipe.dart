import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

typedef _MkfifoNative = Int32 Function(Pointer<Utf8>, Uint32);
typedef _Mkfifo = int Function(Pointer<Utf8>, int);

class FfmpegFramePipe {
  FfmpegFramePipe._(this.path, this._directory);

  final String path;
  final Directory _directory;
  IOSink? _sink;
  Future<void>? _disposeFuture;

  static Future<FfmpegFramePipe> create({Directory? temporaryDirectory}) async {
    final baseDirectory = temporaryDirectory ?? await getTemporaryDirectory();
    final directory = await baseDirectory.createTemp('voivo_export_');
    final pipePath = p.join(directory.path, 'frames.rgba');
    final nativePath = pipePath.toNativeUtf8();

    try {
      final libc = Platform.isAndroid
          ? DynamicLibrary.open('libc.so')
          : DynamicLibrary.process();
      final mkfifo = libc.lookupFunction<_MkfifoNative, _Mkfifo>('mkfifo');
      final result = mkfifo(nativePath, 384);
      if (result != 0) {
        throw FileSystemException(
          'Failed to create FFmpeg frame pipe',
          pipePath,
        );
      }
    } catch (_) {
      await directory.delete(recursive: true);
      rethrow;
    } finally {
      calloc.free(nativePath);
    }

    return FfmpegFramePipe._(pipePath, directory);
  }

  Future<void> write(List<int> bytes) async {
    if (_disposeFuture != null) {
      throw StateError('The FFmpeg frame pipe has already been disposed.');
    }
    final sink = _sink ??= File(path).openWrite();
    sink.add(bytes);
    await sink.flush();
  }

  Future<void> dispose() => _disposeFuture ??= _dispose();

  Future<void> _dispose() async {
    final sink = _sink;
    _sink = null;
    try {
      await sink?.close().timeout(
        const Duration(seconds: 2),
        onTimeout: () {
          throw StateError('Failed to close the FFmpeg frame pipe.');
        },
      );
    } finally {
      if (await _directory.exists()) {
        await _directory.delete(recursive: true);
      }
    }
  }
}
