// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedTimelineClipId)
final selectedTimelineClipIdProvider = SelectedTimelineClipIdProvider._();

final class SelectedTimelineClipIdProvider
    extends $NotifierProvider<SelectedTimelineClipId, String?> {
  SelectedTimelineClipIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedTimelineClipIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedTimelineClipIdHash();

  @$internal
  @override
  SelectedTimelineClipId create() => SelectedTimelineClipId();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedTimelineClipIdHash() =>
    r'6f543e8578bf46b364f7a8741f2b8a2a6827c2f5';

abstract class _$SelectedTimelineClipId extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
