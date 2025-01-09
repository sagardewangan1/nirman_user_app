import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/order_details_service.dart';
import 'package:qixer/view/booking/payment_choose_page.dart';
import 'package:qixer/view/tabs/orders/components/order_details_helper.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/responsive.dart';

import '../orders_helper.dart';

class OrderExtras extends StatelessWidget {
  const OrderExtras({super.key, required this.orderId, required this.sellerId});
  final orderId;
  final sellerId;

  @override
  Widget build(BuildContext context) {
    final cc = ConstantColors();

    return Consumer<OrderDetailsService>(
      builder: (context, provider, child) => provider.orderExtra.isNotEmpty
          ? Container(
              margin: const EdgeInsets.only(bottom: 25),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(9)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonHelper().titleCommon('Extras'),
                  const SizedBox(
                    height: 20,
                  ),
                  for (int i = 0; i < provider.orderExtra.length; i++)
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonHelper().titleCommon(
                              provider.orderExtra[i].title,
                              fontsize: 15),
                          sizedBoxCustom(4),
                          OrdersHelper().statusCapsule(
                              (lnProvider.getString(extraStatus(
                                      provider.orderExtra[i].status)) as String)
                                  .capitalize(),
                              extraColor(provider.orderExtra[i].status)),
                          sizedBoxCustom(4),
                          CommonHelper().paragraphCommon(
                            lnProvider.getString("Unit price") +
                                ': ${rtlProvider.currency}${provider.orderExtra[i].price.toStringAsFixed(2)}    ${lnProvider.getString("Quantity")}: ${provider.orderExtra[i].quantity}    ${lnProvider.getString("Total")}: ${rtlProvider.currency}${provider.orderExtra[i].total.toStringAsFixed(2)}',
                          ),
                          sizedBoxCustom(12),

                          //0=pending,1=accept,2=decline
                          if (provider.orderExtra[i].status == 0)
                            Row(
                              children: [
                                Expanded(
                                    child: CommonHelper()
                                        .buttonOrange('Decline', () {
                                  OrderDetailsHelper().deletePopup(context,
                                      extraId: provider.orderExtra[i].id,
                                      orderId: orderId,
                                      warningText: "Decline");
                                }, bgColor: Colors.red, paddingVerticle: 10)),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                    child: CommonHelper().buttonOrange('Accept',
                                        () {
                                  provider.setExtraDetails(
                                      orderId: orderId,
                                      extraId: provider.orderExtra[i].id,
                                      extraPrice: provider.orderExtra[i].total
                                          .toStringAsFixed(2),
                                      sellerId: sellerId);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PaymentChoosePage(
                                              isFromOrderExtraAccept: true,
                                            )),
                                  );
                                },
                                        bgColor: cc.successColor,
                                        paddingVerticle: 10)),
                              ],
                            ),
                          sizedBoxCustom(10),
                          CommonHelper().dividerCommon(),
                          sizedBoxCustom(10),
                        ])
                ],
              ),
            )
          : Container(),
    );
  }

  extraStatus(status) {
    String statusString = '';
    switch (status.toString()) {
      case "1":
        statusString = "complete";
        break;
      case "2":
        statusString = "declined";
        break;
      default:
        statusString = "pending";
    }
    return statusString;
  }

  extraColor(status) {
    ConstantColors cc = ConstantColors();
    Color statusColor;
    switch (status.toString()) {
      case "1":
        statusColor = cc.successColor;
        break;
      case "2":
        statusColor = cc.warningColor;
        break;
      default:
        statusColor = cc.greyFour;
    }
    return statusColor;
  }
}
