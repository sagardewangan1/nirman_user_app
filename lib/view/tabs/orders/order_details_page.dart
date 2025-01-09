import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/order_details_service.dart';
import 'package:qixer/view/tabs/orders/components/amount_details.dart';
import 'package:qixer/view/tabs/orders/components/complete_request.dart';
import 'package:qixer/view/tabs/orders/components/decline_history.dart';
import 'package:qixer/view/tabs/orders/components/order_extras.dart';
import 'package:qixer/view/tabs/orders/components/seller_details.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/responsive.dart';

import '../../booking/booking_helper.dart';
import '../../utils/others_helper.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key, required this.orderId});

  final orderId;

  @override
  _OrdersDetailsPageState createState() => _OrdersDetailsPageState();
}

class _OrdersDetailsPageState extends State<OrderDetailsPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<OrderDetailsService>(context, listen: false)
        .fetchOrderDetails(widget.orderId, context);
  }

  ConstantColors cc = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: cc.bgColor,
        appBar: CommonHelper()
            .appbarCommon(lnProvider.getString('Order Details'), context, () {
          Navigator.pop(context);
        }),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: physicsCommon,
            child: Consumer<AppStringService>(
              builder: (context, asProvider, child) =>
                  Consumer<OrderDetailsService>(
                builder: (context, provider, child) => provider.isLoading ==
                        false
                    ? provider.orderDetails != 'error'
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),

                                  //Seller details
                                  const SellerDetails(),
                                  // Date and schedule
                                  provider.orderDetails.isOrderOnline == 0
                                      ? Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 25),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(9)),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CommonHelper().titleCommon(
                                                    asProvider.getString(
                                                        'Date & Schedule')),
                                                const SizedBox(
                                                  height: 25,
                                                ),
                                                //Service row

                                                Container(
                                                  child: BookingHelper().bRow(
                                                      'null',
                                                      asProvider
                                                          .getString('Date'),
                                                      provider.orderDetails
                                                                  .date ==
                                                              null
                                                          ? lnProvider.getString(
                                                              "No date found")
                                                          : DateFormat.MMMMEEEEd(
                                                                  rtlProvider
                                                                      .langSlug
                                                                      .substring(
                                                                          0, 2))
                                                              .format(provider
                                                                  .orderDetails
                                                                  .date)),
                                                ),

                                                Container(
                                                  child: BookingHelper().bRow(
                                                      'null',
                                                      asProvider.getString(
                                                          'Schedule'),
                                                      asProvider.getString(
                                                          provider.orderDetails
                                                              .schedule),
                                                      lastBorder: false),
                                                ),
                                              ]),
                                        )
                                      : Container(),

                                  //amount details
                                  const AmountDetails(),

                                  // Date and schedule
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 25),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(9)),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CommonHelper().titleCommon(asProvider
                                              .getString('Order Status')),
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          Container(
                                            child: BookingHelper().bRow(
                                                'null',
                                                asProvider
                                                    .getString('Order Status'),
                                                asProvider.getString(
                                                    provider.orderStatus),
                                                lastBorder: false),
                                          ),
                                        ]),
                                  ),

                                  const DeclineHistory(),

                                  // order extras
                                  // ==============>
                                  OrderExtras(
                                    orderId: widget.orderId,
                                    sellerId: provider.orderDetails.sellerId,
                                  ),

                                  //complete request
                                  CompleteRequest(
                                    orderId: widget.orderId,
                                  ),
                                ]),
                          )
                        : CommonHelper().nothingfound(
                            context, asProvider.getString('No details found'))
                    : Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height - 120,
                        child: OthersHelper().showLoading(cc.primaryColor)),
              ),
            ),
          ),
        ));
  }
}
