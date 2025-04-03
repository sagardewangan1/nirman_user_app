// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/book_confirmation_service.dart';
import 'package:qixer/service/book_steps_service.dart';
import 'package:qixer/service/booking_services/book_service.dart';
import 'package:qixer/service/booking_services/coupon_service.dart';
import 'package:qixer/service/booking_services/personalization_service.dart';
import 'package:qixer/service/dropdowns_services/area_dropdown_service.dart';
import 'package:qixer/service/dropdowns_services/country_dropdown_service.dart';
import 'package:qixer/service/dropdowns_services/state_dropdown_services.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/service/push_notification_service.dart';
import 'package:qixer/view/booking/payment_success_page.dart';
import 'package:qixer/view/home/landing_page.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../view/utils/common_helper.dart';
import '../common_service.dart';

class PlaceOrderService with ChangeNotifier {
  bool isloading = false;

  var orderId;
  var successUrl;
  var cancelUrl;

  var paytmHtmlForm;

  setOrderId(v) {
    orderId = v;
    notifyListeners();
  }

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  Future<bool> placeOrder(BuildContext context, String? imagePath,
      {bool isManualOrCod = false, bool paytmPaymentSelected = false}) async {
    setLoadingTrue();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');

    List includesList = [];
    List extrasList = [];
    var total;
    var subtotal;

    List includes = Provider.of<PersonalizationService>(context, listen: false)
        .includedList;
    List extras =
        Provider.of<PersonalizationService>(context, listen: false).extrasList;
    final bProvider = Provider.of<BookService>(context, listen: false);
    var serviceId = bProvider.serviceId;
    var sellerId = bProvider.sellerId;
    var buyerId = prefs.getInt('userId');
    var name = bProvider.name;
    var email = bProvider.email;
    var phone = bProvider.phone;
    var post = bProvider.postCode;
    var address = bProvider.address;
    var city = Provider.of<StateDropdownService>(context, listen: false)
        .selectedStateId;
    var area =
        Provider.of<AreaDropdownService>(context, listen: false).selectedAreaId;
    var country = Provider.of<CountryDropdownService>(context, listen: false)
        .selectedCountryId;
    var selectedDate;
    var schedule = bProvider.selectedTime;
    var coupon =
        Provider.of<CouponService>(context, listen: false).appliedCoupon;
    var selectedPaymentGateway = bProvider.selectedPayment;

    var isOnline =
        Provider.of<PersonalizationService>(context, listen: false).isOnline;

    if (isOnline == 0) {
      selectedDate = DateFormat.yMMMMEEEEd().format(bProvider.selectedDate!);
      total = Provider.of<BookConfirmationService>(context, listen: false)
              .totalPriceAfterAllcalculation -
          Provider.of<BookConfirmationService>(context, listen: false).taxPrice;
      subtotal = Provider.of<BookConfirmationService>(context, listen: false)
          .subTotalAfterAllCalculation;
    } else {
      total = Provider.of<BookConfirmationService>(context, listen: false)
              .totalPriceOnlineServiceAfterAllCalculation -
          Provider.of<BookConfirmationService>(context, listen: false).taxPrice;
      subtotal = Provider.of<BookConfirmationService>(context, listen: false)
          .subTotalOnlineServiceAfterAllCalculation;
    }

    //includes list
    for (int i = 0; i < includes.length; i++) {
      includesList.add({
        'order_id': "1",
        "title": includes[i]['title'],
        "price": includes[i]['price'],
        "quantity": includes[i]['qty']
      });
    }

    //extras list
    for (int i = 0; i < extras.length; i++) {
      if (extras[i]['selected'] == true) {
        extrasList.add({
          'order_id': "1",
          "additional_service_title": extras[i]['title'],
          "additional_service_price": extras[i]['price'],
          "quantity": extras[i]['qty']
        });
      }
    }

    var formData;
    var dio = Dio();
    dio.options.headers['Content-Type'] = 'multipart/form-data';
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = "Bearer $token";

    if (isOnline == 0) {
      //if it's not online service
      if (imagePath != null) {
        //if manual transfer selected then image upload is mandatory
        formData = FormData.fromMap({
          'service_id': serviceId.toString(),
          'seller_id': sellerId.toString(),
          'buyer_id': buyerId.toString(),
          'name': name,
          'email': email,
          'phone': phone, //amount he paid in bkash ucash etc
          'post_code': post,
          'address': address,
          'choose_service_city': city.toString(),
          'choose_service_area': area.toString(),
          'choose_service_country': country.toString(),
          'date': selectedDate.toString(),
          'schedule': schedule.toString(),
          'include_services': jsonEncode({"include_services": includesList}),
          'additional_services':
              jsonEncode({"additional_services": extrasList}),
          'coupon_code': coupon.toString(),
          'selected_payment_gateway': selectedPaymentGateway.toString(),
          'manual_payment_image': await MultipartFile.fromFile(imagePath,
              filename: 'bankTransfer$name$address$imagePath.jpg'),
          'is_service_online': 0,
        });
      } else {
        //other payment method selected
        formData = FormData.fromMap({
          'service_id': serviceId.toString(),
          'seller_id': sellerId.toString(),
          'buyer_id': buyerId.toString(),
          'name': name,
          'email': email,
          'phone': phone, //amount he paid in bkash ucash etc
          'post_code': post,
          'address': address,
          'choose_service_city': city.toString(),
          'choose_service_area': area.toString(),
          'choose_service_country': country.toString(),
          'date': selectedDate.toString(),
          'schedule': schedule.toString(),
          'include_services': jsonEncode({"include_services": includesList}),
          'additional_services':
              jsonEncode({"additional_services": extrasList}),
          'coupon_code': coupon.toString(),
          'selected_payment_gateway': selectedPaymentGateway.toString(),
          'is_service_online': 0,
        });
      }
    } else {
      //else it is online service. so, some fields will not be given to api
      if (imagePath != null) {
        //if manual transfer selected then image upload is mandatory
        formData = FormData.fromMap({
          'service_id': serviceId.toString(),
          'seller_id': sellerId.toString(),
          'buyer_id': buyerId.toString(),
          'name': name,
          'email': email,
          'phone': phone,
          'additional_services':
              jsonEncode({"additional_services": extrasList}),
          'coupon_code': coupon.toString(),
          'selected_payment_gateway': selectedPaymentGateway.toString(),
          'manual_payment_image': await MultipartFile.fromFile(imagePath,
              filename: 'bankTransfer$name$address$imagePath.jpg'),
          'is_service_online': '1',
        });
      } else {
        //other payment method selected
        formData = FormData.fromMap({
          'service_id': serviceId.toString(),
          'seller_id': sellerId.toString(),
          'buyer_id': buyerId.toString(),
          'name': name,
          'email': email,
          'phone': phone, //amount he paid in bkash ucash etc
          'additional_services':
              jsonEncode({"additional_services": extrasList}),
          'coupon_code': coupon.toString(),
          'selected_payment_gateway': selectedPaymentGateway.toString(),
          'is_service_online': '1',
        });
      }
    }

    //For paytm
    //=============>
    var data = jsonEncode({
      'service_id': serviceId.toString(),
      'seller_id': sellerId.toString(),
      'buyer_id': buyerId.toString(),
      'name': name,
      'email': email,
      'phone': phone, //amount he paid in bkash ucash etc
      'post_code': post,
      'address': address,
      'choose_service_city': city,
      'choose_service_area': area,
      'choose_service_country': country,
      'date': selectedDate.toString(),
      'schedule': schedule.toString(),
      'include_services': jsonEncode({"include_services": includesList}),
      'additional_services': jsonEncode({"additional_services": extrasList}),
      'coupon_code': coupon.toString(),
      'selected_payment_gateway': selectedPaymentGateway.toString(),
      'is_service_online': 0,
      'paytm': true
    });

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var response = await dio.post('$baseApi/service/order', data: formData,
        options: Options(
      validateStatus: (status) {
        return true;
      },
    ));

    //if paytm payment selected
    // =================>

    if (paytmPaymentSelected == true) {
      var paytmRes = await http.post(Uri.parse('$baseApi/service/order-paytm'),
          headers: header, body: data);

      paytmHtmlForm = paytmRes.body;
      notifyListeners();
    }

    if (response.statusCode == 201) {
      orderId = response.data['order_id'];
      successUrl = response.data['success_url'];
      cancelUrl = response.data['cancel_url'];

      notifyListeners();

      if (isManualOrCod == true) {
        //if user placed order in manual transfer or cash on delivery then no need to hit the api- make payment success
        //because in this case payment needs to stay pending anyway.
        doNext(context, 'Pending');
        setLoadingFalse();
      }
      return true;
    } else {
      setLoadingFalse();

      OthersHelper().showToast('Something went wrong', Colors.black);
      return false;
    }
  }

