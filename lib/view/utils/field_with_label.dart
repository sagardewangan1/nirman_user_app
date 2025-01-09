import 'package:flutter/material.dart';
import 'package:qixer/helper/extension/int_extension.dart';
import '/helper/extension/string_extension.dart';

import 'field_label.dart';

class FieldWithLabel extends StatelessWidget {
  final String label;
  final String hintText;
  final initialValue;
  final onChanged;
  final onFieldSubmitted;
  final String? Function(String? value)? validator;
  final keyboardType;
  final textInputAction;
  final String? svgPrefix;
  final AutovalidateMode? autovalidateMode;
  final errorText;
  final successText;

  final controller;
  final isRequired;
  const FieldWithLabel(
      {super.key,
      required this.label,
      required this.hintText,
      this.initialValue,
      this.onChanged,
      this.onFieldSubmitted,
      this.validator,
      this.keyboardType,
      this.textInputAction,
      this.svgPrefix,
      this.autovalidateMode,
      this.isRequired,
      this.errorText,
      this.successText,
      this.controller});

  setInitialValue(value) {
    if (value == null || value.isEmpty) {
      return;
    }

    controller?.text = value;
  }

  @override
  Widget build(BuildContext context) {
    setInitialValue(initialValue);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(label: label.tr()),
        TextFormField(
          keyboardType: keyboardType,
          textInputAction: textInputAction ?? TextInputAction.next,
          controller: controller,
          autovalidateMode: autovalidateMode,
          decoration: InputDecoration(
            hintText: hintText.tr(),
            prefixIcon: svgPrefix != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: svgPrefix!.toSVG,
                  )
                : null,
          ),
          onChanged: onChanged,
          validator: validator,
          onFieldSubmitted: onFieldSubmitted,
        ),
        16.toHeight,
      ],
    );
  }
}
