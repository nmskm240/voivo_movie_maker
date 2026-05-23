import 'package:flutter/material.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';

class TimelineAddClipButton extends StatelessWidget {
  const TimelineAddClipButton({required this.onSelected, super.key});

  final ValueChanged<TimelineClipKind> onSelected;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final kind = await _showClipKindSheet(context);
        if (kind == null) {
          return;
        }
        onSelected(kind);
      },
      tooltip: 'Add clip',
      child: const Icon(Icons.add),
    );
  }

  Future<TimelineClipKind?> _showClipKindSheet(BuildContext context) {
    return showModalBottomSheet<TimelineClipKind>(
      context: context,
      builder: (context) {
        return const SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ClipKindTile(
                kind: TimelineClipKind.text,
                icon: Icons.text_fields,
                label: 'Text',
                enabled: true,
              ),
              _ClipKindTile(
                kind: TimelineClipKind.image,
                icon: Icons.image_outlined,
                label: 'Image',
                enabled: true,
              ),
              _ClipKindTile(
                kind: TimelineClipKind.audio,
                icon: Icons.graphic_eq,
                label: 'Audio',
                enabled: false,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ClipKindTile extends StatelessWidget {
  const _ClipKindTile({
    required this.kind,
    required this.icon,
    required this.label,
    required this.enabled,
  });

  final TimelineClipKind kind;
  final IconData icon;
  final String label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: enabled,
      leading: Icon(icon),
      title: Text(label),
      onTap: enabled ? () => Navigator.of(context).pop(kind) : null,
    );
  }
}
