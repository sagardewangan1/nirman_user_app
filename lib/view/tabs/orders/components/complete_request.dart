import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/order_details_service.dart';
import 'package:qixer/service/orders_service.dart';
import 'package:qixer/view/tabs/orders/components/decline_order_page.dart';
import 'package:qixer/view/tabs/orders/orders_helper.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';

class CompleteRequest extends StatelessWidget {
  const CompleteRequest({super.key, required this.orderId});

  final orderId;

  @override
  Widget build(BuildContext context) {
    final cc = ConstantColors();
    return Consumer<AppStringService>(
      builder: (context, asProvider, child) => Consumer<OrderDetailsService>(
        builder: (context, provider, child) => Consumer<OrdersService>(
          builder: (context, oProvider, child) => provider
                      .orderDetails.orderCompleteRequest !=
                  0
              ? Column(
                  children: [
                    // order_complete_request == 0 (No Request Create)
                    // order_complete_request == 1 (Approve, Decline)
                    // order_complete_request == 2 ( Completed)
                    // order_complete_request == 3 (Request Decline, View History)

                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 25),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(9)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonHelper().titleCommon(
                                asProvider.getString('Complete Request')),
                            const SizedBox(
                              height: 15,
                            ),

                            //Declined
                            //==========>
                            if (provider.orderDetails.orderCompleteRequest == 3)
                              OrdersHelper().statusCapsule(
                                  asProvider.getString('Declined'),
                                  cc.warningColor),

                            //Completed
                            //==========>
                            if (provider.orderDetails.orderCompleteRequest == 2)
                              OrdersHelper().statusCapsule(
                                  asProvider.getString('Order completed'),
                                  cc.successColor),

                            //accept reject button
                            //==========>
                            if (provider.orderDetails.orderCompleteRequest == 1)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonHelper().paragraphCommon(
                                      asProvider.getString(
                                          'Seller requested to mark this order complete'),
                                      fontsize: 16),
                                  sizedBoxCustom(20),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: CommonHelper().buttonOrange(
                                              asProvider.getString('Decline'),
                                              () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DeclineOrderPage(
                                                    orderId: orderId,
                                                    sellerId: provider
                                                        .orderDetails
                                                        .sellerDetails
                                                        .id,
                                                  )),
                                        );
                                      }, bgColor: Colors.red)),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                          child: CommonHelper().buttonOrange(
                                              asProvider.getString('Accept'),
                                              () {
                                        if (oProvider.markLoading) return;

                                        oProvider.completeOrder(context,
                                            orderId: orderId);
                                      },
                                              bgColor: cc.successColor,
                                              isloading: oProvider.markLoading))
                                    ],
                                  )
                                ],
                              )
                            //Service row
                          ]),
                    ),
                  ],
                )
              : Container(),
        ),
      ),
    );
  }
}
