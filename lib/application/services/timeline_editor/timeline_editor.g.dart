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
        dependencies: <ProviderOrFamily>[projectRepositoryProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          TimelineEditorProvider.$allTransitiveDependencies0,
        ],
      );

  static final $allTransitiveDependencies0 = projectRepositoryProvider;

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

String _$timelineEditorHash() => r'b4c239c10228faababe31f8fdb8e51f221a38ec9';
