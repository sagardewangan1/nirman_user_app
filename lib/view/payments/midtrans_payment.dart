// ignore_for_file: prefer_typing_uninitialized_variables

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

class MidtransPayment extends StatelessWidget {
  MidtransPayment(
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

  String? url;

  final WebViewController _controller = WebViewController();
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(microseconds: 600), () {
      Provider.of<PlaceOrderService>(context, listen: false).setLoadingFalse();
    });

    return Scaffold(
      appBar: CommonHelper().appbarCommon('Midtrans', context, () {
        Provider.of<PlaceOrderService>(context, listen: false)
            .doNext(context, 'failed', paymentFailed: true);
      }),
      body: WillPopScope(
        onWillPop: () async {
          await Provider.of<PlaceOrderService>(context, listen: false)
              .doNext(context, 'failed', paymentFailed: true);
          return true;
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
                  onPageStarted: (String url) {},
                  onPageFinished: (value) async {
                    if (value.contains('success')) {
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
    final url =
        Uri.parse('https://app.sandbox.midtrans.com/snap/v1/transactions');

    final clientKey =
        Provider.of<PaymentGatewayListService>(context, listen: false)
                .publicKey ??
            '';
    final serverKey =
        Provider.of<PaymentGatewayListService>(context, listen: false)
                .secretKey ??
            '';
    final currencyCode =
        Provider.of<RtlService>(context, listen: false).currencyCode;

    final basicAuth =
        'Basic ${base64Encode(utf8.encode('$serverKey:$clientKey'))}';
    final header = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": basicAuth,
      // Above is API server key for the Midtrans account, encoded to base64
    };
    final response = await http.post(url,
        headers: header,
        body: jsonEncode({
          "transaction_details": {
            "order_id": DateTime.now().toString(),
            "gross_amount": amount,
            'currency': currencyCode
          },
          "credit_card": {"secure": true},
          "customer_details": {
            "first_name": name,
            "email": email,
            "phone": phone,
          }
        }));
    debugPrint(response.body.toString());
    if (response.statusCode == 201) {
      this.url = jsonDecode(response.body)['redirect_url'];
      return;
    }

    return true;
  }
}
