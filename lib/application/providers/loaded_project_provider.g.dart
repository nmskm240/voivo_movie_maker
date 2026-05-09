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
    extends $NotifierProvider<LoadedProject, Project> {
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
  Override overrideWithValue(Project value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Project>(value),
    );
  }
}

String _$loadedProjectHash() => r'335cf582577474a0092c783aa905340122616351';

abstract class _$LoadedProject extends $Notifier<Project> {
  Project build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Project, Project>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Project, Project>,
              Project,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
