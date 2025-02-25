import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:qixer/model/my_orders_list_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyOrdersService with ChangeNotifier {
  var myServices;
  var nextPageUrl;

  bool isLoading = false;
  bool isLoadingNextPage = false;

  var orderStatusOptions = [
    "pending",
    "active",
    "complete",
    "delivered",
    "cancelled",
    "All"
  ];
  var paymentStatusOptions = ['pending', 'complete', "All"];
  var selectedPaymentSort = "All";
  var selectedOrderSort = "All";

  late int totalPages;
  int currentPage = 1;

  String get paymentStatusCode {
    if (selectedPaymentSort == "All") {
      return '';
    }
    return paymentStatusOptions.indexOf(selectedPaymentSort).toString();
  }

  String get orderStatusCode {
    if (selectedOrderSort == "All") {
      return '';
    }
    return orderStatusOptions.indexOf(selectedOrderSort).toString();
  }

  setPaymentSort(value) {
    if (value == selectedPaymentSort) {
      return;
    }
    selectedPaymentSort = value;
    fetchMyOrders();
    notifyListeners();
  }

  setOrderSort(value) {
    if (value == selectedOrderSort) {
      return;
    }
    selectedOrderSort = value;
    fetchMyOrders();
    notifyListeners();
  }

  setLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  setIsLoadingNextPage(value) {
    if (value == isLoadingNextPage) {
      return;
    }
    isLoadingNextPage = value;
    notifyListeners();
  }

  fetchMyOrders() async {
    //get user id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    var token = prefs.getString('shashaktnirmantoken');

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    //       var data = jsonEncode({
    //   'email': email,
    //   'password': pass,
    // });

    var connection = await checkConnection();
    if (connection) {
      setLoadingTrue();
      //if connection is ok
      var response = await http.post(
          Uri.parse(
              '$baseApi/user/my-orders?&payment_status=$paymentStatusCode&status=$orderStatusCode'),
          headers: header);

      if (response.statusCode == 201 &&
          jsonDecode(response.body)['my_orders']['data'].isNotEmpty) {
        debugPrint(response.body.toString());
        var data = MyordersListModel.fromJson(jsonDecode(response.body));

        myServices = data.myOrders;
        nextPageUrl = data.nextPage;
        isLoading = false;
        notifyListeners();
        setLoadingFalse();
        return myServices;
      } else {
        debugPrint(response.body.toString());
        //Something went wrong
        myServices = 'error';
        isLoading = false;
        notifyListeners();
        setLoadingFalse();
        return myServices;
      }
    }
  }

  fetchNextOrders() async {
    //get user id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    var token = prefs.getString('shashaktnirmantoken');

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var connection = await checkConnection();
    if (nextPageUrl == null) {
      return false;
    }
    if (connection) {
      setIsLoadingNextPage(true);
      //if connection is ok
      var response =
          await http.post(Uri.parse('$nextPageUrl'), headers: header);

      if (response.statusCode == 201 &&
          jsonDecode(response.body)['my_orders']['data'].isNotEmpty) {
        debugPrint(response.body.toString());
        var data = MyordersListModel.fromJson(jsonDecode(response.body));

        for (var element in data.myOrders) {
          myServices.add(element);
        }
        nextPageUrl = data.nextPage;
        setIsLoadingNextPage(false);
        return myServices;
      } else {
        debugPrint(response.body.toString());
        //Something went wrong
        myServices = 'error';
        setIsLoadingNextPage(false);
        return false;
      }
    }
  }
}
