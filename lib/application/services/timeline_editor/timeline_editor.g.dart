// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_editor.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(timelineEditor)
final timelineEditorProvider = TimelineEditorProvider._();

final class TimelineEditorProvider
    extends $FunctionalProvider<TimelineEditor, TimelineEditor, TimelineEditor>
    with $Provider<TimelineEditor> {
  TimelineEditorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'timelineEditorProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[timelineProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          TimelineEditorProvider.$allTransitiveDependencies0,
          TimelineEditorProvider.$allTransitiveDependencies1,
          TimelineEditorProvider.$allTransitiveDependencies2,
        ],
      );

  static final $allTransitiveDependencies0 = timelineProvider;
  static final $allTransitiveDependencies1 =
      CurrentTimelineProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      CurrentTimelineProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$timelineEditorHash();

  @$internal
  @override
  $ProviderElement<TimelineEditor> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TimelineEditor create(Ref ref) {
    return timelineEditor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TimelineEditor value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TimelineEditor>(value),
    );
  }
}

String _$timelineEditorHash() => r'1a52b111a27311d4576d81eb8da4c00055162031';
