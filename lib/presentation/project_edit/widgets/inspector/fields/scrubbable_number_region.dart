// Flutter imports:
import 'package:flutter/material.dart';

class ScrubbableNumberRegion extends StatefulWidget {
  const ScrubbableNumberRegion({
    required this.value,
    required this.onChanged,
    required this.child,
    this.stepPerPixel = 1,
    this.min,
    this.max,
    super.key,
  });

  final double Function() value;
  final ValueChanged<double> onChanged;
  final Widget child;
  final double stepPerPixel;
  final double? min;
  final double? max;

  @override
  State<ScrubbableNumberRegion> createState() => _ScrubbableNumberRegionState();
}

class _ScrubbableNumberRegionState extends State<ScrubbableNumberRegion> {
  static const _scrubSlop = 8.0;

  var _startValue = 0.0;
  var _startPosition = Offset.zero;
  int? _pointer;

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (details) {
        if (_pointer != null) {
          return;
        }
        _pointer = details.pointer;
        _startValue = widget.value();
        _startPosition = details.position;
      },
      onPointerMove: (details) {
        if (details.pointer != _pointer) {
          return;
        }
        final offset = details.position - _startPosition;
        if (offset.dx.abs() < _scrubSlop ||
            offset.dx.abs() <= offset.dy.abs()) {
          return;
        }
        final nextValue = _startValue + offset.dx * widget.stepPerPixel;
        widget.onChanged(
          _roundToStep(nextValue)
              .clamp(
                widget.min ?? double.negativeInfinity,
                widget.max ?? double.infinity,
              )
              .toDouble(),
        );
      },
      onPointerUp: _clearPointer,
      onPointerCancel: _clearPointer,
      child: widget.child,
    );
  }

  void _clearPointer(PointerEvent details) {
    if (details.pointer == _pointer) {
      _pointer = null;
    }
  }

  double _roundToStep(double value) {
    final step = widget.stepPerPixel.abs();
    if (step == 0) {
      return value;
    }

    final rounded = (value / step).round() * step;
    return double.parse(rounded.toStringAsFixed(_fractionDigits(step)));
  }

  int _fractionDigits(double value) {
    final text = value.toString();
    final exponentIndex = text.indexOf('e-');
    if (exponentIndex >= 0) {
      return int.parse(text.substring(exponentIndex + 2));
    }

    final decimalIndex = text.indexOf('.');
    return decimalIndex < 0 ? 0 : text.length - decimalIndex - 1;
  }
}
