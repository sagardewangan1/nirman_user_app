import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/my_orders_service.dart';
import 'package:qixer/service/order_details_service.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/service/push_notification_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersService with ChangeNotifier {
  bool markLoading = false;

  setMarkLoadingStatus(bool status) {
    markLoading = status;
    notifyListeners();
  }

//==========>
//=======>
  completeOrder(BuildContext context, {required orderId}) async {
    //get user id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var connection = await checkConnection();
    if (!connection) return;

    setMarkLoadingStatus(true);

    var data = jsonEncode({'order_id': orderId});

    var response = await http.post(
        Uri.parse('$baseApi/user/order/request/status/complete/approve'),
        headers: header,
        body: data);

    final decodedData = jsonDecode(response.body);

    if (response.statusCode == 201) {
      OthersHelper().showToast(decodedData['msg'], Colors.black);

      await Provider.of<OrderDetailsService>(context, listen: false)
          .fetchOrderDetails(orderId, context, isFromOrderComplete: true);

      setMarkLoadingStatus(false);

      //send notification to seller

      var sellerId = Provider.of<OrderDetailsService>(context, listen: false)
          .selectedExtraSellerId;
      var username = Provider.of<ProfileService>(context, listen: false)
              .profileDetails
              .userDetails
              .name ??
          '';
      PushNotificationService().sendNotificationToSeller(context,
          sellerId: sellerId,
          title: "$username " +
              lnProvider.getString("accepted your order completion request"),
          body: 'Order id: $orderId');

      //
    } else {
      setMarkLoadingStatus(false);
      if (decodedData.containsKey('msg')) {
        OthersHelper().showToast(decodedData['msg'], Colors.black);
      } else {
        OthersHelper().showToast('Something went wrong', Colors.black);
      }
    }
  }

  //Decline order
  //===========>

  declineOrder(BuildContext context,
      {required orderId, required sellerId, required declineReason}) async {
    //get user id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var connection = await checkConnection();
    if (!connection) return;

    setMarkLoadingStatus(true);

    var data = jsonEncode({
      'order_id': orderId,
      'seller_id': sellerId,
      'decline_reason': declineReason
    });

    var response = await http.post(
        Uri.parse('$baseApi/user/order/request/status/complete/decline'),
        headers: header,
        body: data);

    final decodedData = jsonDecode(response.body);

    debugPrint(response.body.toString());

    if (response.statusCode == 404) {
      OthersHelper().showToast(decodedData['msg'], Colors.black);

      await Provider.of<OrderDetailsService>(context, listen: false)
          .fetchOrderDetails(orderId, context, isFromOrderComplete: true);

      setMarkLoadingStatus(false);

      Navigator.pop(context);

      //send notification to seller

      // var sellerId = Provider.of<OrderDetailsService>(context, listen: false)
      //     .selectedExtraSellerId;

      var username = Provider.of<ProfileService>(context, listen: false)
              .profileDetails
              .userDetails
              .name ??
          '';
      PushNotificationService().sendNotificationToSeller(context,
          sellerId: sellerId,
          title: "$username rejected your order completion request",
          body: 'Order id: $orderId');
    } else {
      setMarkLoadingStatus(false);

      if (decodedData.containsKey('errors')) {
        OthersHelper().showToast(
            decodedData['errors']['decline_reason'][0], Colors.black);
      } else {
        OthersHelper().showToast('Something went wrong', Colors.black);
      }
    }
  }

  // decline history
  // =====================>

  var declineHistory;

  bool loadingDeclineHistory = false;

  setLoadingDeclineHistoryStatus(bool status) {
    loadingDeclineHistory = status;
    notifyListeners();
  }

  fetchDeclineHistory(BuildContext context, {required orderId}) async {
    //get user id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      // "Accept": "application/json",
      // "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var connection = await checkConnection();
    if (!connection) return;

    setLoadingDeclineHistoryStatus(true);

    var response = await http.get(
      Uri.parse(
          '$baseApi/user/order/request/complete/decline/history?order_id=$orderId'),
      headers: header,
    );

    debugPrint(response.body.toString());

    setLoadingDeclineHistoryStatus(false);

    final decodedData = jsonDecode(response.body);

    if (response.statusCode == 201) {
      declineHistory = decodedData;
      notifyListeners();
    } else {
      //error

      declineHistory = null;
      notifyListeners();
    }
  }

  //Cancel order
  // ===========>

  bool cancelLoading = false;

  setCancelLoadingStatus(bool status) {
    cancelLoading = status;
    notifyListeners();
  }

  cancelOrder(BuildContext context, {required orderId}) async {
    //get user id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var data = jsonEncode({"id": orderId});

    var connection = await checkConnection();
    if (!connection) return;

    setCancelLoadingStatus(true);

    var response = await http.post(
        Uri.parse('$baseApi/seller/my-orders/order/change-status'),
        headers: header,
        body: data);

    debugPrint(response.body.toString());

    setCancelLoadingStatus(false);

    final decodedData = jsonDecode(response.body);

    if (response.statusCode == 500) {
      OthersHelper().showSnackBar(context, 'Order cancelled', Colors.black);
      Provider.of<MyOrdersService>(context, listen: false).fetchMyOrders();
      Navigator.pop(context);
    } else {
      OthersHelper()
          .showSnackBar(context, 'Something went wrong', Colors.black);
    }
  }
}
