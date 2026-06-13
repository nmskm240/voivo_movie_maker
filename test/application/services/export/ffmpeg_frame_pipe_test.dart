import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:voivo_movie_maker/application/services/export/ffmpeg_frame_pipe.dart';

void main() {
  test('streams bytes through a local FIFO', () async {
    final temporaryDirectory = await Directory.systemTemp.createTemp(
      'voivo_pipe_test_',
    );
    final framePipe = await FfmpegFramePipe.create(
      temporaryDirectory: temporaryDirectory,
    );
    final receivedBytes = <int>[];
    final readDone = File(
      framePipe.path,
    ).openRead().listen(receivedBytes.addAll).asFuture<void>();

    await framePipe.write([1, 2, 3, 4]);
    await framePipe.dispose();
    await readDone;

    expect(receivedBytes, [1, 2, 3, 4]);
    await framePipe.dispose();
    expect(Directory(framePipe.path).parent.existsSync(), isFalse);
    await temporaryDirectory.delete();
  });
}
