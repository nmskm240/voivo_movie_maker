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

@ProviderFor(projectImageCache)
final projectImageCacheProvider = ProjectImageCacheProvider._();

final class ProjectImageCacheProvider
    extends
        $FunctionalProvider<
          ProjectAssetCache<ui.Image>,
          ProjectAssetCache<ui.Image>,
          ProjectAssetCache<ui.Image>
        >
    with $Provider<ProjectAssetCache<ui.Image>> {
  ProjectImageCacheProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectImageCacheProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[projectAssetStoreProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          ProjectImageCacheProvider.$allTransitiveDependencies0,
        ],
      );

  static final $allTransitiveDependencies0 = projectAssetStoreProvider;

  @override
  String debugGetCreateSourceHash() => _$projectImageCacheHash();

  @$internal
  @override
  $ProviderElement<ProjectAssetCache<ui.Image>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProjectAssetCache<ui.Image> create(Ref ref) {
    return projectImageCache(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProjectAssetCache<ui.Image> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProjectAssetCache<ui.Image>>(value),
    );
  }
}

String _$projectImageCacheHash() => r'3e155db21fa5b4c173e19e24f55333bb1070d684';

@ProviderFor(projectImageCacheRevision)
final projectImageCacheRevisionProvider = ProjectImageCacheRevisionProvider._();

final class ProjectImageCacheRevisionProvider
    extends $FunctionalProvider<AsyncValue<int>, int, Stream<int>>
    with $FutureModifier<int>, $StreamProvider<int> {
  ProjectImageCacheRevisionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectImageCacheRevisionProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[projectImageCacheProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          ProjectImageCacheRevisionProvider.$allTransitiveDependencies0,
          ProjectImageCacheRevisionProvider.$allTransitiveDependencies1,
        ],
      );

  static final $allTransitiveDependencies0 = projectImageCacheProvider;
  static final $allTransitiveDependencies1 =
      ProjectImageCacheProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$projectImageCacheRevisionHash();

  @$internal
  @override
  $StreamProviderElement<int> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<int> create(Ref ref) {
    return projectImageCacheRevision(ref);
  }
}

String _$projectImageCacheRevisionHash() =>
    r'1935f80b8c7265e2f71dd5848b9ab871cbaecac3';

@ProviderFor(projectAudioCache)
final projectAudioCacheProvider = ProjectAudioCacheProvider._();

final class ProjectAudioCacheProvider
    extends
        $FunctionalProvider<
          ProjectAssetCache<Uint8List>,
          ProjectAssetCache<Uint8List>,
          ProjectAssetCache<Uint8List>
        >
    with $Provider<ProjectAssetCache<Uint8List>> {
  ProjectAudioCacheProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectAudioCacheProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[projectAssetStoreProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          ProjectAudioCacheProvider.$allTransitiveDependencies0,
        ],
      );

  static final $allTransitiveDependencies0 = projectAssetStoreProvider;

  @override
  String debugGetCreateSourceHash() => _$projectAudioCacheHash();

  @$internal
  @override
  $ProviderElement<ProjectAssetCache<Uint8List>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProjectAssetCache<Uint8List> create(Ref ref) {
    return projectAudioCache(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProjectAssetCache<Uint8List> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProjectAssetCache<Uint8List>>(value),
    );
  }
}

String _$projectAudioCacheHash() => r'1e9560e87614652372d1dda10a9d69cd10849928';

@ProviderFor(projectAudioCacheRevision)
final projectAudioCacheRevisionProvider = ProjectAudioCacheRevisionProvider._();

final class ProjectAudioCacheRevisionProvider
    extends $FunctionalProvider<AsyncValue<int>, int, Stream<int>>
    with $FutureModifier<int>, $StreamProvider<int> {
  ProjectAudioCacheRevisionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectAudioCacheRevisionProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[projectAudioCacheProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          ProjectAudioCacheRevisionProvider.$allTransitiveDependencies0,
          ProjectAudioCacheRevisionProvider.$allTransitiveDependencies1,
        ],
      );

  static final $allTransitiveDependencies0 = projectAudioCacheProvider;
  static final $allTransitiveDependencies1 =
      ProjectAudioCacheProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$projectAudioCacheRevisionHash();

  @$internal
  @override
  $StreamProviderElement<int> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<int> create(Ref ref) {
    return projectAudioCacheRevision(ref);
  }
}

String _$projectAudioCacheRevisionHash() =>
    r'9d01167172e12699e39aded2f4a877014f826bca';

@ProviderFor(projectVideoCache)
final projectVideoCacheProvider = ProjectVideoCacheProvider._();

