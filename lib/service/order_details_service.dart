// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/model/order_details_model.dart';
import 'package:qixer/model/order_extra_model.dart';
import 'package:qixer/service/booking_services/place_order_service.dart';
import 'package:qixer/service/orders_service.dart';
import 'package:qixer/service/payment_gateway_list_service.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/service/push_notification_service.dart';
import 'package:qixer/view/booking/components/order_extra_accept_success_page.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common_service.dart';

class OrderDetailsService with ChangeNotifier {
  var orderDetails;

  var orderStatus;

  List orderExtra = [];

  bool isLoading = true;

  setLoadingStatus(bool status) {
    isLoading = status;
    notifyListeners();
  }

  Future<bool> fetchOrderDetails(orderId, BuildContext context,
      {bool isFromOrderComplete = false}) async {
    //get user id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var connection = await checkConnection();
    if (!connection) return false;
    //if connection is ok

    if (!isFromOrderComplete) {
      //if it is from order complete accept, then no need to show loading
      //because it is causing some issue

      setLoadingStatus(true);
    }

    var response = await http
        .post(Uri.parse('$baseApi/user/my-orders/$orderId'), headers: header);

    if (response.statusCode == 201) {
      var data = OrderDetailsModel.fromJson(jsonDecode(response.body));

      orderDetails = data.orderInfo;

      var status = data.orderInfo.status;

      orderStatus = getOrderStatus(status ?? -1);

      await fetchOrderExtraList(orderId);

      Provider.of<OrdersService>(context, listen: false)
          .fetchDeclineHistory(context, orderId: orderId);

      notifyListeners();
      return true;
    } else {
      //Something went wrong
      orderDetails = 'error';
      notifyListeners();
      return false;
    }
  }

  //fetch order extra list
  Future<bool> fetchOrderExtraList(orderId) async {
    //get user id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var connection = await checkConnection();
    if (!connection) return false;

    //if connection is ok
    var response = await http.get(
        Uri.parse('$baseApi/user/order/extra-service/list/$orderId'),
        headers: header);

    final decodedData = jsonDecode(response.body);

    setLoadingStatus(false);

    if (response.statusCode == 201 &&
        decodedData.containsKey('extra_service_list')) {
      var data = OrderExtraModel.fromJson(decodedData);

      orderExtra = data.extraServiceList;

      notifyListeners();

      return true;
    } else {
      return false;
    }
  }

  var selectedExtraId;
  var selectedOrderIdForExtra;
  var selectedExtraPrice;
  var selectedExtraSellerId;

  setExtraDetails(
      {required orderId,
      required extraId,
      required extraPrice,
      required sellerId}) {
    selectedOrderIdForExtra = orderId;
    selectedExtraId = extraId.toString();
    selectedExtraPrice = extraPrice.toString();
    selectedExtraSellerId = sellerId;
    notifyListeners();
  }

  //============>
  Future<bool> acceptOrderExtra(BuildContext context,
      {bool manualPaymentSelected = false, imagePath}) async {
    //get user id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var connection = await checkConnection();
    if (!connection) return false;
    //if connection is ok

    var selectedPayment =
        Provider.of<PaymentGatewayListService>(context, listen: false)
                .selectedMethodName ??
            'cash_on_delivery';

    FormData formData;
    var dio = Dio();
    dio.options.headers['Content-Type'] = 'multipart/form-data';
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = "Bearer $token";

    if (manualPaymentSelected == true) {
      formData = FormData.fromMap({
        'id': selectedExtraId,
        'order_id': selectedOrderIdForExtra,
        'selected_payment_gateway': selectedPayment,
        'manual_payment_image': await MultipartFile.fromFile(imagePath,
            filename: 'bankTransfer.jpg'),
      });
    } else {
      formData = FormData.fromMap({
        'id': selectedExtraId,
        'order_id': selectedOrderIdForExtra,
        'selected_payment_gateway': selectedPayment,
      });
    }

    var response = await dio.post(
      '$baseApi/user/order/extra-service/accept',
      data: formData,
      options: Options(
        validateStatus: (status) {
          return true;
        },
      ),
    );

    setLoadingStatus(false);

    if (response.statusCode == 200) {
      await fetchOrderDetails(selectedOrderIdForExtra, context);

      Navigator.pop(context);
      Provider.of<PlaceOrderService>(context, listen: false).setLoadingFalse();

      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) =>
              const OrderExtraAcceptSuccessPage(),
        ),
      );

      //Send notification to seller
      var sellerId = Provider.of<OrderDetailsService>(context, listen: false)
          .selectedExtraSellerId;
      var username = Provider.of<ProfileService>(context, listen: false)
              .profileDetails
              .userDetails
              .name ??
          '';
      var orderId = Provider.of<OrderDetailsService>(context, listen: false)
          .orderDetails
          .id;
      PushNotificationService().sendNotificationToSeller(context,
          sellerId: sellerId,
          title: "$username " +
              lnProvider.getString("accepted your order extra request"),
          body: lnProvider.getString("Order Id") + ': $orderId');

      return true;
    } else {
      Navigator.pop(context);
      Provider.of<PlaceOrderService>(context, listen: false).setLoadingFalse();

      OthersHelper().showToast('Error accepting order extra', Colors.black);
      return false;
    }
  }

  //==============>

  declineOrderExtra(BuildContext context,
      {required extraId, required orderId}) async {
    //get user id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var connection = await checkConnection();
    if (connection) {
      //if connection is ok

      setLoadingStatus(true);

      var data = jsonEncode({'id': extraId, 'order_id': orderId});

      var response = await http.post(
          Uri.parse('$baseApi/user/order/extra-service/decline'),
          headers: header,
          body: data);

      if (response.statusCode == 201) {
        await fetchOrderDetails(orderId, context);
        setLoadingStatus(false);
        var sellerId = Provider.of<OrderDetailsService>(context, listen: false)
            .orderDetails
            .sellerDetails
            .id;
        var username = Provider.of<ProfileService>(context, listen: false)
                .profileDetails
                .userDetails
                .name ??
            '';
        PushNotificationService().sendNotificationToSeller(context,
            sellerId: sellerId,
            title: "$username " +
                lnProvider.getString("declined your order extra request"),
            body: lnProvider.getString("Order Id") + ': $orderId');
        Navigator.pop(context);

        notifyListeners();
      } else {
        setLoadingStatus(false);
        OthersHelper().showToast('Error declining order extra', Colors.black);
      }
    }
  }

  //=========>

  getOrderStatus(status) {
    if (status == 0) {
      return 'Pending';
    } else if (status == 1) {
      return 'Active';
    } else if (status == 2) {
      return "Completed";
    } else if (status == 3) {
      return "Delivered";
    } else if (status == 4) {
      return 'Cancelled';
    } else {
      return 'Unknown';
    }
  }
}
