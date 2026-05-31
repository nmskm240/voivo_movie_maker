import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voivo_movie_maker/application/providers/loaded_project_provider.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/presentation/widgets/assets/asset_timeline_drag_data.dart';

class AssetListPane extends ConsumerStatefulWidget {
  const AssetListPane({super.key});

  @override
  ConsumerState<AssetListPane> createState() => _AssetListPaneState();
}

class _AssetListPaneState extends ConsumerState<AssetListPane> {
  final _chipScrollController = ScrollController();
  ProjectAssetKind? _selectedKind;

  @override
  void dispose() {
    _chipScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projectSnapshot = ref.watch(loadedProjectProvider);

    return projectSnapshot.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      data: (snapshot) {
        final assets = snapshot.project.assets;
        final filteredAssets = assets.assets;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Assets',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    filteredAssets.length.toString(),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 48,
              child: Scrollbar(
                controller: _chipScrollController,
                thumbVisibility: true,
                child: ListView(
                  controller: _chipScrollController,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  children: [
                    ChoiceChip(
                      label: const Text('All'),
                      selected: _selectedKind == null,
                      onSelected: (_) => setState(() => _selectedKind = null),
                    ),
                    const SizedBox(width: 8),
                    for (final kind in ProjectAssetKind.values) ...[
                      ChoiceChip(
                        label: Text(_labelFor(kind)),
                        selected: _selectedKind == kind,
                        onSelected: (_) => setState(() => _selectedKind = kind),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Expanded(
            //   child: filteredAssets.isEmpty
            //       ? const Center(child: Text('No assets'))
            //       : ListView.separated(
            //           padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
            //           itemCount: filteredAssets.length,
            //           separatorBuilder: (context, index) =>
            //               const SizedBox(height: 4),
            //           itemBuilder: (context, index) {
            //             return _AssetListTile(
            //               asset: filteredAssets.elementAt(index),
            //               storage: snapshot.project.assetStorage,
            //             );
            //           },
            //         ),
            // ),
          ],
        );
      },
    );
  }

  String _labelFor(ProjectAssetKind kind) {
    return switch (kind) {
      ProjectAssetKind.image => 'Image',
      ProjectAssetKind.video => 'Video',
      ProjectAssetKind.audio => 'Audio',
    };
  }
}

class _AssetListTile extends StatelessWidget {
  const _AssetListTile({required this.asset, required this.storage});

  final ProjectAsset asset;
  final ProjectAssetStorage storage;

  @override
  Widget build(BuildContext context) {
    return Draggable<AssetTimelineDragData>(
      data: AssetTimelineDragData(asset: asset, storage: storage),
      feedback: _AssetDragFeedback(asset: asset),
      childWhenDragging: Opacity(
        opacity: 0.45,
        child: _AssetListTileContent(asset: asset, storage: storage),
      ),
      child: _AssetListTileContent(asset: asset, storage: storage),
    );
  }
}

class _AssetListTileContent extends StatelessWidget {
  const _AssetListTileContent({required this.asset, required this.storage});

  final ProjectAsset asset;
  final ProjectAssetStorage storage;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: _AssetThumbnail(asset: asset, storage: storage),
      title: Text(asset.name, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        asset.id.value,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}

class _AssetDragFeedback extends StatelessWidget {
  const _AssetDragFeedback({required this.asset});

  final ProjectAsset asset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xff78c257),
          borderRadius: BorderRadius.circular(6),
          boxShadow: const [
            BoxShadow(
              color: Color(0x66000000),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: SizedBox(
          width: 180,
          height: 40,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Icon(
                  _iconFor(asset.kind),
                  color: const Color(0xff10210c),
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    asset.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: const Color(0xff10210c),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _iconFor(ProjectAssetKind kind) {
    return switch (kind) {
      ProjectAssetKind.image => Icons.image_outlined,
      ProjectAssetKind.video => Icons.movie_outlined,
      ProjectAssetKind.audio => Icons.graphic_eq,
    };
  }
}

class _AssetThumbnail extends StatelessWidget {
  const _AssetThumbnail({required this.asset, required this.storage});

  final ProjectAsset asset;
  final ProjectAssetStorage storage;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 40,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xff111827),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xff374151)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Icon(_iconFor(asset.kind), size: 20),
        ),
      ),
    );
  }

  IconData _iconFor(ProjectAssetKind kind) {
    return switch (kind) {
      ProjectAssetKind.image => Icons.image_outlined,
      ProjectAssetKind.video => Icons.movie_outlined,
      ProjectAssetKind.audio => Icons.graphic_eq,
    };
  }
}

// class _ImageAssetThumbnail extends StatelessWidget {
//   const _ImageAssetThumbnail({required this.asset, required this.storage});

//   final ProjectAsset asset;
//   final ProjectAssetStorage storage;

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Uint8List>(
//       future: storage
//           .getBytes(asset)
//           .fold<List<int>>(<int>[], (bytes, chunk) => bytes..addAll(chunk))
//           .then(Uint8List.fromList),
//       builder: (context, snapshot) {
//         final bytes = snapshot.data;
//         if (bytes == null) {
//           return const Center(
//             child: SizedBox.square(
//               dimension: 16,
//               child: CircularProgressIndicator(strokeWidth: 2),
//             ),
//           );
//         }

//         return Image.memory(
//           bytes,
//           fit: BoxFit.cover,
//           errorBuilder: (context, error, stackTrace) {
//             return const Icon(Icons.broken_image_outlined, size: 20);
//           },
//         );
//       },
//     );
//   }
// }
