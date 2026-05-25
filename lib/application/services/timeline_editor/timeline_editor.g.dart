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
        dependencies: null,
        $allTransitiveDependencies: null,
      );

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

String _$timelineEditorHash() => r'1fb9b87b60e53d28e2a32bd7e61861700bff8fa5';
