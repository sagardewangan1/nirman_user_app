import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:qixer/model/MyLeadsDataModel.dart';
import 'package:qixer/model/MyServiceListDataModel.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class VendorDashboardService extends ChangeNotifier {
  MyServiceListDataModel _myServiceListDataModel = MyServiceListDataModel();
  MyServiceListDataModel get myServiceListDataModel => _myServiceListDataModel;

  MyLeadsDataModel _myLeadsDataModel = MyLeadsDataModel();
  MyLeadsDataModel get myLeadsDataModel => _myLeadsDataModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> getMyServiceLists() async {
    _isLoading = true;
    // notifyListeners();
    var connection = await checkConnection();
    if (!connection) {
      return false;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');
    if (token == null) {
      print("❌ Token not found. User not authenticated.");
      _isLoading = false;
      return false;
    }
    try {
      String url = "$baseApi/seller/service/my-services";
      var headers = {
        // "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
      var response = await http.get(Uri.parse(url), headers: headers);
      print("🔗 Request URL: $url");
      print("📩 Request Headers: $headers");
      print("📡 Response Status Code: ${response.statusCode}");
      print("📜 Response Body: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        _myServiceListDataModel =
            MyServiceListDataModel.fromJson(jsonDecode(response.body));
        print(
            "📜 service list data : ${_myServiceListDataModel.myServices?.length}");
        _isLoading = false;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e, stackTrace) {
      print("Exceptions=====> $e");
      print("🔍 Stack Trace: $stackTrace");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> getMyLeads() async {
    _isLoading = true;
    // notifyListeners();
    var connection = await checkConnection();
    if (!connection) {
      return false;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');
    if (token == null) {
      print("❌ Token not found. User not authenticated.");
      _isLoading = false;
      return false;
    }
    try {
      String url = "$baseApi/seller/leads/list";
      var headers = {
        // "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
      var response = await http.get(Uri.parse(url), headers: headers);
      print("🔗 Request URL: $url");
      print("📩 Request Headers: $headers");
      print("📡 Response Status Code: ${response.statusCode}");
      print("📜 Response Body: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        _myLeadsDataModel =
            MyLeadsDataModel.fromJson(jsonDecode(response.body));
        print(
            "📜 service list data : ${_myServiceListDataModel.myServices?.length}");
        _isLoading = false;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e, stackTrace) {
      print("Exceptions=====> $e");
      print("🔍 Stack Trace: $stackTrace");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
