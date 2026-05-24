// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loaded_project_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProjectPath)
final projectPathProvider = ProjectPathProvider._();

final class ProjectPathProvider
    extends $NotifierProvider<ProjectPath, Directory> {
  ProjectPathProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectPathProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$projectPathHash();

  @$internal
  @override
  ProjectPath create() => ProjectPath();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Directory value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Directory>(value),
    );
  }
}

String _$projectPathHash() => r'e9f017ad9673254121d5e2ceb564415316efdb53';

abstract class _$ProjectPath extends $Notifier<Directory> {
  Directory build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Directory, Directory>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Directory, Directory>,
              Directory,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(LoadedProject)
final loadedProjectProvider = LoadedProjectProvider._();

final class LoadedProjectProvider
    extends $AsyncNotifierProvider<LoadedProject, ProjectSnapshot> {
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
}

String _$loadedProjectHash() => r'a81031672f007bf62ea17aad92de008277231502';

abstract class _$LoadedProject extends $AsyncNotifier<ProjectSnapshot> {
  FutureOr<ProjectSnapshot> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ProjectSnapshot>, ProjectSnapshot>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ProjectSnapshot>, ProjectSnapshot>,
              AsyncValue<ProjectSnapshot>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
