import 'package:flutter/material.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';

class OverviewBox extends StatelessWidget {
  const OverviewBox({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: Colors.grey.withOpacity(.5)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CommonHelper().paragraphCommon(title, fontsize: 13),

        sizedBoxCustom(7),

        //amount
        CommonHelper().titleCommon(subtitle, fontsize: 15)
      ]),
    );
  }
}
