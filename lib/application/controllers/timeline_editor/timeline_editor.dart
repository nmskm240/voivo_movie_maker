import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:voivo_movie_maker/application/controllers/timeline_editor/asset_clip_selection.dart';
import 'package:voivo_movie_maker/application/controllers/timeline_editor/commands/add_clip_command.dart';
import 'package:voivo_movie_maker/application/controllers/timeline_editor/commands/timeline_editor_command.dart';
import 'package:voivo_movie_maker/application/providers/loaded_project_provider.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';

part 'timeline_editor.g.dart';

@riverpod
TimelineEditor timelineEditor(Ref ref) {
  final loadedProject = ref.watch(loadedProjectProvider).requireValue;
  final loadedProjectNotifier = ref.read(loadedProjectProvider.notifier);
  return TimelineEditor(
    loadedProject.project.timeline,
    loadedProjectNotifier.markChanged,
    loadedProjectNotifier.addAsset,
  );
}

class TimelineEditor {
  const TimelineEditor(this._timeline, this._markChanged, this._addAsset);

  final Timeline _timeline;
  final void Function({bool save}) _markChanged;
  final Future<void> Function(ProjectAsset asset, Stream<List<int>> bytes)
  _addAsset;

  Future<void> addClip({
    required int targetTrackIndex,
    required int startFrame,
    required TimelineClipKind kind,
    AssetClipSelection? assetSelection,
  }) async {
    if (assetSelection != null) {
      await _addAsset(assetSelection.asset, Stream.value(assetSelection.bytes));
    }

    execute(
      AddClipCommand(
        targetTrackIndex: targetTrackIndex,
        startFrame: startFrame,
        kind: kind,
        assetId: assetSelection?.asset.id,
        size: assetSelection?.size,
      ),
    );
  }

  void execute(TimelineEditorCommand command, {bool save = true}) {
    if (!command.canExecute(_timeline)) {
      return;
    }

    command.execute(_timeline);
    _markChanged(save: save);
  }
}
