import 'dart:math';

import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:voivo_movie_maker/application/providers.dart';

part 'playback_controller.freezed.dart';
part 'playback_controller.g.dart';

@freezed
abstract class PlaybackInfo with _$PlaybackInfo {
  const PlaybackInfo._();

  const factory PlaybackInfo({
    required int fps,
    @Default(0) int currentFrame,
    @Default(0) int playStartFrame,
    @Default(Duration.zero) Duration playStartElapsed,
    @Default(false) bool isPlaying,
  }) = _PlaybackInfo;

  PlaybackInfo play() {
    return copyWith(
      isPlaying: true,
      playStartFrame: currentFrame,
      playStartElapsed: Duration.zero,
    );
  }

  PlaybackInfo pause() {
    return copyWith(isPlaying: false, playStartElapsed: Duration.zero);
  }

  PlaybackInfo seek(int frame) {
    return copyWith(currentFrame: max(0, frame), isPlaying: false);
  }

  PlaybackInfo tick(Duration elapsed) {
    if (!isPlaying) {
      return this;
    }

    final delta = elapsed - playStartElapsed;
    final frame =
        playStartFrame + (delta.inMicroseconds / 1000000 * fps).floor();
    if (frame == currentFrame) {
      return this;
    }

    return copyWith(currentFrame: frame);
  }
}

@Riverpod(dependencies: [project])
class PlaybackController extends _$PlaybackController {
  late final Ticker _ticker;
  var _tickerInitialized = false;

  int get currentFrame => state.currentFrame;

  @override
  PlaybackInfo build() {
    final fps = ref.watch(
      projectProvider.select((project) => project.value?.fps ?? 0),
    );
    if (!_tickerInitialized) {
      _ticker = Ticker(_onTick);
      _tickerInitialized = true;
      ref.onDispose(_ticker.dispose);
    }

    return PlaybackInfo(fps: fps);
  }

  void pause() {
    _ticker.stop();
    state = state.pause();
  }

  void play() {
    _ticker
      ..stop()
      ..start();

    state = state.play();
  }

  void seek(int frame) {
    _ticker.stop();
    state = state.seek(frame);
  }

  void _onTick(Duration elapsed) {
    state = state.tick(elapsed);
  }
}
