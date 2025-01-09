import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qixer/helper/extension/string_extension.dart';

import '/helper/extension/context_extension.dart';
import 'constant_colors.dart';

class TacPp extends StatelessWidget {
  final ValueNotifier<bool> valueListenable;
  final String pData;
  final String pTitle;
  final String tData;
  final String tTitle;

  const TacPp({
    super.key,
    required this.valueListenable,
    required this.pTitle,
    required this.pData,
    required this.tData,
    required this.tTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: ValueListenableBuilder<bool>(
            valueListenable: valueListenable,
            builder: (context, value, child) {
              return Transform.scale(
                scale: 1.3,
                child: Checkbox(
                  value: valueListenable.value,
                  onChanged: (newValue) {
                    valueListenable.value = newValue ?? !value;
                  },
                ),
              );
            },
          ),
        ),
        Expanded(
          flex: 10,
          child: RichText(
            softWrap: true,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
                text: "${'I agree to'.tr()} ",
                style: context.titleMedium?.copyWith(
                  color: cc.black5,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = tData.isEmpty
                            ? null
                            : () {
                                FocusScope.of(context).unfocus();
                                // Navigator.of(context).pushNamed(
                                //     WebViewScreen.routeName,
                                //     arguments: [tTitle, tData]);
                              },
                      text: tTitle,
                      style: tData.isNotEmpty
                          ? context.titleMedium?.copyWith(
                              color: cc.primaryColor,
                              fontWeight: FontWeight.w600)
                          : null),
                  TextSpan(
                    text: " ${'and'.tr()} ",
                  ),
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = pData.isEmpty
                            ? null
                            : () {
                                FocusScope.of(context).unfocus();
                                // Navigator.of(context).pushNamed(
                                //     WebViewScreen.routeName,
                                //     arguments: [
                                //       pTitle,
                                //       pData,
                                //     ]);
                              },
                      text: pTitle.tr(),
                      style: pData.isNotEmpty
                          ? context.titleMedium?.copyWith(
                              color: cc.primaryColor,
                              fontWeight: FontWeight.w600)
                          : null),
                ]),
          ),
        ),
      ],
    );
  }
}
