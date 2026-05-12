import 'package:flutter/material.dart';

class InspectorReadOnlyField extends StatelessWidget {
  const InspectorReadOnlyField({
    required this.label,
    required this.value,
    super.key,
  });

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

class InspectorSectionLabel extends StatelessWidget {
  const InspectorSectionLabel(this.label, {super.key});

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

class InspectorColorSwatch extends StatelessWidget {
  const InspectorColorSwatch({
    required this.color,
    required this.selected,
    required this.onTap,
    super.key,
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

InputDecoration inspectorInputDecoration() {
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
