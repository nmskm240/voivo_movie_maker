// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(timelineInfo)
final timelineInfoProvider = TimelineInfoProvider._();

final class TimelineInfoProvider
    extends $FunctionalProvider<TimelineInfo, TimelineInfo, TimelineInfo>
    with $Provider<TimelineInfo> {
  TimelineInfoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'timelineInfoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$timelineInfoHash();

  @$internal
  @override
  $ProviderElement<TimelineInfo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TimelineInfo create(Ref ref) {
    return timelineInfo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TimelineInfo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TimelineInfo>(value),
    );
  }
}

String _$timelineInfoHash() => r'6d8b6c157ae2ad711dde130146ccbdab49b6fd21';
