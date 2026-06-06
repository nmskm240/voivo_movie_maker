// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playback_controller.dart';

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
        dependencies: <ProviderOrFamily>[projectProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          PlaybackControllerProvider.$allTransitiveDependencies0,
          PlaybackControllerProvider.$allTransitiveDependencies1,
        ],
      );

  static final $allTransitiveDependencies0 = projectProvider;
  static final $allTransitiveDependencies1 =
      ProjectProvider.$allTransitiveDependencies0;

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
    r'e35444011352609a53a32e428b63d471d02395f3';

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
