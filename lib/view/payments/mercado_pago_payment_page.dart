// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:webview_flutter/webview_flutter.dart';

import '../../service/book_confirmation_service.dart';
import '../../service/booking_services/book_service.dart';
import '../../service/booking_services/personalization_service.dart';
import '../../service/booking_services/place_order_service.dart';
import '../../service/jobs_service/job_request_service.dart';
import '../../service/order_details_service.dart';
import '../../service/payment_gateway_list_service.dart';
import '../../service/profile_service.dart';
import '../../service/rtl_service.dart';
import '../../service/wallet_service.dart';
import '../utils/common_helper.dart';
import '../utils/constant_colors.dart';
import '../utils/others_helper.dart';

class MercadopagoPaymentPage extends StatefulWidget {
  const MercadopagoPaymentPage({
    super.key,
    required this.isFromOrderExtraAccept,
    required this.isFromWalletDeposite,
    required this.isFromHireJob,
  });

  final bool isFromOrderExtraAccept;
  final bool isFromWalletDeposite;
  final bool isFromHireJob;

  @override
  State<MercadopagoPaymentPage> createState() => _MercadopagoPaymentPageState();
}

class _MercadopagoPaymentPageState extends State<MercadopagoPaymentPage> {
  @override
  void initState() {
    super.initState();
  }

  late String url;

  final WebViewController _controller = WebViewController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonHelper().appbarCommon('Mercado pago', context, () {
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
            future: getPaymentUrl(context),
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
                ..setNavigationDelegate(
                  NavigationDelegate(
                    onProgress: (int progress) {
                      // Update loading bar.
                    },
                    onPageStarted: (String url) {},
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
                      if (request.url.contains("https://www.success.com/")) {
                        if (widget.isFromOrderExtraAccept == true) {
                          await Provider.of<OrderDetailsService>(context,
                                  listen: false)
                              .acceptOrderExtra(context);
                        } else if (widget.isFromWalletDeposite) {
                          await Provider.of<WalletService>(context,
                                  listen: false)
                              .makeDepositeToWalletSuccess(context);
                        } else if (widget.isFromHireJob) {
                          Provider.of<JobRequestService>(context, listen: false)
                              .goToJobSuccessPage(context);
                        } else {
                          await Provider.of<PlaceOrderService>(context,
                                  listen: false)
                              .makePaymentSuccess(context);
                        }
                        return NavigationDecision.prevent;
                      }
                      if (request.url.contains("https://www.failed.com")) {
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

  Future<dynamic> getPaymentUrl(BuildContext context) async {
    var amount;

    String orderId;
    String email;
    email = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .email ??
        'test@test.com';

    if (widget.isFromOrderExtraAccept == true) {
      amount = Provider.of<OrderDetailsService>(context, listen: false)
          .selectedExtraPrice;
      amount = double.parse(amount);

      orderId = Provider.of<OrderDetailsService>(context, listen: false)
          .selectedExtraId
          .toString();
    } else if (widget.isFromWalletDeposite) {
      amount = Provider.of<WalletService>(context, listen: false).amountToAdd;
      amount = double.parse(amount);
      orderId = DateTime.now().toString();
    } else if (widget.isFromHireJob) {
      amount = Provider.of<JobRequestService>(context, listen: false)
          .selectedJobPrice;
      amount = double.parse(amount);
      orderId = DateTime.now().toString();
    } else {
      var bcProvider =
          Provider.of<BookConfirmationService>(context, listen: false);
      var pProvider =
          Provider.of<PersonalizationService>(context, listen: false);
      var bookProvider = Provider.of<BookService>(context, listen: false);

      if (pProvider.isOnline == 0) {
        amount = bcProvider.totalPriceAfterAllcalculation.toStringAsFixed(2);
      } else {
        amount = bcProvider.totalPriceOnlineServiceAfterAllCalculation;
      }
      orderId = Provider.of<PlaceOrderService>(context, listen: false).orderId;

      email = bookProvider.email ?? '';
    }

    String mercadoKey =
        Provider.of<PaymentGatewayListService>(context, listen: false)
                .secretKey ??
            '';
    final currencyCode =
        Provider.of<RtlService>(context, listen: false).currencyCode;

    var header = {
      "Accept": "application/json",
      "Content-Type": "application/json"
    };

    var data = jsonEncode({
      "items": [
        {
          "title": "Shashakt Nirman",
          "description": "Shashakt Nirman payment",
          "quantity": 1,
          "currency_id": currencyCode,
          "unit_price": amount
        }
      ],
      'back_urls': {
        "success": 'https://www.google.com/',
        "failure": 'https://www.facebook.com',
        "pending": 'https://www.facebook.com'
      },
      'auto_return': 'approved',
      "payer": {"email": email}
    });

    var response = await http.post(
        Uri.parse(
            'https://api.mercadopago.com/checkout/preferences?access_token=$mercadoKey'),
        headers: header,
        body: data);

    debugPrint(response.body.toString());

    // debugPrint(response.body.toString());
    if (response.statusCode == 201) {
      url = jsonDecode(response.body)['init_point'];

      return;
    }
    return '';
  }
}
