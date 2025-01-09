// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/service/booking_services/place_order_service.dart';
import 'package:qixer/service/payment_gateway_list_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../service/rtl_service.dart';
import '../utils/common_helper.dart';
import '../utils/constant_colors.dart';
import '../utils/others_helper.dart';

class SquareUpPayment extends StatelessWidget {
  SquareUpPayment(
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
      appBar: CommonHelper().appbarCommon('SquareUp', context, () {
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

  Future waitForIt(BuildContext context) async {
    final secretKey =
        Provider.of<PaymentGatewayListService>(context, listen: false)
            .secretKey;

    final locationId =
        Provider.of<PaymentGatewayListService>(context, listen: false)
            .squareLocationId;
    final currencyCode =
        Provider.of<RtlService>(context, listen: false).currencyCode;

    // const secretKey =
    //     'EAAAEDsGeASjEG2t6YD1XqJxdyMXEJMS9m50rukk07akibxyMeCTjV2UHwdIsTtl';
    // const locationId = 'LP6DRN3R0SBRF';

    // String orderId =
    //     Provider.of<PlaceOrderService>(context, listen: false).orderId;

    final url = Uri.parse(
        'https://connect.squareupsandbox.com/v2/online-checkout/payment-links');
    final header = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": 'Bearer $secretKey',
    };

    final response = await http.post(url,
        headers: header,
        body: jsonEncode({
          "description": "Qixer payment",
          "idempotency_key": DateTime.now().toString(),
          "quick_pay": {
            "location_id": locationId,
            "name": "Qixer payment",
            "price_money": {"amount": amount, "currency": currencyCode}
          },
          "payment_note": "Qixer payment",
          "redirect_url": "https://xgenious.com/",
          "pre_populated_data": {"buyer_email": email}
        }));
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      this.url = jsonDecode(response.body)['payment_link']['url'];
      return url;
    }

    return true;
  }

  Future<bool> verifyPayment(String url) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    return response.body.contains('successful');
  }
}
