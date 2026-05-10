import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:voivo_movie_maker/application/providers/loaded_project_provider.dart';

part 'playback_controller_provider.freezed.dart';
part 'playback_controller_provider.g.dart';

@freezed
sealed class PlaybackInfo with _$PlaybackInfo {
  const factory PlaybackInfo.stopped({required int currentFrame}) =
      PlaybackStopped;

  const factory PlaybackInfo.playing({
    required int currentFrame,
    required int playStartFrame,
    required Duration playStartElapsed,
  }) = PlaybackPlaying;
}

@riverpod
class PlaybackController extends _$PlaybackController {
  @override
  PlaybackInfo build() {
    return const PlaybackInfo.stopped(currentFrame: 0);
  }

  void pause() {
    state = PlaybackInfo.stopped(currentFrame: state.currentFrame);
  }

  void play() {
    state = PlaybackInfo.playing(
      currentFrame: state.currentFrame,
      playStartFrame: state.currentFrame,
      playStartElapsed: Duration.zero,
    );
  }

  void seek(int frame) {
    state = PlaybackInfo.stopped(currentFrame: max(0, frame));
  }

  void onTick(Duration elapsed) {
    final current = state;
    if (current is! PlaybackPlaying) {
      return;
    }

    final fps = ref.read(loadedProjectProvider).project.fps;
    final delta = elapsed - current.playStartElapsed;
    final frame =
        current.playStartFrame + (delta.inMicroseconds / 1000000 * fps).floor();
    if (frame == current.currentFrame) {
      return;
    }

    state = current.copyWith(currentFrame: frame);
  }
}
