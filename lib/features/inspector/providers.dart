import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
class SelectedTimelineClipId extends _$SelectedTimelineClipId {
  @override
  String? build() {
    return null;
  }

  void select(String clipId) {
    state = clipId;
  }

  void clear() {
    state = null;
  }
}
