import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/service/report_services/report_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common_service.dart';

class LeaveFeedbackService with ChangeNotifier {
  bool isloading = false;
  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  Future<bool> leaveFeedback(
      rating, name, email, message, serviceId, BuildContext context) async {
    var connection = await checkConnection();
    if (connection) {
      setLoadingTrue();

      var data = jsonEncode({
        'rating': rating,
        'name': name,
        'email': email,
        'message': message,
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      var response = await http.post(
          Uri.parse('$baseApi/user/add-service-rating/$serviceId'),
          body: data,
          headers: header);

      if (response.statusCode == 201) {
        setLoadingFalse();

        OthersHelper().showToast('review posted successfully', Colors.black);

        Navigator.pop(context);

        return true;
      } else {
        debugPrint(response.body.toString());
        OthersHelper()
            .showToast(jsonDecode(response.body)['message'], Colors.black);
        setLoadingFalse();
        return false;
      }
    } else {
      //internet connection off
      return false;
    }
  }

  //===========>

  bool reportLoading = false;

  setRLoadingStatus(bool status) {
    reportLoading = status;
    notifyListeners();
  }

  Future<bool> leaveReport(BuildContext context,
      {required message, required serviceId, required orderId}) async {
    var connection = await checkConnection();
    if (!connection) return false;

    setRLoadingStatus(true);

    var data = jsonEncode({
      'report': message,
      'order_id': orderId,
      'service_id': serviceId,
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var response = await http.post(Uri.parse('$baseApi/user/report/create'),
        body: data, headers: header);

    setRLoadingStatus(false);
    if (response.statusCode == 200) {
      OthersHelper().showToast('Report submitted', Colors.black);
      Provider.of<ReportService>(context, listen: false)
          .fetchReportList(context);
      Navigator.pop(context);

      return true;
    } else {
      debugPrint(response.body.toString());
      //Sign up unsuccessful ==========>
      OthersHelper().showToast(jsonDecode(response.body)['msg'], Colors.black);

      return false;
    }
  }
}
