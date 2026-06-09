import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:voivo_movie_maker/application/dtos/timeline_info.dart';
import 'package:voivo_movie_maker/application/providers.dart';

part 'view_model.freezed.dart';
part 'view_model.g.dart';

@freezed
sealed class TimelineViewState with _$TimelineViewState {
  const factory TimelineViewState({
    required TimelineInfo timeline,
    @Default(1.0) double pixelsPerFrame,
    @Default(0.0) double horizontalScrollOffset,
  }) = _TimelineViewState;
}

@Riverpod(dependencies: [CurrentTimeline])
class TimelineViewModel extends _$TimelineViewModel {
  static const minPixelsPerFrame = 0.25;
  static const maxPixelsPerFrame = 8.0;

  @override
  Future<TimelineViewState> build() async {
    final pixelsPerFrame = state.value?.pixelsPerFrame ?? 1.0;
    final horizontalScrollOffset = state.value?.horizontalScrollOffset ?? 0.0;
    final timeline = await ref.watch(timelineProvider.future);
    return TimelineViewState(
      timeline: TimelineInfo.fromEntity(timeline),
      pixelsPerFrame: pixelsPerFrame,
      horizontalScrollOffset: horizontalScrollOffset,
    );
  }

  void setPixelsPerFrame(double pixelsPerFrame) {
    final current = state.value;
    if (current == null) {
      return;
    }

    state = AsyncData(
      current.copyWith(
        pixelsPerFrame: pixelsPerFrame.clamp(
          minPixelsPerFrame,
          maxPixelsPerFrame,
        ),
      ),
    );
  }

  void setHorizontalScrollOffset(double offset) {
    final current = state.value;
    if (current == null || current.horizontalScrollOffset == offset) {
      return;
    }

    state = AsyncData(
      current.copyWith(
        horizontalScrollOffset: offset.clamp(0.0, double.infinity),
      ),
    );
  }
}
