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

@ProviderFor(CurrentTimeline)
final timelineProvider = CurrentTimelineProvider._();

final class CurrentTimelineProvider
    extends $AsyncNotifierProvider<CurrentTimeline, Timeline> {
  CurrentTimelineProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'timelineProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[projectProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          CurrentTimelineProvider.$allTransitiveDependencies0,
          CurrentTimelineProvider.$allTransitiveDependencies1,
        ],
      );

  static final $allTransitiveDependencies0 = projectProvider;
  static final $allTransitiveDependencies1 =
      ProjectProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$currentTimelineHash();

  @$internal
  @override
  CurrentTimeline create() => CurrentTimeline();
}

String _$currentTimelineHash() => r'83e16a6a72c57021e230cd775906112e51afed7d';

abstract class _$CurrentTimeline extends $AsyncNotifier<Timeline> {
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
