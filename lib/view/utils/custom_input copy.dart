import 'package:flutter/material.dart';

import 'constant_colors.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validation;
  final TextInputAction textInputAction;
  final bool isPasswordField;
  final FocusNode? focusNode;
  final bool isNumberField;
  final String? icon;
  final double paddingHorizontal;
  final double paddingVertical;
  final double marginBottom;
  final double borderRadius;
  TextEditingController? controller;
  int? maxLines;
  int? minLines;

  CustomInput({
    Key? key,
    required this.hintText,
    this.onChanged,
    this.textInputAction = TextInputAction.next,
    this.isPasswordField = false,
    this.focusNode,
    this.isNumberField = false,
    this.controller,
    this.validation,
    this.icon,
    this.paddingHorizontal = 8.0,
    this.marginBottom = 19,
    this.borderRadius = 8,
    this.paddingVertical = 18,
    this.maxLines,
    this.minLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: marginBottom),
        decoration: BoxDecoration(
            // color: ConstantColors().greySecondary,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: TextFormField(
          controller: controller,
          keyboardType:
              isNumberField ? TextInputType.number : TextInputType.text,
          focusNode: focusNode,
          onChanged: onChanged,
          maxLines: maxLines,
          minLines: minLines,
          validator: validation,
          textInputAction: textInputAction,
          obscureText: isPasswordField,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
              fillColor: ConstantColors().borderColor,
              filled: true,
              prefixIcon: icon != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 22.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(icon!),
                                fit: BoxFit.fitHeight),
                          ),
                        ),
                      ],
                    )
                  : null,
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(borderRadius)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ConstantColors().primaryColor)),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ConstantColors().warningColor)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ConstantColors().primaryColor)),
              hintText: hintText,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: paddingHorizontal, vertical: paddingVertical)),
        ));
  }
}
