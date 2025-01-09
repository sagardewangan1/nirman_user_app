import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterzilla_fixed_grid/flutterzilla_fixed_grid.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/profile_service.dart';

import '../../../utils/common_helper.dart';
import '../../../utils/constant_colors.dart';
import '../settings_helper.dart';

class SettingsPageGrid extends StatelessWidget {
  const SettingsPageGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cc = ConstantColors();
    return Consumer<AppStringService>(
      builder: (context, asProvider, child) => Consumer<ProfileService>(
        builder: (context, profileProvider, child) => GridView.builder(
          gridDelegate: const FlutterzillaFixedGridView(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              height: 76),
          padding: const EdgeInsets.only(top: 30),
          itemCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: cc.borderColor),
              ),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SvgPicture.asset(
                  SettingsHelper().cardContent[index].iconLink,
                  height: 35,
                ),
                const SizedBox(
                  width: 12,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonHelper().titleCommon(
                          profileProvider.ordersList[index].toString()),
                      const SizedBox(
                        height: 3,
                      ),
                      AutoSizeText(
                        asProvider.getString(
                            SettingsHelper().cardContent[index].text),
                        maxLines: 1,
                        style: TextStyle(
                          color: cc.greyParagraph,
                          height: 1.4,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                )
              ]),
            );
          },
        ),
      ),
    );
  }
}
