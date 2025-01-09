import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/orders_service.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/responsive.dart';

class DeclineHistory extends StatelessWidget {
  const DeclineHistory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cc = ConstantColors();

    return Consumer<OrdersService>(
      builder: (context, provider, child) => provider.declineHistory != null
          ? Container(
              margin: const EdgeInsets.only(bottom: 25),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(9)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonHelper().titleCommon('Decline history'),
                  for (int i = 0;
                      i < provider.declineHistory['decline_histories'].length;
                      i++)
                    Container(
                      margin: const EdgeInsets.only(top: 13),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonHelper().titleCommon(
                                lnProvider.getString("Decline reason") +
                                    ":  ${provider.declineHistory['decline_histories'][i]['decline_reason']}",
                                fontsize: 14,
                                lineheight: 1.5),
                            sizedBoxCustom(9),
                            CommonHelper().titleCommon(
                                '${lnProvider.getString('Buyer details')}:',
                                fontsize: 14,
                                color: cc.successColor),
                            sizedBoxCustom(8),
                            CommonHelper().paragraphCommon(
                              '${lnProvider.getString('Name')}: ${provider.declineHistory['seller_details'][0]['name']}',
                            ),
                            sizedBoxCustom(4),
                            CommonHelper().paragraphCommon(
                              '${lnProvider.getString('Email')}: ${provider.declineHistory['seller_details'][0]['email']}',
                            ),
                            sizedBoxCustom(4),
                            CommonHelper().paragraphCommon(
                              '${lnProvider.getString('Phone')}: ${provider.declineHistory['seller_details'][0]['phone']}',
                            ),
                            sizedBoxCustom(20),
                            CommonHelper().dividerCommon()
                          ]),
                    )
                ],
              ),
            )
          : Container(),
    );
  }
}
