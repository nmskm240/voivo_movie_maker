import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voivo_movie_maker/application/providers/loaded_project_provider.dart';
import 'package:voivo_movie_maker/domain/timeline_clip.dart';
import 'package:voivo_movie_maker/domain/timeline_clip_contents.dart';
import 'package:voivo_movie_maker/features/inspector/providers.dart';
import 'package:voivo_movie_maker/features/timeline/controllers/timeline_editor.dart';

class ClipInspectorPane extends ConsumerWidget {
  const ClipInspectorPane({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedClipId = ref.watch(selectedTimelineClipIdProvider);
    final project = ref.watch(loadedProjectProvider).project;
    final clip = selectedClipId == null
        ? null
        : _findClip(
            project.timeline.tracks.expand((track) => track.clips),
            selectedClipId,
          );

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Color(0xff202124),
        border: Border(left: BorderSide(color: Color(0xff34363a))),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: clip == null
            ? const _EmptyInspector()
            : _SelectedClipInspector(clip: clip),
      ),
    );
  }

  TimelineClip? _findClip(Iterable<TimelineClip> clips, String clipId) {
    for (final clip in clips) {
      if (clip.id == clipId) {
        return clip;
      }
    }
    return null;
  }
}

class _EmptyInspector extends StatelessWidget {
  const _EmptyInspector();

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topLeft,
      child: Text(
        'No clip selected',
        style: TextStyle(color: Color(0xff9ca3af), fontSize: 13),
      ),
    );
  }
}

class _SelectedClipInspector extends StatelessWidget {
  const _SelectedClipInspector({required this.clip});

  final TimelineClip clip;

  @override
  Widget build(BuildContext context) {
    final content = clip.content;

    return ListView(
      children: [
        Text(
          clip.id,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        _ReadOnlyField(label: 'Start', value: clip.startFrame.toString()),
        const SizedBox(height: 10),
        _ReadOnlyField(
          label: 'Duration',
          value: clip.durationFrames.toString(),
        ),
        const SizedBox(height: 18),
        switch (content) {
          final TextContent content => _TextClipInspector(
            clipId: clip.id,
            content: content,
          ),
        },
      ],
    );
  }
}

class _TextClipInspector extends ConsumerStatefulWidget {
  const _TextClipInspector({required this.clipId, required this.content});

  final String clipId;
  final TextContent content;

  @override
  ConsumerState<_TextClipInspector> createState() => _TextClipInspectorState();
}

class _TextClipInspectorState extends ConsumerState<_TextClipInspector> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.content.text);
  }

  @override
  void didUpdateWidget(covariant _TextClipInspector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.content.text != widget.content.text &&
        _textController.text != widget.content.text) {
      _textController.text = widget.content.text;
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editor = ref.watch(timelineEditorProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionLabel('Text'),
        const SizedBox(height: 8),
        TextField(
          controller: _textController,
          maxLines: 4,
          style: const TextStyle(color: Colors.white, fontSize: 13),
          decoration: _inputDecoration(),
          onChanged: (value) {
            editor.updateTextClip(widget.clipId, text: value);
          },
        ),
        const SizedBox(height: 16),
        const _SectionLabel('Font size'),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: widget.content.fontSize.clamp(8, 160),
                min: 8,
                max: 160,
                divisions: 152,
                onChanged: (value) {
                  editor.updateTextClip(widget.clipId, fontSize: value);
                },
              ),
            ),
            SizedBox(
              width: 64,
              child: TextFormField(
                key: ValueKey(widget.content.fontSize.round()),
                initialValue: widget.content.fontSize.round().toString(),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white, fontSize: 13),
                decoration: _inputDecoration(),
                onFieldSubmitted: (value) {
                  final fontSize = double.tryParse(value);
                  if (fontSize == null) {
                    return;
                  }
                  editor.updateTextClip(
                    widget.clipId,
                    fontSize: fontSize.clamp(8, 160),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const _SectionLabel('Color'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final color in _textColors)
              _ColorSwatch(
                color: color,
                selected:
                    color.toARGB32() == widget.content.textColor.toARGB32(),
                onTap: () {
                  editor.updateTextClip(widget.clipId, textColor: color);
                },
              ),
          ],
        ),
      ],
    );
  }
}

class _ReadOnlyField extends StatelessWidget {
  const _ReadOnlyField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 72,
          child: Text(
            label,
            style: const TextStyle(color: Color(0xff9ca3af), fontSize: 12),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: Color(0xffcbd5e1),
        fontSize: 12,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: '#${color.toARGB32().toRadixString(16).padLeft(8, '0')}',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: selected ? Colors.white : const Color(0xff4b5563),
              width: selected ? 2 : 1,
            ),
          ),
        ),
      ),
    );
  }
}

InputDecoration _inputDecoration() {
  return const InputDecoration(
    isDense: true,
    filled: true,
    fillColor: Color(0xff111827),
    border: OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xff374151)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xff93c5fd)),
    ),
  );
}

const _textColors = [
  Color(0xffffffff),
  Color(0xfffacc15),
  Color(0xfffb7185),
  Color(0xff60a5fa),
  Color(0xff34d399),
  Color(0xff111827),
];
