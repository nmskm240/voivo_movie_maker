import 'package:flutter/material.dart';

import '../models/timeline.dart';

class InspectorPane extends StatelessWidget {
  const InspectorPane({super.key, required this.clip});

  final TimelineClip clip;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xff171b1e),
        border: Border(left: BorderSide(color: Color(0xff2b3136))),
      ),
      child: ListView(
        children: [
          const Text(
            'インスペクター',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 18),
          _PropertyRow(label: '選択中', value: clip.title),
          const SizedBox(height: 16),
          const _SliderProperty(label: '位置 X', value: 0.48),
          const _SliderProperty(label: '位置 Y', value: 0.72),
          const _SliderProperty(label: '拡大率', value: 0.64),
          const _SliderProperty(label: '不透明度', value: 1),
          const SizedBox(height: 14),
          const Divider(color: Color(0xff2b3136)),
          const SizedBox(height: 12),
          SwitchListTile(
            value: true,
            onChanged: (_) {},
            title: const Text('フェードアウト'),
            subtitle: const Text('終了 0.4 秒前から適用'),
            contentPadding: EdgeInsets.zero,
          ),
          SwitchListTile(
            value: false,
            onChanged: (_) {},
            title: const Text('キーフレーム'),
            subtitle: const Text('位置とサイズを時間変化させる'),
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}

class _PropertyRow extends StatelessWidget {
  const _PropertyRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xffa9b3ba), fontSize: 12),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xff22282d),
            border: Border.all(color: const Color(0xff354047)),
          ),
          child: Text(value, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}

class _SliderProperty extends StatelessWidget {
  const _SliderProperty({required this.label, required this.value});

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 72,
            child: Text(
              label,
              style: const TextStyle(color: Color(0xffa9b3ba), fontSize: 12),
            ),
          ),
          Expanded(child: Slider(value: value, onChanged: (_) {})),
          SizedBox(
            width: 42,
            child: Text(
              value.toStringAsFixed(2),
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
