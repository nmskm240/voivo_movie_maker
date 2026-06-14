// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usecases.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fetchProjectSummaries)
final fetchProjectSummariesProvider = FetchProjectSummariesProvider._();

final class FetchProjectSummariesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ProjectSummary>>,
          List<ProjectSummary>,
          FutureOr<List<ProjectSummary>>
        >
    with
        $FutureModifier<List<ProjectSummary>>,
        $FutureProvider<List<ProjectSummary>> {
  FetchProjectSummariesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchProjectSummariesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchProjectSummariesHash();

  @$internal
  @override
  $FutureProviderElement<List<ProjectSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ProjectSummary>> create(Ref ref) {
    return fetchProjectSummaries(ref);
  }
}

String _$fetchProjectSummariesHash() =>
    r'716325f6797e417231032a89239c4ef0633a133c';

@ProviderFor(createProject)
final createProjectProvider = CreateProjectFamily._();

final class CreateProjectProvider
    extends
        $FunctionalProvider<
          AsyncValue<ProjectId>,
          ProjectId,
          FutureOr<ProjectId>
        >
    with $FutureModifier<ProjectId>, $FutureProvider<ProjectId> {
  CreateProjectProvider._({
    required CreateProjectFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'createProjectProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$createProjectHash();

  @override
  String toString() {
    return r'createProjectProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ProjectId> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<ProjectId> create(Ref ref) {
    final argument = this.argument as String;
    return createProject(ref, name: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateProjectProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$createProjectHash() => r'606804cb597badfa93678c0531f0b7171be79050';

final class CreateProjectFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ProjectId>, String> {
  CreateProjectFamily._()
    : super(
        retry: null,
        name: r'createProjectProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CreateProjectProvider call({String name = 'untitled'}) =>
      CreateProjectProvider._(argument: name, from: this);

  @override
  String toString() => r'createProjectProvider';
}

@ProviderFor(importProjectAsset)
final importProjectAssetProvider = ImportProjectAssetFamily._();

final class ImportProjectAssetProvider
    extends
        $FunctionalProvider<
          AsyncValue<ProjectAsset>,
          ProjectAsset,
          FutureOr<ProjectAsset>
        >
    with $FutureModifier<ProjectAsset>, $FutureProvider<ProjectAsset> {
  ImportProjectAssetProvider._({
    required ImportProjectAssetFamily super.from,
    required File super.argument,
  }) : super(
         retry: null,
         name: r'importProjectAssetProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static final $allTransitiveDependencies0 = projectProvider;
  static final $allTransitiveDependencies1 =
      ProjectProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 = projectAssetStoreProvider;

  @override
  String debugGetCreateSourceHash() => _$importProjectAssetHash();

  @override
  String toString() {
    return r'importProjectAssetProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ProjectAsset> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ProjectAsset> create(Ref ref) {
    final argument = this.argument as File;
    return importProjectAsset(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ImportProjectAssetProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$importProjectAssetHash() =>
    r'9111c1cfd3c0276de21a95609ccecec64aee06c0';

final class ImportProjectAssetFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ProjectAsset>, File> {
  ImportProjectAssetFamily._()
    : super(
        retry: null,
        name: r'importProjectAssetProvider',
        dependencies: <ProviderOrFamily>[
          projectProvider,
          projectAssetStoreProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>[
          ImportProjectAssetProvider.$allTransitiveDependencies0,
          ImportProjectAssetProvider.$allTransitiveDependencies1,
          ImportProjectAssetProvider.$allTransitiveDependencies2,
        ],
        isAutoDispose: true,
      );

  ImportProjectAssetProvider call(File file) =>
      ImportProjectAssetProvider._(argument: file, from: this);

  @override
  String toString() => r'importProjectAssetProvider';
}

@ProviderFor(addImageClipToTimeline)
final addImageClipToTimelineProvider = AddImageClipToTimelineFamily._();

final class AddImageClipToTimelineProvider
    extends
        $FunctionalProvider<
          AsyncValue<TimelineClip?>,
          TimelineClip?,
          FutureOr<TimelineClip?>
        >
    with $FutureModifier<TimelineClip?>, $FutureProvider<TimelineClip?> {
  AddImageClipToTimelineProvider._({
    required AddImageClipToTimelineFamily super.from,
    required ({int trackIndex, ProjectAsset asset, int startFrame})
    super.argument,
  }) : super(
         retry: null,
         name: r'addImageClipToTimelineProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static final $allTransitiveDependencies0 = projectProvider;
  static final $allTransitiveDependencies1 =
      ProjectProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 = projectImageResourcesProvider;
  static final $allTransitiveDependencies3 =
      ProjectImageResourcesProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies4 = timelineEditorProvider;
  static final $allTransitiveDependencies5 =
      TimelineEditorProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$addImageClipToTimelineHash();

  @override
  String toString() {
    return r'addImageClipToTimelineProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<TimelineClip?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TimelineClip?> create(Ref ref) {
    final argument =
        this.argument as ({int trackIndex, ProjectAsset asset, int startFrame});
    return addImageClipToTimeline(
      ref,
      trackIndex: argument.trackIndex,
      asset: argument.asset,
      startFrame: argument.startFrame,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AddImageClipToTimelineProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$addImageClipToTimelineHash() =>
    r'ea9d713b1a56f0f5c30eec98600798f19d518af5';

final class AddImageClipToTimelineFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<TimelineClip?>,
          ({int trackIndex, ProjectAsset asset, int startFrame})
        > {
  AddImageClipToTimelineFamily._()
    : super(
        retry: null,
        name: r'addImageClipToTimelineProvider',
        dependencies: <ProviderOrFamily>[
          projectProvider,
          projectImageResourcesProvider,
          timelineEditorProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          AddImageClipToTimelineProvider.$allTransitiveDependencies0,
          AddImageClipToTimelineProvider.$allTransitiveDependencies1,
          AddImageClipToTimelineProvider.$allTransitiveDependencies2,
          AddImageClipToTimelineProvider.$allTransitiveDependencies3,
          AddImageClipToTimelineProvider.$allTransitiveDependencies4,
          AddImageClipToTimelineProvider.$allTransitiveDependencies5,
        },
        isAutoDispose: true,
      );

  AddImageClipToTimelineProvider call({
    required int trackIndex,
    required ProjectAsset asset,
    required int startFrame,
  }) => AddImageClipToTimelineProvider._(
    argument: (trackIndex: trackIndex, asset: asset, startFrame: startFrame),
    from: this,
  );

  @override
  String toString() => r'addImageClipToTimelineProvider';
}

@ProviderFor(exportProject)
final exportProjectProvider = ExportProjectFamily._();

final class ExportProjectProvider
    extends
        $FunctionalProvider<
          AsyncValue<ExportResult?>,
          ExportResult?,
          FutureOr<ExportResult?>
        >
    with $FutureModifier<ExportResult?>, $FutureProvider<ExportResult?> {
  ExportProjectProvider._({
    required ExportProjectFamily super.from,
    required ExportOperation super.argument,
  }) : super(
         retry: null,
         name: r'exportProjectProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static final $allTransitiveDependencies0 = projectProvider;
  static final $allTransitiveDependencies1 =
      ProjectProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 = projectImageResourcesProvider;
  static final $allTransitiveDependencies3 =
      ProjectImageResourcesProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$exportProjectHash();

  @override
  String toString() {
    return r'exportProjectProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ExportResult?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ExportResult?> create(Ref ref) {
    final argument = this.argument as ExportOperation;
    return exportProject(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ExportProjectProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$exportProjectHash() => r'92715a7492f2bed6167d783462059518d1148eec';

final class ExportProjectFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ExportResult?>, ExportOperation> {
  ExportProjectFamily._()
    : super(
        retry: null,
        name: r'exportProjectProvider',
        dependencies: <ProviderOrFamily>[
          projectProvider,
          projectImageResourcesProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          ExportProjectProvider.$allTransitiveDependencies0,
          ExportProjectProvider.$allTransitiveDependencies1,
          ExportProjectProvider.$allTransitiveDependencies2,
          ExportProjectProvider.$allTransitiveDependencies3,
        },
        isAutoDispose: true,
      );

  ExportProjectProvider call(ExportOperation operation) =>
      ExportProjectProvider._(argument: operation, from: this);

  @override
  String toString() => r'exportProjectProvider';
}
