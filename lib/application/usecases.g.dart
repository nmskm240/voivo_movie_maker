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

String _$exportProjectHash() => r'2991fb3ed95f3ae0671649c76f412bf62f67bc8d';

final class ExportProjectFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ExportResult?>, ExportOperation> {
  ExportProjectFamily._()
    : super(
        retry: null,
        name: r'exportProjectProvider',
        dependencies: <ProviderOrFamily>[projectProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          ExportProjectProvider.$allTransitiveDependencies0,
          ExportProjectProvider.$allTransitiveDependencies1,
        ],
        isAutoDispose: true,
      );

  ExportProjectProvider call(ExportOperation operation) =>
      ExportProjectProvider._(argument: operation, from: this);

  @override
  String toString() => r'exportProjectProvider';
}
