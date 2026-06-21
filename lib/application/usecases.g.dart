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

@ProviderFor(deleteProject)
final deleteProjectProvider = DeleteProjectFamily._();

final class DeleteProjectProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  DeleteProjectProvider._({
    required DeleteProjectFamily super.from,
    required ProjectId super.argument,
  }) : super(
         retry: null,
         name: r'deleteProjectProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$deleteProjectHash();

  @override
  String toString() {
    return r'deleteProjectProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    final argument = this.argument as ProjectId;
    return deleteProject(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteProjectProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$deleteProjectHash() => r'a84556780f6ca414fd6692d02ef704c46a3962d0';

final class DeleteProjectFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<void>, ProjectId> {
  DeleteProjectFamily._()
    : super(
        retry: null,
        name: r'deleteProjectProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DeleteProjectProvider call(ProjectId projectId) =>
      DeleteProjectProvider._(argument: projectId, from: this);

  @override
  String toString() => r'deleteProjectProvider';
}

@ProviderFor(renameProjectAsset)
final renameProjectAssetProvider = RenameProjectAssetFamily._();

final class RenameProjectAssetProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  RenameProjectAssetProvider._({
    required RenameProjectAssetFamily super.from,
    required ({AssetId assetId, String name}) super.argument,
  }) : super(
         retry: null,
         name: r'renameProjectAssetProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static final $allTransitiveDependencies0 = projectProvider;
  static final $allTransitiveDependencies1 =
      ProjectProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$renameProjectAssetHash();

  @override
  String toString() {
    return r'renameProjectAssetProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    final argument = this.argument as ({AssetId assetId, String name});
    return renameProjectAsset(
      ref,
      assetId: argument.assetId,
      name: argument.name,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is RenameProjectAssetProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$renameProjectAssetHash() =>
    r'dae73f6542e01b4b1b905deaf70e7bc91012112e';

final class RenameProjectAssetFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<void>,
          ({AssetId assetId, String name})
        > {
  RenameProjectAssetFamily._()
    : super(
        retry: null,
        name: r'renameProjectAssetProvider',
        dependencies: <ProviderOrFamily>[projectProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          RenameProjectAssetProvider.$allTransitiveDependencies0,
          RenameProjectAssetProvider.$allTransitiveDependencies1,
        ],
        isAutoDispose: true,
      );

  RenameProjectAssetProvider call({
    required AssetId assetId,
    required String name,
  }) => RenameProjectAssetProvider._(
    argument: (assetId: assetId, name: name),
    from: this,
  );

  @override
  String toString() => r'renameProjectAssetProvider';
}

@ProviderFor(importProjectAsset)
final importProjectAssetProvider = ImportProjectAssetProvider._();

final class ImportProjectAssetProvider
    extends
        $FunctionalProvider<
          AsyncValue<ProjectAsset?>,
          ProjectAsset?,
          FutureOr<ProjectAsset?>
        >
    with $FutureModifier<ProjectAsset?>, $FutureProvider<ProjectAsset?> {
  ImportProjectAssetProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'importProjectAssetProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[
          projectProvider,
          projectAssetImporterProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          ImportProjectAssetProvider.$allTransitiveDependencies0,
          ImportProjectAssetProvider.$allTransitiveDependencies1,
          ImportProjectAssetProvider.$allTransitiveDependencies2,
          ImportProjectAssetProvider.$allTransitiveDependencies3,
        },
      );

  static final $allTransitiveDependencies0 = projectProvider;
  static final $allTransitiveDependencies1 =
      ProjectProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 = projectAssetImporterProvider;
  static final $allTransitiveDependencies3 =
      ProjectAssetImporterProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$importProjectAssetHash();

  @$internal
  @override
  $FutureProviderElement<ProjectAsset?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ProjectAsset?> create(Ref ref) {
    return importProjectAsset(ref);
  }
}

String _$importProjectAssetHash() =>
    r'2eda3c695aea4493939db3c2eaf772a3a8283f06';

@ProviderFor(createVoiceAsset)
final createVoiceAssetProvider = CreateVoiceAssetFamily._();

final class CreateVoiceAssetProvider
    extends
        $FunctionalProvider<
          AsyncValue<ProjectAsset>,
          ProjectAsset,
          FutureOr<ProjectAsset>
        >
    with $FutureModifier<ProjectAsset>, $FutureProvider<ProjectAsset> {
  CreateVoiceAssetProvider._({
    required CreateVoiceAssetFamily super.from,
    required ({String dialogue, int speakerId, Directory? temporaryDirectory})
    super.argument,
  }) : super(
         retry: null,
         name: r'createVoiceAssetProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static final $allTransitiveDependencies0 = projectProvider;
  static final $allTransitiveDependencies1 =
      ProjectProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 = projectAssetImporterProvider;
  static final $allTransitiveDependencies3 =
      ProjectAssetImporterProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$createVoiceAssetHash();

  @override
  String toString() {
    return r'createVoiceAssetProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<ProjectAsset> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ProjectAsset> create(Ref ref) {
    final argument =
        this.argument
            as ({
              String dialogue,
              int speakerId,
              Directory? temporaryDirectory,
            });
    return createVoiceAsset(
      ref,
      dialogue: argument.dialogue,
      speakerId: argument.speakerId,
      temporaryDirectory: argument.temporaryDirectory,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CreateVoiceAssetProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$createVoiceAssetHash() => r'658fda49b2b2bb16c505abe3e61e7907c259d653';

final class CreateVoiceAssetFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<ProjectAsset>,
          ({String dialogue, int speakerId, Directory? temporaryDirectory})
        > {
  CreateVoiceAssetFamily._()
    : super(
        retry: null,
        name: r'createVoiceAssetProvider',
        dependencies: <ProviderOrFamily>[
          projectProvider,
          projectAssetImporterProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          CreateVoiceAssetProvider.$allTransitiveDependencies0,
          CreateVoiceAssetProvider.$allTransitiveDependencies1,
          CreateVoiceAssetProvider.$allTransitiveDependencies2,
          CreateVoiceAssetProvider.$allTransitiveDependencies3,
        },
        isAutoDispose: true,
      );

  CreateVoiceAssetProvider call({
    required String dialogue,
    required int speakerId,
    Directory? temporaryDirectory,
  }) => CreateVoiceAssetProvider._(
    argument: (
      dialogue: dialogue,
      speakerId: speakerId,
      temporaryDirectory: temporaryDirectory,
    ),
    from: this,
  );

  @override
  String toString() => r'createVoiceAssetProvider';
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
    r'be72fab301b6249cb65a874c221799bb6b507460';

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

@ProviderFor(addAudioClipToTimeline)
final addAudioClipToTimelineProvider = AddAudioClipToTimelineFamily._();

final class AddAudioClipToTimelineProvider
    extends
        $FunctionalProvider<
          AsyncValue<TimelineClip?>,
          TimelineClip?,
          FutureOr<TimelineClip?>
        >
    with $FutureModifier<TimelineClip?>, $FutureProvider<TimelineClip?> {
  AddAudioClipToTimelineProvider._({
    required AddAudioClipToTimelineFamily super.from,
    required ({int trackIndex, ProjectAsset asset, int startFrame})
    super.argument,
  }) : super(
         retry: null,
         name: r'addAudioClipToTimelineProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static final $allTransitiveDependencies0 = projectProvider;
  static final $allTransitiveDependencies1 =
      ProjectProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 = timelineEditorProvider;
  static final $allTransitiveDependencies3 =
      TimelineEditorProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$addAudioClipToTimelineHash();

  @override
  String toString() {
    return r'addAudioClipToTimelineProvider'
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
    return addAudioClipToTimeline(
      ref,
      trackIndex: argument.trackIndex,
      asset: argument.asset,
      startFrame: argument.startFrame,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AddAudioClipToTimelineProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$addAudioClipToTimelineHash() =>
    r'ea5e3f3c6e6784398dce5c7605e18af589e9d10e';

final class AddAudioClipToTimelineFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<TimelineClip?>,
          ({int trackIndex, ProjectAsset asset, int startFrame})
        > {
  AddAudioClipToTimelineFamily._()
    : super(
        retry: null,
        name: r'addAudioClipToTimelineProvider',
        dependencies: <ProviderOrFamily>[
          projectProvider,
          timelineEditorProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          AddAudioClipToTimelineProvider.$allTransitiveDependencies0,
          AddAudioClipToTimelineProvider.$allTransitiveDependencies1,
          AddAudioClipToTimelineProvider.$allTransitiveDependencies2,
          AddAudioClipToTimelineProvider.$allTransitiveDependencies3,
        },
        isAutoDispose: true,
      );

  AddAudioClipToTimelineProvider call({
    required int trackIndex,
    required ProjectAsset asset,
    required int startFrame,
  }) => AddAudioClipToTimelineProvider._(
    argument: (trackIndex: trackIndex, asset: asset, startFrame: startFrame),
    from: this,
  );

  @override
  String toString() => r'addAudioClipToTimelineProvider';
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

String _$exportProjectHash() => r'9d79f575eb4b2bd9d35bd958372e0f391f15a754';

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
