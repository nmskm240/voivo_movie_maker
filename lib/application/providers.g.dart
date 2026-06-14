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

@ProviderFor(projectsDirectory)
final projectsDirectoryProvider = ProjectsDirectoryProvider._();

final class ProjectsDirectoryProvider
    extends $FunctionalProvider<Directory, Directory, Directory>
    with $Provider<Directory> {
  ProjectsDirectoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectsDirectoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$projectsDirectoryHash();

  @$internal
  @override
  $ProviderElement<Directory> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Directory create(Ref ref) {
    return projectsDirectory(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Directory value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Directory>(value),
    );
  }
}

String _$projectsDirectoryHash() => r'c62c1de453aee4b20d3df4002efc796aa6b65325';

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
        dependencies: null,
        $allTransitiveDependencies: null,
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

String _$projectIdHash() => r'9f29a9a6a73014b5081dc18323f1ebe9134de9e3';

@ProviderFor(projectAssetStore)
final projectAssetStoreProvider = ProjectAssetStoreProvider._();

final class ProjectAssetStoreProvider
    extends
        $FunctionalProvider<
          IProjectAssetStore,
          IProjectAssetStore,
          IProjectAssetStore
        >
    with $Provider<IProjectAssetStore> {
  ProjectAssetStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectAssetStoreProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$projectAssetStoreHash();

  @$internal
  @override
  $ProviderElement<IProjectAssetStore> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IProjectAssetStore create(Ref ref) {
    return projectAssetStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IProjectAssetStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IProjectAssetStore>(value),
    );
  }
}

String _$projectAssetStoreHash() => r'f7ff01b07ea532f3f87390f97b1f6bc891027dce';

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
        isAutoDispose: true,
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

String _$projectHash() => r'4c03c5d06ae894c6e9cac1db985d3eb172da7373';

@ProviderFor(projectImageResources)
final projectImageResourcesProvider = ProjectImageResourcesProvider._();

final class ProjectImageResourcesProvider
    extends
        $FunctionalProvider<
          ProjectImageResources,
          ProjectImageResources,
          ProjectImageResources
        >
    with $Provider<ProjectImageResources> {
  ProjectImageResourcesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectImageResourcesProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[projectAssetStoreProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          ProjectImageResourcesProvider.$allTransitiveDependencies0,
        ],
      );

  static final $allTransitiveDependencies0 = projectAssetStoreProvider;

  @override
  String debugGetCreateSourceHash() => _$projectImageResourcesHash();

  @$internal
  @override
  $ProviderElement<ProjectImageResources> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProjectImageResources create(Ref ref) {
    return projectImageResources(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProjectImageResources value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProjectImageResources>(value),
    );
  }
}

String _$projectImageResourcesHash() =>
    r'1f7ba4cb1c43c50016b54a572dce3644027522b7';

@ProviderFor(projectImageResourcesRevision)
final projectImageResourcesRevisionProvider =
    ProjectImageResourcesRevisionProvider._();

final class ProjectImageResourcesRevisionProvider
    extends $FunctionalProvider<AsyncValue<int>, int, Stream<int>>
    with $FutureModifier<int>, $StreamProvider<int> {
  ProjectImageResourcesRevisionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectImageResourcesRevisionProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[projectImageResourcesProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          ProjectImageResourcesRevisionProvider.$allTransitiveDependencies0,
          ProjectImageResourcesRevisionProvider.$allTransitiveDependencies1,
        ],
      );

  static final $allTransitiveDependencies0 = projectImageResourcesProvider;
  static final $allTransitiveDependencies1 =
      ProjectImageResourcesProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$projectImageResourcesRevisionHash();

  @$internal
  @override
  $StreamProviderElement<int> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<int> create(Ref ref) {
    return projectImageResourcesRevision(ref);
  }
}

String _$projectImageResourcesRevisionHash() =>
    r'b0862a8db424ee67505e48a83d8cc1618a484556';

@ProviderFor(TimelineNotifier)
final timelineProvider = TimelineNotifierProvider._();

final class TimelineNotifierProvider
    extends $AsyncNotifierProvider<TimelineNotifier, Timeline> {
  TimelineNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'timelineProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[projectProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          TimelineNotifierProvider.$allTransitiveDependencies0,
          TimelineNotifierProvider.$allTransitiveDependencies1,
        ],
      );

  static final $allTransitiveDependencies0 = projectProvider;
  static final $allTransitiveDependencies1 =
      ProjectProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$timelineNotifierHash();

  @$internal
  @override
  TimelineNotifier create() => TimelineNotifier();
}

String _$timelineNotifierHash() => r'ec11f0a30c4da12ea774b4c701bb003d2df8e8fd';

abstract class _$TimelineNotifier extends $AsyncNotifier<Timeline> {
  FutureOr<Timeline> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Timeline>, Timeline>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Timeline>, Timeline>,
              AsyncValue<Timeline>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
