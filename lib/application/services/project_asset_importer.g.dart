// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_asset_importer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(projectAssetImporter)
final projectAssetImporterProvider = ProjectAssetImporterProvider._();

final class ProjectAssetImporterProvider
    extends
        $FunctionalProvider<
          ProjectAssetImporter,
          ProjectAssetImporter,
          ProjectAssetImporter
        >
    with $Provider<ProjectAssetImporter> {
  ProjectAssetImporterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectAssetImporterProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[projectAssetStoreProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          ProjectAssetImporterProvider.$allTransitiveDependencies0,
        ],
      );

  static final $allTransitiveDependencies0 = projectAssetStoreProvider;

  @override
  String debugGetCreateSourceHash() => _$projectAssetImporterHash();

  @$internal
  @override
  $ProviderElement<ProjectAssetImporter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProjectAssetImporter create(Ref ref) {
    return projectAssetImporter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProjectAssetImporter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProjectAssetImporter>(value),
    );
  }
}

String _$projectAssetImporterHash() =>
    r'82abb07808e18372895e422d0d88a1b73dd6de58';
