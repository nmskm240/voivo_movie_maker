// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loaded_project_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LoadedProject)
final loadedProjectProvider = LoadedProjectProvider._();

final class LoadedProjectProvider
    extends $NotifierProvider<LoadedProject, ProjectSnapshot> {
  LoadedProjectProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loadedProjectProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loadedProjectHash();

  @$internal
  @override
  LoadedProject create() => LoadedProject();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProjectSnapshot value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProjectSnapshot>(value),
    );
  }
}

String _$loadedProjectHash() => r'5eeda637132b598457f9bcc9027ff9f0da6bed28';

abstract class _$LoadedProject extends $Notifier<ProjectSnapshot> {
  ProjectSnapshot build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ProjectSnapshot, ProjectSnapshot>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ProjectSnapshot, ProjectSnapshot>,
              ProjectSnapshot,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