  //make payment successfull
  makePaymentSuccess(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');

    var connection = await checkConnection();

    if (connection) {
      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      var data = jsonEncode({
        'order_id': orderId,
      });

      var response = await http.post(
          Uri.parse('$baseApi/user/payment-status-update'),
          headers: header,
          body: data);
      setLoadingFalse();
      if (response.statusCode == 201 || response.statusCode == 404) {
        OthersHelper().showToast('Order placed successfully', Colors.black);
        doNext(context, 'Complete');
      } else {
        debugPrint(response.body.toString());
        OthersHelper().showToast(
            'Failed to make payment status successful', Colors.black);
        doNext(context, 'Pending');
      }
    } else {
      OthersHelper().showToast(
          'Check your internet connection and try again', Colors.black);
    }
  }

  ///////////==========>
  doNext(BuildContext context, String paymentStatus,
      {paymentFailed = false}) async {
    //Refresh profile page so that user can see updated total orders
    if (paymentFailed) {
      showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  title: Text(lnProvider.getString('')),
                  content: SizedBox(
                    height: 136,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/payment_failed.png',
                          height: 100,
                        ),
                        const SizedBox(height: 12),
                        Text(lnProvider.getString('Payment failed!')),
                      ],
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: CommonHelper().borderButtonOrange(
                          lnProvider.getString('Go to home'), () {
                        Navigator.pop(context);
                      }),
                    )
                  ],
                );
              })
          .then((value) => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LandingPage()),
              (Route<dynamic> route) => false));
      setLoadingFalse();
    } else {
      await Provider.of<ProfileService>(context, listen: false)
          .getProfileDetails(isFromProfileupdatePage: true, context: context);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LandingPage()),
          (Route<dynamic> route) => false);

      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => PaymentSuccessPage(
            paymentStatus: paymentStatus,
          ),
        ),
      );
    }

    //reset steps
    Provider.of<BookStepsService>(context, listen: false).setStepsToDefault();

    //Send notification to seller
    var sellerId = Provider.of<BookService>(context, listen: false).sellerId;
    var username = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            ?.name ??
        '';
    PushNotificationService().sendNotificationToSeller(context,
        sellerId: sellerId,
        title: lnProvider.getString("You have received an order from") +
            " $username",
        body: lnProvider.getString('Order id') + ': $orderId');
  }
}
