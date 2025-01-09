import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/int_extension.dart';
import 'package:qixer/service/my_orders_service.dart';

import '../../utils/common_helper.dart';
import '../../utils/custom_dropdown.dart';
import '../../utils/responsive.dart';

class OrderSort extends StatelessWidget {
  const OrderSort({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<MyOrdersService>(builder: (context, moProvider, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonHelper().labelCommon(lnProvider.getString('Order') + ' ',
              margin: EdgeInsets.zero),
          Expanded(
            flex: 1,
            child: CustomDropdown(
              lnProvider.getString("Select status"),
              moProvider.orderStatusOptions,
              (p0) {
                moProvider.setOrderSort(p0);
              },
              value: moProvider.selectedOrderSort,
            ),
          ),
          8.toWidth,
          CommonHelper().labelCommon(lnProvider.getString('Payment') + '  ',
              margin: EdgeInsets.zero),
          Expanded(
            flex: 1,
            child: CustomDropdown(
              lnProvider.getString("Select status"),
              moProvider.paymentStatusOptions,
              (p0) {
                moProvider.setPaymentSort(p0);
              },
              value: moProvider.selectedPaymentSort,
            ),
          ),
        ],
      );
    });
  }
}
