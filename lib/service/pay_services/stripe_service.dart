// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
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
import 'package:qixer/service/rtl_service.dart';
import 'package:qixer/service/wallet_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StripeService with ChangeNotifier {
  bool isloading = false;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  Map<String, dynamic>? paymentIntentData;

  displayPaymentSheet(BuildContext context, isFromOrderExtraAccept,
      isFromWalletDeposite, isFromHireJob) async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              //         parameters: PresentPaymentSheetParameters(
              //   clientSecret: paymentIntentData!['client_secret'],
              //   confirmPayment: true,
              // )
              )
          .then((newValue) async {
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
        //payment successs ================>

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        Provider.of<PlaceOrderService>(context, listen: false)
            .doNext(context, 'failed', paymentFailed: true);
        debugPrint('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException {
      Provider.of<PlaceOrderService>(context, listen: false)
          .doNext(context, 'failed', paymentFailed: true);
      OthersHelper().showToast("Payment cancelled", Colors.red);
    } catch (e) {
      Provider.of<PlaceOrderService>(context, listen: false)
          .doNext(context, 'failed', paymentFailed: true);
      debugPrint('$e');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
    // return amount;
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency, context) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      // var header ={
      //       'Authorization':
      //           'Bearer sk_test_51GwS1SEmGOuJLTMs2vhSliTwAGkOt4fKJMBrxzTXeCJoLrRu8HFf4I0C5QuyE3l3bQHBJm3c0qFmeVjd0V9nFb6Z00VrWDJ9Uw',
      //       'Content-Type': 'application/x-www-form-urlencoded'
      //     };
      var header = {
        'Authorization':
            'Bearer ${Provider.of<PaymentGatewayListService>(context, listen: false).secretKey}',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: header);
      // debugPrint("response body is ${response.body}");
      return jsonDecode(response.body);
    } catch (err) {
      Provider.of<PlaceOrderService>(context, listen: false)
          .doNext(context, 'failed', paymentFailed: true);
      debugPrint('err charging user: ${err.toString()}');
    }
  }

  Future<void> makePayment(BuildContext context,
      {bool isFromOrderExtraAccept = false,
      bool isFromWalletDeposite = false,
      bool isFromHireJob = false}) async {
    var amount;
    var publishableKey = await StripeService().getStripeKey();
    Stripe.publishableKey = publishableKey;
    Stripe.instance.applySettings();
    String name;
    String phone;
    String email;
    Provider.of<PlaceOrderService>(context, listen: false).setLoadingTrue();
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
    } else if (isFromWalletDeposite) {
      amount = Provider.of<WalletService>(context, listen: false).amountToAdd;
      amount = double.parse(amount).toStringAsFixed(0);
    } else if (isFromHireJob) {
      amount = Provider.of<JobRequestService>(context, listen: false)
          .selectedJobPrice;

      amount = double.parse(amount).toStringAsFixed(0);
    } else {
      var bcProvider =
          Provider.of<BookConfirmationService>(context, listen: false);
      var pProvider =
          Provider.of<PersonalizationService>(context, listen: false);
      var bookProvider = Provider.of<BookService>(context, listen: false);

      name = bookProvider.name ?? '';
      if (pProvider.isOnline == 0) {
        amount = bcProvider.totalPriceAfterAllcalculation.toStringAsFixed(0);
      } else {
        amount = bcProvider.totalPriceOnlineServiceAfterAllCalculation
            .toStringAsFixed(0);
      }
    }

    //Stripe takes only integer value

    try {
      final currencyCode =
          Provider.of<RtlService>(context, listen: false).currencyCode;
      paymentIntentData =
          await createPaymentIntent(amount, currencyCode, context);
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  // applePay: true,
                  // googlePay: true,
                  // testEnv: true,
                  style: ThemeMode.light,
                  // merchantCountryCode: 'US',
                  merchantDisplayName: name))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet(
          context, isFromOrderExtraAccept, isFromWalletDeposite, isFromHireJob);
    } catch (e, s) {
      Provider.of<PlaceOrderService>(context, listen: false)
          .doNext(context, 'failed', paymentFailed: true);
      debugPrint('exception:$e$s');
    }
  }

  //get stripe key ==========>

  Future<String> getStripeKey() async {
    var defaultPublicKey =
        'pk_test_51GwS1SEmGOuJLTMsIeYKFtfAT3o3Fc6IOC7wyFmmxA2FIFQ3ZigJ2z1s4ZOweKQKlhaQr1blTH9y6HR2PMjtq1Rx00vqE8LO0x';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var response = await http
        .post(Uri.parse('$baseApi/user/payment-gateway-list'), headers: header);
    if (response.statusCode == 201) {
      var paymentList = jsonDecode(response.body)['gateway_list'];
      var publicKey;

      for (int i = 0; i < paymentList.length; i++) {
        if (paymentList[i]['name'] == 'stripe') {
          publicKey = paymentList[i]['public_key'];
        }
      }
      if (publicKey == null) {
        return defaultPublicKey;
      } else {
        return publicKey;
      }
    } else {
      //failed loading
      return defaultPublicKey;
    }
  }
}
