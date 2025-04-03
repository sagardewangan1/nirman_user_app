import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qixer/model/service_details_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceDetailsService with ChangeNotifier {
  var sellerId;

  bool isloading = false;

  // List reviewList = [];

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  ServiceDetailsModel _serviceDetailsModel = ServiceDetailsModel();
  ServiceDetailsModel get serviceDetailsModel => _serviceDetailsModel;

  Future<bool> fetchServiceDetails(serviceId) async {
    setLoadingTrue();
    print("============> Calling Service Details <==================");

    try {
      var connection = await checkConnection();
      if (!connection) {
        print("❌ No Internet Connection.");
        return false;
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('shashaktnirmantoken');
      var deviceToken = prefs.getString('sashaktNirmaanDeviceToken');

      if (token == null) {
        print("❌ Token not found.");
        return false;
      }

      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
        'device_token': deviceToken.toString()
      };

      String url = '$baseApi/service-details/$serviceId';
      var response = await http.get(
        Uri.parse(url),
        headers: header,
      );

      debugPrint("url ===> $url\n");
      debugPrint("header ===> $header\n");
      debugPrint(
          "Actual service details data===> ${response.body.toString()}\n");

      if (response.statusCode == 200 || response.statusCode == 201) {
        _serviceDetailsModel =
            ServiceDetailsModel.fromJson(jsonDecode(response.body));

        sellerId = jsonDecode(response.body)['service_details']
            ['seller_for_mobile']['id'];

        notifyListeners();
        return true;
      } else {
        print("⚠️ API Error: ${response.statusCode}");
        OthersHelper().showToast('Something went wrong', Colors.black);
        return false;
      }
    } catch (e, stackTrace) {
      print("❌ Exception: $e");
      print("StackTrace: $stackTrace");
      OthersHelper().showToast("Error fetching details", Colors.red);
      return false;
    } finally {
      setLoadingFalse();
      notifyListeners();
      print("🔄 fetchServiceDetails Execution Completed.");
    }
  }
}
