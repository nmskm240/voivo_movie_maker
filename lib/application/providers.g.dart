// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(projectRepository)
final projectRepositoryProvider = ProjectRepositoryProvider._();

final class ProjectRepositoryProvider
    extends
        $FunctionalProvider<
          IProjectRepository,
          IProjectRepository,
          IProjectRepository
        >
    with $Provider<IProjectRepository> {
  ProjectRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$projectRepositoryHash();

  @$internal
  @override
  $ProviderElement<IProjectRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IProjectRepository create(Ref ref) {
    return projectRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IProjectRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IProjectRepository>(value),
    );
  }
}

String _$projectRepositoryHash() => r'fa8ddbe822e9624b386ba95dffd0e43b14a82b88';

@ProviderFor(projectId)
final projectIdProvider = ProjectIdProvider._();

final class ProjectIdProvider
    extends $FunctionalProvider<ProjectId, ProjectId, ProjectId>
    with $Provider<ProjectId> {
  ProjectIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectIdProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[],
        $allTransitiveDependencies: <ProviderOrFamily>[],
      );

  @override
  String debugGetCreateSourceHash() => _$projectIdHash();

  @$internal
  @override
  $ProviderElement<ProjectId> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ProjectId create(Ref ref) {
    return projectId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProjectId value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProjectId>(value),
    );
  }
}

String _$projectIdHash() => r'9f4eb295916ca91bfa3d16635dc117ab4c7a2006';

@ProviderFor(project)
final projectProvider = ProjectProvider._();

final class ProjectProvider
    extends $FunctionalProvider<AsyncValue<Project>, Project, FutureOr<Project>>
    with $FutureModifier<Project>, $FutureProvider<Project> {
  ProjectProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[projectIdProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          ProjectProvider.$allTransitiveDependencies0,
        ],
      );

  static final $allTransitiveDependencies0 = projectIdProvider;

  @override
  String debugGetCreateSourceHash() => _$projectHash();

  @$internal
  @override
  $FutureProviderElement<Project> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Project> create(Ref ref) {
    return project(ref);
  }
}

String _$projectHash() => r'6d3bb0939e690632abc6ae8913985321882ce061';
