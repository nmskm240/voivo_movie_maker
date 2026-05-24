// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playback_controller_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PlaybackController)
final playbackControllerProvider = PlaybackControllerProvider._();

final class PlaybackControllerProvider
    extends $NotifierProvider<PlaybackController, PlaybackInfo> {
  PlaybackControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playbackControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playbackControllerHash();

  @$internal
  @override
  PlaybackController create() => PlaybackController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlaybackInfo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlaybackInfo>(value),
    );
  }
}

String _$playbackControllerHash() =>
    r'b86b35d814e760f1916415cd192e92df872eaefb';

abstract class _$PlaybackController extends $Notifier<PlaybackInfo> {
  PlaybackInfo build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PlaybackInfo, PlaybackInfo>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PlaybackInfo, PlaybackInfo>,
              PlaybackInfo,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
