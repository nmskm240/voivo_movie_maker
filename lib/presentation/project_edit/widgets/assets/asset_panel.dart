// Flutter imports:
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/application/usecases.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/timeline_drag_data.dart';

class AssetPanel extends ConsumerStatefulWidget {
  const AssetPanel({super.key});

  @override
  ConsumerState<AssetPanel> createState() => _AssetPanelState();
}

class _AssetPanelState extends ConsumerState<AssetPanel> {
  bool _importing = false;

  @override
  Widget build(BuildContext context) {
    final project = ref.watch(projectProvider);

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: project.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) =>
                    Center(child: Text(error.toString())),
                data: (project) {
                  final assets = project.assets.assets.toList();
                  if (assets.isEmpty) {
                    return const Center(child: Text('No assets imported'));
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.only(top: 8, bottom: 80),
                    itemCount: assets.length,
                    itemBuilder: (context, index) =>
                        _AssetListTile(asset: assets[index]),
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                  );
                },
              ),
            ),
          ],
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton.small(
            onPressed: _importing ? null : _importAsset,
            tooltip: 'Import asset',
            child: _importing
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Future<void> _importAsset() async {
    setState(() => _importing = true);
    try {
      final asset = await ref.read(importProjectAssetProvider.future);
      if (asset != null && mounted) {
        setState(() {});
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Import failed: $error')));
      }
    } finally {
      if (mounted) {
        setState(() => _importing = false);
      }
    }
  }
}

class _AssetListTile extends StatelessWidget {
  const _AssetListTile({required this.asset});

  final ProjectAsset asset;

  @override
  Widget build(BuildContext context) {
    final tile = ListTile(
      leading: Icon(_iconFor(asset.kind)),
      title: Text(asset.name, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(asset.kind.name),
    );
    if (asset.kind == ProjectAssetKind.video) {
      return tile;
    }

    return Draggable<TimelineDragData>(
      data: TimelineAssetDragData(asset),
      feedback: Material(
        elevation: 4,
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: 240,
          child: ListTile(
            leading: Icon(_iconFor(asset.kind)),
            title: Text(
              asset.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
      childWhenDragging: Opacity(opacity: 0.35, child: tile),
      child: MouseRegion(cursor: SystemMouseCursors.grab, child: tile),
    );
  }

  IconData _iconFor(ProjectAssetKind kind) {
    return switch (kind) {
      ProjectAssetKind.image => Icons.image_outlined,
      ProjectAssetKind.video => Icons.movie_outlined,
      ProjectAssetKind.audio => Icons.audio_file_outlined,
    };
  }
}
