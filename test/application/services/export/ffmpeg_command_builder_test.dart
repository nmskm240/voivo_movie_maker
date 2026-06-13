import 'package:flutter_test/flutter_test.dart';
import 'package:voivo_movie_maker/application/services/export/ffmpeg_command_builder.dart';

void main() {
  test('builds a command from chained flags, options, input, and output', () {
    final command = FfmpegCommandBuilder()
        .addFlag('-y')
        .addOption('-f', 'rawvideo')
        .addOption('-video_size', '1280x720')
        .addInput('/tmp/input pipe')
        .addFlag('-an')
        .addOutput('/tmp/output.mp4')
        .build();

    expect(
      command,
      "-y -f 'rawvideo' -video_size '1280x720' "
      "-i '/tmp/input pipe' -an '/tmp/output.mp4'",
    );
  });

  test('escapes single quotes in argument values', () {
    final command = FfmpegCommandBuilder().addOutput("/tmp/user's.mp4").build();

    expect(command, r"'/tmp/user'\''s.mp4'");
  });
}
