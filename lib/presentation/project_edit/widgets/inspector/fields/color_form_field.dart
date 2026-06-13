// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_colorpicker/flutter_colorpicker.dart' as color_picker;
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ColorFormField extends FormBuilderFieldDecoration<Color> {
  ColorFormField({
    super.key,
    required super.name,
    super.validator,
    super.initialValue,
    super.decoration,
    super.onChanged,
    super.valueTransformer,
    super.enabled,
    super.onSaved,
    super.autovalidateMode = AutovalidateMode.disabled,
    super.onReset,
    super.focusNode,
    super.restorationId,
    super.errorBuilder,
    this.includeAlpha = false,
  }) : super(
         builder: (field) {
           final state = field as _ColorFormFieldState;
           return state.buildField();
         },
       );

  final bool includeAlpha;

  @override
  FormBuilderFieldDecorationState<ColorFormField, Color> createState() =>
      _ColorFormFieldState();
}

class _ColorFormFieldState
    extends FormBuilderFieldDecorationState<ColorFormField, Color> {
  late final TextEditingController _controller;
  var _controllerReady = false;
  var _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _format(value));
    _controllerReady = true;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void reset() {
    super.reset();
    _syncController(value);
  }

  Widget buildField() {
    final color = value;

    return InputDecorator(
      decoration: decoration,
      child: Row(
        children: [
          _ColorSwatchButton(
            color: color,
            enabled: enabled,
            onTap: _showPicker,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: effectiveFocusNode,
              enabled: enabled,
              decoration: const InputDecoration(
                isDense: true,
                hintText: '#RRGGBB',
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9a-fA-F#]')),
                LengthLimitingTextInputFormatter(widget.includeAlpha ? 9 : 7),
              ],
              textCapitalization: TextCapitalization.characters,
              onChanged: _didEditHex,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showPicker() async {
    if (!enabled) {
      return;
    }

    final nextColor = await showDialog<Color>(
      context: context,
      builder: (context) {
        return _ColorPickerDialog(
          initialColor: value ?? Colors.white,
          includeAlpha: widget.includeAlpha,
        );
      },
    );

    if (nextColor != null) {
      didChange(nextColor);
    }
  }

  void _didEditHex(String text) {
    _isEditing = true;
    didChange(
      color_picker.colorFromHex(text, enableAlpha: widget.includeAlpha),
    );
    _isEditing = false;
  }

  @override
  void didChange(Color? value) {
    super.didChange(value);
    if (!_isEditing) {
      _syncController(value);
    }
  }

  @override
  void setValue(Color? value, {bool populateForm = true}) {
    super.setValue(value, populateForm: populateForm);
    if (_controllerReady) {
      _syncController(value);
    }
  }

  void _syncController(Color? color) {
    _controller.text = _format(color);
  }

  String _format(Color? color) {
    if (color == null) {
      return '';
    }

    return color_picker.colorToHex(
      color,
      includeHashSign: true,
      enableAlpha: widget.includeAlpha,
    );
  }
}

class _ColorPickerDialog extends StatefulWidget {
  const _ColorPickerDialog({
    required this.initialColor,
    required this.includeAlpha,
  });

  final Color initialColor;
  final bool includeAlpha;

  @override
  State<_ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<_ColorPickerDialog> {
  late Color _color;
  late final TextEditingController _hexController;

  @override
  void initState() {
    super.initState();
    _color = widget.initialColor;
    _hexController = TextEditingController();
  }

  @override
  void dispose() {
    _hexController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Color'),
      content: SizedBox(
        width: 320,
        child: SingleChildScrollView(
          child: color_picker.ColorPicker(
            pickerColor: _color,
            onColorChanged: (color) => _color = color,
            enableAlpha: widget.includeAlpha,
            hexInputBar: true,
            hexInputController: _hexController,
            labelTypes: const [],
            pickerAreaHeightPercent: 0.8,
            portraitOnly: true,
            colorPickerWidth: 300,
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_color),
          child: const Text('OK'),
        ),
      ],
    );
  }
}

class _ColorSwatchButton extends StatelessWidget {
  const _ColorSwatchButton({
    required this.color,
    this.enabled = true,
    this.onTap,
  });

  final Color? color;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? Colors.transparent;

    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(4),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: effectiveColor,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: const SizedBox(width: 36, height: 36),
      ),
    );
  }
}
