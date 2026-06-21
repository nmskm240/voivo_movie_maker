// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_editor_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VoiceEditorViewModel)
final voiceEditorViewModelProvider = VoiceEditorViewModelProvider._();

final class VoiceEditorViewModelProvider
    extends $AsyncNotifierProvider<VoiceEditorViewModel, void> {
  VoiceEditorViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'voiceEditorViewModelProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[
          createVoiceAssetProvider,
          projectProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          VoiceEditorViewModelProvider.$allTransitiveDependencies0,
          VoiceEditorViewModelProvider.$allTransitiveDependencies1,
          VoiceEditorViewModelProvider.$allTransitiveDependencies2,
          VoiceEditorViewModelProvider.$allTransitiveDependencies3,
          VoiceEditorViewModelProvider.$allTransitiveDependencies4,
          VoiceEditorViewModelProvider.$allTransitiveDependencies5,
        },
      );

  static final $allTransitiveDependencies0 = createVoiceAssetProvider;
  static final $allTransitiveDependencies1 =
      CreateVoiceAssetProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      CreateVoiceAssetProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 =
      CreateVoiceAssetProvider.$allTransitiveDependencies2;
  static final $allTransitiveDependencies4 =
      CreateVoiceAssetProvider.$allTransitiveDependencies3;
  static final $allTransitiveDependencies5 =
      CreateVoiceAssetProvider.$allTransitiveDependencies4;

  @override
  String debugGetCreateSourceHash() => _$voiceEditorViewModelHash();

  @$internal
  @override
  VoiceEditorViewModel create() => VoiceEditorViewModel();
}

String _$voiceEditorViewModelHash() =>
    r'5a6194a8cbafab890924324b30aa8e0c25859a89';

abstract class _$VoiceEditorViewModel extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