final class ProjectVideoCacheProvider
    extends
        $FunctionalProvider<
          ProjectAssetCache<Uint8List>,
          ProjectAssetCache<Uint8List>,
          ProjectAssetCache<Uint8List>
        >
    with $Provider<ProjectAssetCache<Uint8List>> {
  ProjectVideoCacheProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectVideoCacheProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[projectAssetStoreProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          ProjectVideoCacheProvider.$allTransitiveDependencies0,
        ],
      );

  static final $allTransitiveDependencies0 = projectAssetStoreProvider;

  @override
  String debugGetCreateSourceHash() => _$projectVideoCacheHash();

  @$internal
  @override
  $ProviderElement<ProjectAssetCache<Uint8List>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProjectAssetCache<Uint8List> create(Ref ref) {
    return projectVideoCache(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProjectAssetCache<Uint8List> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProjectAssetCache<Uint8List>>(value),
    );
  }
}

String _$projectVideoCacheHash() => r'7bcec133da7944362eec70ca69301ff3cc0845a0';

@ProviderFor(projectVideoCacheRevision)
final projectVideoCacheRevisionProvider = ProjectVideoCacheRevisionProvider._();

final class ProjectVideoCacheRevisionProvider
    extends $FunctionalProvider<AsyncValue<int>, int, Stream<int>>
    with $FutureModifier<int>, $StreamProvider<int> {
  ProjectVideoCacheRevisionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectVideoCacheRevisionProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[projectVideoCacheProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          ProjectVideoCacheRevisionProvider.$allTransitiveDependencies0,
          ProjectVideoCacheRevisionProvider.$allTransitiveDependencies1,
        ],
      );

  static final $allTransitiveDependencies0 = projectVideoCacheProvider;
  static final $allTransitiveDependencies1 =
      ProjectVideoCacheProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$projectVideoCacheRevisionHash();

  @$internal
  @override
  $StreamProviderElement<int> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<int> create(Ref ref) {
    return projectVideoCacheRevision(ref);
  }
}

String _$projectVideoCacheRevisionHash() =>
    r'b75c30a5d98d59f5c47729543c81fc591bcda50a';

@ProviderFor(projectVideoFrameCache)
final projectVideoFrameCacheProvider = ProjectVideoFrameCacheProvider._();

final class ProjectVideoFrameCacheProvider
    extends
        $FunctionalProvider<
          ProjectVideoFrameCache,
          ProjectVideoFrameCache,
          ProjectVideoFrameCache
        >
    with $Provider<ProjectVideoFrameCache> {
  ProjectVideoFrameCacheProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectVideoFrameCacheProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[projectVideoCacheProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          ProjectVideoFrameCacheProvider.$allTransitiveDependencies0,
          ProjectVideoFrameCacheProvider.$allTransitiveDependencies1,
        ],
      );

  static final $allTransitiveDependencies0 = projectVideoCacheProvider;
  static final $allTransitiveDependencies1 =
      ProjectVideoCacheProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$projectVideoFrameCacheHash();

  @$internal
  @override
  $ProviderElement<ProjectVideoFrameCache> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProjectVideoFrameCache create(Ref ref) {
    return projectVideoFrameCache(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProjectVideoFrameCache value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProjectVideoFrameCache>(value),
    );
  }
}

String _$projectVideoFrameCacheHash() =>
    r'73e0dfc08b45c00210185870cb65b3865ada64ed';

@ProviderFor(projectVideoFrameCacheRevision)
final projectVideoFrameCacheRevisionProvider =
    ProjectVideoFrameCacheRevisionProvider._();

final class ProjectVideoFrameCacheRevisionProvider
    extends $FunctionalProvider<AsyncValue<int>, int, Stream<int>>
    with $FutureModifier<int>, $StreamProvider<int> {
  ProjectVideoFrameCacheRevisionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectVideoFrameCacheRevisionProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[projectVideoFrameCacheProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          ProjectVideoFrameCacheRevisionProvider.$allTransitiveDependencies0,
          ProjectVideoFrameCacheRevisionProvider.$allTransitiveDependencies1,
          ProjectVideoFrameCacheRevisionProvider.$allTransitiveDependencies2,
        ],
      );

  static final $allTransitiveDependencies0 = projectVideoFrameCacheProvider;
  static final $allTransitiveDependencies1 =
      ProjectVideoFrameCacheProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      ProjectVideoFrameCacheProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$projectVideoFrameCacheRevisionHash();

  @$internal
  @override
  $StreamProviderElement<int> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<int> create(Ref ref) {
    return projectVideoFrameCacheRevision(ref);
  }
}

String _$projectVideoFrameCacheRevisionHash() =>
    r'753c823a72c0c168d4f2ef5cb0748e464f8c9d72';

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
