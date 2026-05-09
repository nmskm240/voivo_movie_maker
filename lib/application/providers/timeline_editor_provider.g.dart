// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_editor_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TimelineEditor)
final timelineEditorProvider = TimelineEditorProvider._();

final class TimelineEditorProvider
    extends $NotifierProvider<TimelineEditor, TimelineInfo> {
  TimelineEditorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'timelineEditorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$timelineEditorHash();

  @$internal
  @override
  TimelineEditor create() => TimelineEditor();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TimelineInfo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TimelineInfo>(value),
    );
  }
}

String _$timelineEditorHash() => r'f2f9bd39634a1db3cf8e79806bd229bb786f9acc';

abstract class _$TimelineEditor extends $Notifier<TimelineInfo> {
  TimelineInfo build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<TimelineInfo, TimelineInfo>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TimelineInfo, TimelineInfo>,
              TimelineInfo,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
