// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/service/booking_services/place_order_service.dart';
import 'package:qixer/service/jobs_service/job_request_service.dart';
import 'package:qixer/service/order_details_service.dart';
import 'package:qixer/service/payment_gateway_list_service.dart';
import 'package:qixer/service/wallet_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../service/rtl_service.dart';
import '../utils/common_helper.dart';
import '../utils/constant_colors.dart';

class CashfreePayment extends StatelessWidget {
  CashfreePayment(
      {super.key,
      required this.amount,
      required this.name,
      required this.phone,
      required this.email,
      required this.isFromOrderExtraAccept,
      required this.isFromWalletDeposite,
      required this.isFromHireJob});

  final amount;
  final name;
  final phone;
  final email;
  final isFromOrderExtraAccept;
  final isFromWalletDeposite;
  final isFromHireJob;

  String? html;

  final WebViewController _controller = WebViewController();
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(microseconds: 600), () {
      Provider.of<PlaceOrderService>(context, listen: false).setLoadingFalse();
    });

    return Scaffold(
      appBar: CommonHelper().appbarCommon('Payfast', context, () {
        Provider.of<PlaceOrderService>(context, listen: false)
            .doNext(context, 'failed', paymentFailed: true);
      }),
      body: WillPopScope(
        onWillPop: () async {
          await Provider.of<PlaceOrderService>(context, listen: false)
              .doNext(context, 'failed', paymentFailed: true);
          return false;
        },
        child: FutureBuilder(
            future: waitForIt(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: SizedBox(
                            height: 60,
                            child:
                                OthersHelper().showLoading(cc.primaryColor))),
                  ],
                );
              }
              _controller
                ..loadHtmlString(html ?? "payment failed")
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..setNavigationDelegate(
                  NavigationDelegate(
                    onProgress: (int progress) {
                      // Update loading bar.
                    },
                    onPageStarted: (String url) {},
                    onPageFinished: (String url) {
                      verifyPayment(
                        url.toString(),
                      );
                    },
                    onWebResourceError: (WebResourceError error) async {
                      await showDialog(
                          context: context,
                          builder: (ctx) {
                            return const AlertDialog(
                              title: Text('Loading failed!'),
                              content: Text('Failed to load payment page.'),
                            );
                          });
                      await Provider.of<PlaceOrderService>(context,
                              listen: false)
                          .doNext(context, 'failed', paymentFailed: true);
                    },
                    onNavigationRequest: (NavigationRequest request) async {
                      if (request.url.contains("success")) {
                        if (isFromOrderExtraAccept == true) {
                          await Provider.of<OrderDetailsService>(context,
                                  listen: false)
                              .acceptOrderExtra(context);
                        } else if (isFromWalletDeposite) {
                          await Provider.of<WalletService>(context,
                                  listen: false)
                              .makeDepositeToWalletSuccess(context);
                        } else if (isFromHireJob) {
                          Provider.of<JobRequestService>(context, listen: false)
                              .goToJobSuccessPage(context);
                        } else {
                          await Provider.of<PlaceOrderService>(context,
                                  listen: false)
                              .makePaymentSuccess(context);
                        }
                        return NavigationDecision.prevent;
                      }
                      if (request.url.contains("failed")) {
                        await Provider.of<PlaceOrderService>(context,
                                listen: false)
                            .doNext(context, 'failed', paymentFailed: true);
                        return NavigationDecision.prevent;
                      }
                      return NavigationDecision.navigate;
                    },
                  ),
                );
              return WebViewWidget(
                controller: _controller,
              );
            }),
      ),
    );
  }

  onSuccess(BuildContext context, isFromOrderExtraAccept, isFromWalletDeposite,
      isFromHireJob) {
    if (isFromOrderExtraAccept == true) {
      Provider.of<OrderDetailsService>(context, listen: false)
          .acceptOrderExtra(context);
    } else if (isFromWalletDeposite) {
      Provider.of<WalletService>(context, listen: false)
          .makeDepositeToWalletSuccess(context);
    } else if (isFromHireJob) {
      Provider.of<JobRequestService>(context, listen: false)
          .goToJobSuccessPage(context);
    } else {
      Provider.of<PlaceOrderService>(context, listen: false)
          .makePaymentSuccess(context);
    }
  }

  waitForIt(BuildContext context) async {
    final merchantId =
        Provider.of<PaymentGatewayListService>(context, listen: false)
            .publicKey;

    final merchantKey =
        Provider.of<PaymentGatewayListService>(context, listen: false)
            .secretKey;
    final currencyCode =
        Provider.of<RtlService>(context, listen: false).currencyCode;
    final orderId =
        Provider.of<PlaceOrderService>(context, listen: false).orderId;
    // final merchantId = '10024000';

    // final merchantKey = '77jcu5v4ufdod';
    final data = {
      'title': 'Qixer payment',
      'description': 'Qixer payment',
      'last_order_id': orderId,
      'cancel_url': 'failed.com',
      'success_url': 'success.com',
      'total': amount,
      'email': email,
      'name': name,
      'payment_type': 'order'
    };

    debugPrint(data.toString());
    final url = '$baseApi/user/payment/cashfree';

    final headers = {'Authorization': 'Bearer $getToken'};

    final response = await http.post(Uri.parse(url),
        body: jsonEncode(data), headers: headers);

    html = response.body;
    //   return;
    // }

    // return true;
  }

  Future<bool> verifyPayment(String url) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    return response.body.contains('successful');
  }
}
