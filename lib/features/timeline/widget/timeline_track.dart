import 'package:flutter/material.dart';
import 'package:voivo_movie_maker/application/dtos/timeline_track_info.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/features/assets/asset_timeline_drag_data.dart';
import 'package:voivo_movie_maker/features/timeline/widget/timeline_clip.dart';

class TimelineTrackView extends StatelessWidget {
  const TimelineTrackView({
    required this.track,
    required this.index,
    required this.trackCount,
    required this.trackListKey,
    required this.horizontalScrollController,
    required this.trackScrollController,
    required this.onAutoScroll,
    required this.onSeekFrame,
    required this.onSelectTrack,
    required this.onAcceptAsset,
    required this.selected,
    super.key,
  });

  final TimelineTrackInfo track;
  final int index;
  final int trackCount;
  final GlobalKey trackListKey;
  final ScrollController horizontalScrollController;
  final ScrollController trackScrollController;
  final void Function(Offset globalPosition, {bool horizontal, bool vertical})
  onAutoScroll;
  final ValueChanged<int> onSeekFrame;
  final VoidCallback onSelectTrack;
  final void Function(AssetTimelineDragData data, int frame) onAcceptAsset;
  final bool selected;

  static const height = 56.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: TimelineTrackView.height,
      child: Stack(
        children: [
          Positioned.fill(
            child: DragTarget<AssetTimelineDragData>(
              onWillAcceptWithDetails: (details) {
                return switch (details.data.asset.kind) {
                  ProjectAssetKind.image || ProjectAssetKind.audio => true,
                  ProjectAssetKind.video => false,
                };
              },
              onAcceptWithDetails: (details) {
                onSelectTrack();
                onAcceptAsset(
                  details.data,
                  _frameAtGlobalPosition(context, details.offset),
                );
              },
              builder: (context, candidateData, rejectedData) {
                final isDropTarget = candidateData.isNotEmpty;
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTapDown: (details) {
                    onSelectTrack();
                    onSeekFrame(details.localPosition.dx.floor());
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: isDropTarget
                          ? const Color(0xff23351f)
                          : selected
                          ? const Color(0xff1f2a33)
                          : index.isEven
                          ? const Color(0xff161b1f)
                          : const Color(0xff11161a),
                      border: Border(
                        left: BorderSide(
                          color: isDropTarget
                              ? const Color(0xff9ccc65)
                              : selected
                              ? const Color(0xff60a5fa)
                              : Colors.transparent,
                          width: 3,
                        ),
                        bottom: const BorderSide(color: Color(0xff2b3339)),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          for (final clip in track.clips)
            Positioned(
              top: 4,
              bottom: 4,
              left: clip.startFrame.toDouble(),
              width: clip.durationFrames.toDouble(),
              child: TimelineClipView(
                key: GlobalObjectKey(clip.id),
                trackIndex: index,
                trackCount: trackCount,
                trackListKey: trackListKey,
                horizontalScrollController: horizontalScrollController,
                trackScrollController: trackScrollController,
                trackHeight: TimelineTrackView.height,
                onAutoScroll: onAutoScroll,
                clip: clip,
              ),
            ),
        ],
      ),
    );
  }

  int _frameAtGlobalPosition(BuildContext context, Offset globalPosition) {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      return 0;
    }
    return renderBox.globalToLocal(globalPosition).dx.floor().clamp(0, 1 << 30);
  }
}
