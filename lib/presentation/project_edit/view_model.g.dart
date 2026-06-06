// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProjectEditViewModel)
final projectEditViewModelProvider = ProjectEditViewModelProvider._();

final class ProjectEditViewModelProvider
    extends $AsyncNotifierProvider<ProjectEditViewModel, ProjectEditState> {
  ProjectEditViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectEditViewModelProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[projectProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          ProjectEditViewModelProvider.$allTransitiveDependencies0,
          ProjectEditViewModelProvider.$allTransitiveDependencies1,
        ],
      );

  static final $allTransitiveDependencies0 = projectProvider;
  static final $allTransitiveDependencies1 =
      ProjectProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$projectEditViewModelHash();

  @$internal
  @override
  ProjectEditViewModel create() => ProjectEditViewModel();
}

String _$projectEditViewModelHash() =>
    r'650fe4132343ef3c55de9f2035ba795feeff7399';

abstract class _$ProjectEditViewModel extends $AsyncNotifier<ProjectEditState> {
  FutureOr<ProjectEditState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<ProjectEditState>, ProjectEditState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ProjectEditState>, ProjectEditState>,
              AsyncValue<ProjectEditState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
