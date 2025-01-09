import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/my_orders_service.dart';
import 'package:qixer/service/order_details_service.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/service/rtl_service.dart';
import 'package:qixer/view/tabs/orders/order_details_page.dart';
import 'package:qixer/view/tabs/orders/order_sort.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/login_or_register.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';

import 'orders_helper.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();
  }

  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    controller.addListener(() {
      scrollListener(context);
    });

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(lnProvider.getString("My Orders")),
        ),
        body: Consumer<ProfileService>(builder: (context, ps, child) {
          return ps.profileDetails == null || ps.profileDetails is String
              ? const LoginOrRegister()
              : FutureBuilder(
                  future: Provider.of<MyOrdersService>(context, listen: false)
                      .fetchMyOrders(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height - 120,
                          child: OthersHelper().showLoading(cc.primaryColor));
                    }
                    return Consumer<MyOrdersService>(
                      builder: (context, provider, child) => Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: screenPadding),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                const OrderSort(),
                                // for (int i = 0;
                                //     i < provider.myServices.length;
                                //     i++)
                                Expanded(
                                  child: !provider.isLoading
                                      ? provider.myServices != 'error'
                                          ? provider.myServices.isNotEmpty
                                              ? ListView.separated(
                                                  shrinkWrap: true,
                                                  physics: physicsCommon,
                                                  itemCount: provider
                                                              .nextPageUrl
                                                              ?.isNotEmpty ??
                                                          false
                                                      ? provider.myServices
                                                              .length +
                                                          1
                                                      : provider
                                                          .myServices.length,
                                                  controller: controller,
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          const SizedBox(
                                                              height: 16),
                                                  itemBuilder: ((context, i) {
                                                    if (i ==
                                                        provider.myServices
                                                            .length) {
                                                      return SizedBox(
                                                        height: 40,
                                                        child: Center(
                                                            child: OthersHelper()
                                                                .showLoading(cc
                                                                    .primaryColor)),
                                                      );
                                                    }
                                                    return InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute<
                                                                void>(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  OrderDetailsPage(
                                                                      orderId: provider
                                                                          .myServices[
                                                                              i]
                                                                          .id),
                                                            ));
                                                        //             );
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: cc
                                                                    .borderColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Column(
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        15,
                                                                        6,
                                                                        0,
                                                                        0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    AutoSizeText(
                                                                      '#${provider.myServices[i].id}',
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style:
                                                                          TextStyle(
                                                                        color: cc
                                                                            .primaryColor,
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        OrdersHelper().statusCapsule(
                                                                            lnProvider.getString(OrderDetailsService().getOrderStatus(provider.myServices[i].status)),
                                                                            cc.greyFour),

                                                                        //popup button
                                                                        PopupMenuButton(
                                                                          itemBuilder: (BuildContext context) =>
                                                                              <PopupMenuEntry>[
                                                                            for (int j = 0;
                                                                                j < OrdersHelper().ordersPopupMenuList.length;
                                                                                j++)
                                                                              PopupMenuItem(
                                                                                onTap: () {
                                                                                  Future.delayed(Duration.zero, () {
                                                                                    //

                                                                                    if (j == 1 && (provider.myServices[i].paymentStatus == 'complete' || provider.myServices[i].status != 0)) {
                                                                                      //0 means pending
                                                                                      OthersHelper().showToast('You can not cancel this order', Colors.black);
                                                                                      return;
                                                                                    }
                                                                                    OrdersHelper().navigateMyOrders(context, index: j, serviceId: provider.myServices[i].serviceId, orderId: provider.myServices[i].id);
                                                                                  });
                                                                                },
                                                                                child: Text(lnProvider.getString(OrdersHelper().ordersPopupMenuList[j])),
                                                                              ),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),

                                                              //Divider
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top: 6,
                                                                        bottom:
                                                                            17),
                                                                child: CommonHelper()
                                                                    .dividerCommon(),
                                                              ),

                                                              provider.myServices[i]
                                                                          .date !=
                                                                      "00.00.00"
                                                                  ? Container(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              15),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          OrdersHelper()
                                                                              .orderRow(
                                                                            'assets/svg/calendar.svg',
                                                                            'Date',
                                                                            provider.myServices[i].date == null
                                                                                ? lnProvider.getString("No date found")
                                                                                : DateFormat.MMMMEEEEd(rtlProvider.langSlug.substring(0, 2)).format(provider.myServices[i].date),
                                                                          ),
                                                                          Container(
                                                                            margin:
                                                                                const EdgeInsets.symmetric(vertical: 14),
                                                                            child:
                                                                                CommonHelper().dividerCommon(),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : Container(),

                                                              provider.myServices[i]
                                                                          .schedule !=
                                                                      "00.00.00"
                                                                  ? Container(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              15),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          OrdersHelper()
                                                                              .orderRow(
                                                                            'assets/svg/clock.svg',
                                                                            'Schedule',
                                                                            lnProvider.getString(provider.myServices[i].schedule),
                                                                          ),
                                                                          Container(
                                                                            margin:
                                                                                const EdgeInsets.symmetric(vertical: 14),
                                                                            child:
                                                                                CommonHelper().dividerCommon(),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : Container(),

                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        15,
                                                                        0,
                                                                        15,
                                                                        15),
                                                                child: Consumer<
                                                                    RtlService>(
                                                                  builder: (context,
                                                                          rtlP,
                                                                          child) =>
                                                                      OrdersHelper()
                                                                          .orderRow(
                                                                    'assets/svg/bill.svg',
                                                                    'Billed',
                                                                    rtlP.currencyDirection ==
                                                                            'left'
                                                                        ? '${rtlP.currency}${provider.myServices[i].total.toStringAsFixed(2)}'
                                                                        : '${provider.myServices[i].total.toStringAsFixed(2)}${rtlP.currency}',
                                                                  ),
                                                                ),
                                                              )
                                                            ]),
                                                      ),
                                                    );
                                                  }))
                                              : CommonHelper().nothingfound(
                                                  context, "No active order")
                                          : CommonHelper().nothingfound(
                                              context, "No active order")
                                      : Container(
                                          alignment: Alignment.center,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              200,
                                          child: OthersHelper()
                                              .showLoading(cc.primaryColor)),
                                ),

                                //
                              ])),
                    );
                  });
        }));
  }

  scrollListener(BuildContext context) async {
    final moProvider = Provider.of<MyOrdersService>(context, listen: false);
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      if (moProvider.nextPageUrl == null) {
        return;
      }
      if (moProvider.nextPageUrl != null && !moProvider.isLoadingNextPage) {
        await moProvider.fetchNextOrders();
        return;
      }
    }
  }
}
