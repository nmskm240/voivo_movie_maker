import 'package:flutter/material.dart';

class EditorMenuBar extends StatelessWidget {
  const EditorMenuBar({
    super.key,
    required this.isPlaying,
    required this.onTogglePlay,
    required this.onExport,
    this.isExporting = false,
  });

  final bool isPlaying;
  final VoidCallback onTogglePlay;
  final VoidCallback onExport;
  final bool isExporting;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: const BoxDecoration(
        color: Color(0xff171b1e),
        border: Border(bottom: BorderSide(color: Color(0xff2b3136))),
      ),
      child: Row(
        children: [
          const Icon(Icons.video_settings_outlined, size: 22),
          const SizedBox(width: 10),
          const Text(
            'Voivo Movie Maker',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 20),
          const _MenuIconButton(
            icon: Icons.folder_open_outlined,
            tooltip: '素材を読み込む',
          ),
          const _MenuIconButton(icon: Icons.content_cut, tooltip: 'カット'),
          const _MenuIconButton(icon: Icons.title, tooltip: 'テキスト'),
          const _MenuIconButton(icon: Icons.graphic_eq, tooltip: '効果音'),
          const Spacer(),
          FilledButton.icon(
            onPressed: onTogglePlay,
            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
            label: Text(isPlaying ? '停止' : '再生'),
          ),
          const SizedBox(width: 8),
          OutlinedButton.icon(
            onPressed: isExporting ? null : onExport,
            icon: isExporting
                ? const SizedBox.square(
                    dimension: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.ios_share_outlined),
            label: Text(isExporting ? '書き出し中' : '書き出し'),
          ),
        ],
      ),
    );
  }
}

class _MenuIconButton extends StatelessWidget {
  const _MenuIconButton({required this.icon, required this.tooltip});

  final IconData icon;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: IconButton.filledTonal(
        onPressed: () {},
        tooltip: tooltip,
        icon: Icon(icon),
      ),
    );
  }
}
