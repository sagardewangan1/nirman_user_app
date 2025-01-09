import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/service/book_confirmation_service.dart';
import 'package:qixer/service/booking_services/book_service.dart';
import 'package:qixer/service/booking_services/personalization_service.dart';
import 'package:qixer/service/booking_services/place_order_service.dart';
import 'package:qixer/service/jobs_service/job_request_service.dart';
import 'package:qixer/service/order_details_service.dart';
import 'package:qixer/service/payment_gateway_list_service.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/service/wallet_service.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../service/rtl_service.dart';
import '../utils/common_helper.dart';
import '../utils/others_helper.dart';

class PaystackPaymentPage extends StatelessWidget {
  PaystackPaymentPage(
      {super.key,
      required this.isFromOrderExtraAccept,
      required this.isFromWalletDeposite,
      required this.isFromHireJob});

  String? url;

  final WebViewController _controller = WebViewController();
  final isFromOrderExtraAccept;
  final isFromWalletDeposite;
  final isFromHireJob;

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(microseconds: 600), () {
      Provider.of<PlaceOrderService>(context, listen: false).setLoadingFalse();
    });
    ConstantColors cc = ConstantColors();

    return Scaffold(
      appBar: CommonHelper().appbarCommon('Paystack', context, () {
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
            future: waitForIt(context, isFromOrderExtraAccept,
                isFromWalletDeposite, isFromHireJob),
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
                  onPageFinished: (value) async {
                    // final title = await _controller.currentUrl();
                    final uri = Uri.parse(value);
                    final response = await http.get(uri);
                    // if (response.body.contains('PAYMENT ID')) {

                    if (response.body.contains('Payment Successful')) {
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

                      return;
                    }
                    if (response.body.contains('Declined')) {}
                  },
                  onNavigationRequest: (navRequest) async {
                    if (navRequest.url.contains('success')) {
                      if (isFromOrderExtraAccept == true) {
                        await Provider.of<OrderDetailsService>(context,
                                listen: false)
                            .acceptOrderExtra(context);
                      } else if (isFromWalletDeposite) {
                        Provider.of<WalletService>(context, listen: false)
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
                    if (navRequest.url.contains('failed')) {
                      Provider.of<PlaceOrderService>(context, listen: false)
                          .doNext(context, 'failed', paymentFailed: true);
                    }
                    return NavigationDecision.navigate;
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

  Future<void> waitForIt(BuildContext context, isFromOrderExtraAccept,
      isFromWalletDeposite, isFromHireJob) async {
    final uri = Uri.parse('https://api.paystack.co/transaction/initialize');

    String paystackSecretKey =
        Provider.of<PaymentGatewayListService>(context, listen: false)
                .secretKey ??
            '';

    var amount;

    String name;
    String phone;
    String email;
    String orderId;
    name = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .name ??
        'test';
    phone = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .phone ??
        '111111111';
    email = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .email ??
        'test@test.com';

    if (isFromOrderExtraAccept == true) {
      amount = Provider.of<OrderDetailsService>(context, listen: false)
          .selectedExtraPrice;

      amount = double.parse(amount).toStringAsFixed(0);
      amount = int.parse(amount);

      orderId = Provider.of<OrderDetailsService>(context, listen: false)
          .selectedExtraId
          .toString();
    } else if (isFromWalletDeposite) {
      amount = Provider.of<WalletService>(context, listen: false).amountToAdd;
      amount = double.parse(amount).toStringAsFixed(0);
      amount = int.parse(amount);

      orderId = DateTime.now().toString();
    } else if (isFromHireJob) {
      amount = Provider.of<JobRequestService>(context, listen: false)
          .selectedJobPrice;
      amount = double.parse(amount).toStringAsFixed(0);
      amount = int.parse(amount);

      orderId = DateTime.now().toString();
    } else {
      var bcProvider =
          Provider.of<BookConfirmationService>(context, listen: false);
      var pProvider =
          Provider.of<PersonalizationService>(context, listen: false);
      var bookProvider = Provider.of<BookService>(context, listen: false);

      if (pProvider.isOnline == 0) {
        amount = bcProvider.totalPriceAfterAllcalculation.toStringAsFixed(0);
        amount = int.parse(amount);
      } else {
        amount = bcProvider.totalPriceOnlineServiceAfterAllCalculation
            .toStringAsFixed(0);
        amount = int.parse(amount);
      }

      orderId = Provider.of<PlaceOrderService>(context, listen: false).orderId;

      email = bookProvider.email ?? '';
    }

    final header = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $paystackSecretKey",
      // Above is API server key for the Midtrans account, encoded to base64
    };
    final currencyCode =
        Provider.of<RtlService>(context, listen: false).currencyCode;

    // final orderId = Random().nextInt(23000).toInt();
    final response = await http.post(uri,
        headers: header,
        body: jsonEncode({
          "amount": amount * 100,
          "currency": currencyCode,
          "email": email,
          "reference_id": orderId.toString(),
          "callback_url": "http://success.com",
          "metadata": {"cancel_action": "http://failed.com"}
        }));
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      url = jsonDecode(response.body)['data']['authorization_url'];
      return;
    }

    // if (response.statusCode == 201) {
    // this.url =
    //     'https://sandbox.payfast.co.za/eng/process?merchant_id=${selectedGateaway.merchantId}&merchant_key=${selectedGateaway.merchantKey}&amount=$amount&item_name=GrenmartGroceries';
    // //   return;
    // // }

    // return true;
  }

  Future<bool> verifyPayment(String url) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    return response.body.contains('Payment Completed');
  }
}
