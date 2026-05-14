import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/text_clip.dart';
import 'package:voivo_movie_maker/features/inspector/widget/inspector_controls.dart';
import 'package:voivo_movie_maker/features/timeline/controllers/timeline_editor.dart';

class TextClipInspector extends ConsumerStatefulWidget {
  const TextClipInspector({
    required this.clipId,
    required this.clip,
    super.key,
  });

  final TimelineClipId clipId;
  final TextClip clip;

  @override
  ConsumerState<TextClipInspector> createState() => _TextClipInspectorState();
}

class _TextClipInspectorState extends ConsumerState<TextClipInspector> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.clip.text);
  }

  @override
  void didUpdateWidget(covariant TextClipInspector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.clip.text != widget.clip.text &&
        _textController.text != widget.clip.text) {
      _textController.text = widget.clip.text;
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
        const InspectorSectionLabel('Text'),
        const SizedBox(height: 8),
        TextField(
          controller: _textController,
          maxLines: 4,
          style: const TextStyle(color: Colors.white, fontSize: 13),
          decoration: inspectorInputDecoration(),
          onChanged: (value) {
            editor.updateTextClip(widget.clipId, text: value);
          },
        ),
        const SizedBox(height: 16),
        const InspectorSectionLabel('Font size'),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: widget.clip.size.clamp(8, 160),
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
                key: ValueKey(widget.clip.size.round()),
                initialValue: widget.clip.size.round().toString(),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white, fontSize: 13),
                decoration: inspectorInputDecoration(),
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
        const InspectorSectionLabel('Color'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final color in _textColors)
              InspectorColorSwatch(
                color: color,
                selected: color.toARGB32() == widget.clip.color.toARGB32(),
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

const _textColors = [
  Color(0xffffffff),
  Color(0xfffacc15),
  Color(0xfffb7185),
  Color(0xff60a5fa),
  Color(0xff34d399),
  Color(0xff111827),
];
