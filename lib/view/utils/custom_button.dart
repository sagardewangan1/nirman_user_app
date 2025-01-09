import 'package:flutter/material.dart';
import 'package:qixer/view/utils/responsive.dart';

import 'constant_colors.dart';
import 'others_helper.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String btText;
  final bool isLoading;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.btText,
    required this.isLoading,
    this.height = 40,
    this.width,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onPressed == null
            ? null
            : isLoading
                ? () {}
                : () {
                    onPressed!();
                  },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return cc.primaryColor.withOpacity(.05);
            }
            if (states.contains(WidgetState.pressed)) {
              return cc.black3;
            }
            return backgroundColor ?? cc.primaryColor;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return cc.black5;
            }
            if (states.contains(WidgetState.pressed)) {
              return foregroundColor ?? cc.white;
            }
            return foregroundColor ?? cc.white;
          }),
        ),
        child: isLoading
            ? SizedBox(
                child: OthersHelper().showLoading(cc.white),
              )
            : FittedBox(
                child: Text(
                  lnProvider.getString(btText),
                  maxLines: 1,
                ),
              ),
      ),
    );
  }
}
