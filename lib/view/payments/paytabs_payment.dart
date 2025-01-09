// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

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
import 'package:webview_flutter/webview_flutter.dart';

import '../../service/rtl_service.dart';
import '../utils/common_helper.dart';
import '../utils/constant_colors.dart';
import '../utils/others_helper.dart';

class PayTabsPayment extends StatelessWidget {
  PayTabsPayment(
      {super.key,
      required this.amount,
      required this.name,
      required this.phone,
      required this.email,
      required this.orderId,
      required this.isFromOrderExtraAccept,
      required this.isFromWalletDeposite,
      required this.isFromHireJob});

  final amount;
  final name;
  final phone;
  final email;
  final isFromHireJob;

  final orderId;
  final isFromOrderExtraAccept;
  final isFromWalletDeposite;

  String? url;
  final WebViewController _controller = WebViewController();
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(microseconds: 600), () {
      Provider.of<PlaceOrderService>(context, listen: false).setLoadingFalse();
    });

    return Scaffold(
      appBar: CommonHelper().appbarCommon('PayTabs', context, () {
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
                ..loadRequest(Uri.parse(url ?? ''))
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..setNavigationDelegate(NavigationDelegate(
                  onProgress: (int progress) {
                    // Update loading bar.
                  },
                  onPageStarted: (value) async {
                    if (!value.contains('result')) {
                      return;
                    }
                    bool paySuccess = await verifyPayment(value);

                    if (paySuccess) {
                      if (isFromOrderExtraAccept == true) {
                        await Provider.of<OrderDetailsService>(context,
                                listen: false)
                            .acceptOrderExtra(context);
                      } else if (isFromWalletDeposite) {
                        await Provider.of<WalletService>(context, listen: false)
                            .makeDepositeToWalletSuccess(context);
                      } else if (isFromHireJob) {
                        Provider.of<JobRequestService>(context, listen: false)
                            .goToJobSuccessPage(context);
                      } else {
                        await Provider.of<PlaceOrderService>(context,
                                listen: false)
                            .makePaymentSuccess(context);
                      }
                      return;
                    }
                    await Provider.of<PlaceOrderService>(context, listen: false)
                        .doNext(context, 'failed', paymentFailed: true);
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
                    await Provider.of<PlaceOrderService>(context, listen: false)
                        .doNext(context, 'failed', paymentFailed: true);
                  },
                ));
              return WebViewWidget(
                controller: _controller,
              );
            }),
      ),
    );
  }

  waitForIt(BuildContext context) async {
    // String profileId =
    //     Provider.of<PaymentGatewayListService>(context, listen: false)
    //         .paytabProfileId;
    String secretKey =
        Provider.of<PaymentGatewayListService>(context, listen: false)
            .secretKey;
    final currencyCode =
        Provider.of<RtlService>(context, listen: false).currencyCode;

    final url = Uri.parse('https://secure-global.paytabs.com/payment/request');
    final header = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": secretKey,
      // Above is API server key for the Midtrans account, encoded to base64
    };

    final response = await http.post(url,
        headers: header,
        body: jsonEncode({
          "profile_id": 96698,
          "tran_type": "sale",
          "tran_class": "ecom",
          "cart_id": orderId.toString(),
          "cart_description": "Qixer payment",
          "cart_currency": currencyCode,
          "cart_amount": amount,
        }));
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      this.url = jsonDecode(response.body)['redirect_url'];
      return;
    }

    return true;
  }

  Future<bool> verifyPayment(String url) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    return response.body.contains('successful');
  }
}
