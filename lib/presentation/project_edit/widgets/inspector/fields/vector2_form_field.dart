// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:vector_math/vector_math.dart';

class Vector2FormField extends FormBuilderFieldDecoration<Vector2> {
  Vector2FormField({
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
    this.xLabel = 'X',
    this.yLabel = 'Y',
    this.textInputAction = TextInputAction.next,
  }) : super(
         builder: (field) {
           final state = field as _Vector2FormFieldState;
           return state.buildField();
         },
       );

  final String xLabel;
  final String yLabel;
  final TextInputAction textInputAction;

  @override
  FormBuilderFieldDecorationState<Vector2FormField, Vector2> createState() =>
      _Vector2FormFieldState();
}

class _Vector2FormFieldState
    extends FormBuilderFieldDecorationState<Vector2FormField, Vector2> {
  late final TextEditingController _xController;
  late final TextEditingController _yController;
  late final FocusNode _yFocusNode;
  var _controllersReady = false;
  var _isEditing = false;

  @override
  void initState() {
    super.initState();
    _xController = TextEditingController(text: _format(value?.x));
    _yController = TextEditingController(text: _format(value?.y));
    _yFocusNode = FocusNode(debugLabel: '${widget.name}.y');
    _controllersReady = true;
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _yFocusNode.dispose();
    super.dispose();
  }

  @override
  void reset() {
    super.reset();
    _syncControllers(value);
  }

  Widget buildField() {
    return InputDecorator(
      decoration: decoration,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _xController,
              focusNode: effectiveFocusNode,
              enabled: enabled,
              decoration: InputDecoration(
                isDense: true,
                labelText: widget.xLabel,
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              textInputAction: widget.textInputAction,
              onChanged: (_) => _didChange(),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _yController,
              focusNode: _yFocusNode,
              enabled: enabled,
              decoration: InputDecoration(
                isDense: true,
                labelText: widget.yLabel,
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              textInputAction: widget.textInputAction,
              onChanged: (_) => _didChange(),
            ),
          ),
        ],
      ),
    );
  }

  void _didChange() {
    final x = double.tryParse(_xController.text);
    final y = double.tryParse(_yController.text);
    _isEditing = true;
    didChange(x == null || y == null ? null : Vector2(x, y));
    _isEditing = false;
  }

  @override
  void didChange(Vector2? value) {
    super.didChange(value);
    if (!_isEditing) {
      _syncControllers(value);
    }
  }

  @override
  void setValue(Vector2? value, {bool populateForm = true}) {
    super.setValue(value, populateForm: populateForm);
    if (_controllersReady) {
      _syncControllers(value);
    }
  }

  void _syncControllers(Vector2? value) {
    _xController.text = _format(value?.x);
    _yController.text = _format(value?.y);
  }

  String _format(double? value) {
    if (value == null) {
      return '';
    }

    return value.toString();
  }
}
