import 'package:flutter_test/flutter_test.dart';
import 'package:voivo_movie_maker/data/mock_timeline.dart';
import 'package:voivo_movie_maker/services/export/ass_subtitle_builder.dart';
import 'package:voivo_movie_maker/services/export/ffmpeg_command_builder.dart';

void main() {
  test('builds ASS subtitles from text clips', () {
    final ass = const AssSubtitleBuilder().build(mockProject);

    expect(ass, contains('[Script Info]'));
    expect(ass, contains('PlayResX: 1920'));
    expect(ass, contains('Dialogue: 0,0:00:04.00,0:00:12.00'));
    expect(ass, contains('Voivo Movie Maker'));
    expect(ass, contains(r'\fad(600,0)'));
    expect(ass, contains(r'\fad(0,1000)'));
  });

  test('builds an ffmpeg command for text-only export', () {
    final command = const FfmpegCommandBuilder().buildTextOnlyExportCommand(
      project: mockProject,
      assPath: '/tmp/voivo/timeline.ass',
      outputPath: '/tmp/voivo/output.mp4',
    );

    expect(command, contains('-f lavfi'));
    expect(command, contains('color=c=0x20262B:s=1920x1080:r=30:d=40.000'));
    expect(command, contains("-vf 'ass=/tmp/voivo/timeline.ass'"));
    expect(command, contains('-c:v mpeg4'));
    expect(command, contains("'/tmp/voivo/output.mp4'"));
  });
}
