// Dart imports:
import 'dart:math' as math;

// Flutter imports:
import 'package:flutter/material.dart';

class TimelineScaleControl extends StatelessWidget {
  const TimelineScaleControl({
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    super.key,
  });

  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  static const _stepFactor = 1.5;

  @override
  Widget build(BuildContext context) {
    final sliderValue = _toSliderValue(value);

    return Material(
      type: MaterialType.transparency,
      child: Row(
        children: [
          IconButton(
            key: const ValueKey('timeline-scale-out'),
            onPressed: value > min
                ? () => onChanged((value / _stepFactor).clamp(min, max))
                : null,
            tooltip: 'Zoom out timeline',
            icon: const Icon(Icons.remove, size: 16),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
          ),
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 2,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
              ),
              child: Slider(
                key: const ValueKey('timeline-scale-slider'),
                value: sliderValue,
                onChanged: (value) => onChanged(_fromSliderValue(value)),
              ),
            ),
          ),
          IconButton(
            key: const ValueKey('timeline-scale-in'),
            onPressed: value < max
                ? () => onChanged((value * _stepFactor).clamp(min, max))
                : null,
            tooltip: 'Zoom in timeline',
            icon: const Icon(Icons.add, size: 16),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
          ),
        ],
      ),
    );
  }

  double _toSliderValue(double value) {
    return math.log(value / min) / math.log(max / min);
  }

  double _fromSliderValue(double value) {
    return (min * math.pow(max / min, value)).toDouble();
  }
}
