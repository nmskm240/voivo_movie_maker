// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';

// Project imports:
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/fields/scrubbable_number_region.dart';

class ScrubbableNumberFormField extends FormBuilderFieldDecoration<double> {
  ScrubbableNumberFormField({
    super.key,
    required super.name,
    required this.label,
    super.initialValue,
    super.validator,
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
    this.stepPerPixel = 1,
    this.min,
    this.max,
  }) : super(
         builder: (field) {
           final state = field as _ScrubbableNumberFormFieldState;
           return state.buildField();
         },
       );

  final String label;
  final double stepPerPixel;
  final double? min;
  final double? max;

  @override
  FormBuilderFieldDecorationState<ScrubbableNumberFormField, double>
  createState() => _ScrubbableNumberFormFieldState();
}

class _ScrubbableNumberFormFieldState
    extends FormBuilderFieldDecorationState<ScrubbableNumberFormField, double> {
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
    return ScrubbableNumberRegion(
      value: () => value ?? double.tryParse(_controller.text) ?? 0,
      stepPerPixel: widget.stepPerPixel,
      min: widget.min,
      max: widget.max,
      onChanged: didChange,
      child: TextField(
        controller: _controller,
        focusNode: effectiveFocusNode,
        enabled: enabled,
        decoration: decoration.copyWith(labelText: widget.label),
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
          signed: true,
        ),
        onChanged: (text) {
          _isEditing = true;
          didChange(double.tryParse(text));
          _isEditing = false;
        },
      ),
    );
  }

  @override
  void didChange(double? value) {
    super.didChange(value);
    if (!_isEditing) {
      _syncController(value);
    }
  }

  @override
  void setValue(double? value, {bool populateForm = true}) {
    super.setValue(value, populateForm: populateForm);
    if (_controllerReady) {
      _syncController(value);
    }
  }

  void _syncController(double? value) {
    _controller.text = _format(value);
  }

  String _format(double? value) => value?.toString() ?? '';
}
