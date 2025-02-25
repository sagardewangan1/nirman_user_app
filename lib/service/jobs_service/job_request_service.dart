import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/model/job_request_model.dart';
import 'package:qixer/service/booking_services/place_order_service.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/payment_gateway_list_service.dart';
import 'package:qixer/view/home/landing_page.dart';
import 'package:qixer/view/jobs/components/hire_job_success_page.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobRequestService with ChangeNotifier {
  List jobReqList = [];
  bool isloading = false;
  var showJobDescriptionId;

  late int totalPages;

  int currentPage = 1;

  var selectedJobPrice = '0';
  var selectedRequestId;

  setSelectedJobPriceAndId({required price, required id}) {
    selectedJobPrice = price.toString();
    selectedRequestId = id;

    notifyListeners();
  }

  setLoadingStatus(bool status) {
    isloading = status;
    notifyListeners();
  }

  setShowJobDescriptionId(value) {
    if (value == showJobDescriptionId) {
      return;
    }
    showJobDescriptionId = value;
    notifyListeners();
  }

  setCurrentPage(newValue) {
    currentPage = newValue;
    notifyListeners();
  }

  setTotalPage(newPageNumber) {
    totalPages = newPageNumber;
    notifyListeners();
  }

  fetchJobRequestList(context, {bool isrefresh = false}) async {
    if (isrefresh) {
      //making the list empty first to show loading bar (we are showing loading bar while the product list is empty)
      //we are make the list empty when the sub category or brand is selected because then the refresh is true
      jobReqList = [];

      notifyListeners();

      Provider.of<JobRequestService>(context, listen: false)
          .setCurrentPage(currentPage);
    } else {}

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var connection = await checkConnection();
    if (connection) {
      setLoadingStatus(true);

      var response = await http.get(
          Uri.parse(
              "$baseApi/user/job/request/request-lists?page=$currentPage"),
          headers: header);

      setLoadingStatus(false);
      final decodedData = jsonDecode(response.body);
      if (response.statusCode == 201 &&
          decodedData.containsKey('all_job_request') &&
          decodedData['all_job_request']['data'].isNotEmpty) {
        var data = JobRequestModel.fromJson(decodedData);

        setTotalPage(data.allJobRequest.lastPage);

        if (isrefresh) {
          //if refreshed, then remove all service from list and insert new data
          //make the list empty first so that existing data doesn't stay
          setServiceList(data.allJobRequest.data, false);
        } else {
          //else add new data
          setServiceList(data.allJobRequest.data, true);
        }

        currentPage++;
        setCurrentPage(currentPage);
        return true;
      } else {
        debugPrint(response.body.toString());
        return false;
      }
    }
  }

  setServiceList(dataList, bool addnewData) {
    if (addnewData == false) {
      //make the list empty first so that existing data doesn't stay
      jobReqList = [];
      notifyListeners();
    }

    for (int i = 0; i < dataList.length; i++) {
      jobReqList.add(dataList[i]);
    }

    notifyListeners();
  }

  //hire
  // =========>
  //=========>

  Future<bool> createHireJobRequest(BuildContext context,
      {imagePath, bool isManualOrCod = false}) async {
    //get user id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');

    var connection = await checkConnection();
    if (!connection) return false;
    //if connection is ok

    Provider.of<PlaceOrderService>(context, listen: false).setLoadingTrue();

    var selectedPayment =
        Provider.of<PaymentGatewayListService>(context, listen: false)
                .selectedMethodName ??
            'cash_on_delivery';

    FormData formData;
    var dio = Dio();
    dio.options.headers['Content-Type'] = 'multipart/form-data';
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = "Bearer $token";

    formData = FormData.fromMap({
      'selected_payment_gateway': selectedPayment,
      'manual_payment_image': imagePath != null
          ? await MultipartFile.fromFile(imagePath,
              filename: 'hireJobbankTransfer.jpg')
          : null,
    });
    var response = await dio.post(
      '$baseApi/user/job/request/seller-hire/$selectedRequestId',
      data: formData,
      options: Options(
        validateStatus: (status) {
          return true;
        },
      ),
    );

    Provider.of<PlaceOrderService>(context, listen: false).setLoadingFalse();

    if (response.statusCode == 200 ||
        response.data.toString().toLowerCase().contains("success")) {
      if (isManualOrCod == true) {
        goToJobSuccessPage(context);
      }

      notifyListeners();

      return true;
    } else {
      try {
        final resData = response.data;
        if (resData['msg'] != null) {
          OthersHelper()
              .showToast(lnProvider.getString(resData['msg']), Colors.black);
          return false;
        }
      } catch (e) {}
      OthersHelper().showToast('Something went wrong', Colors.black);
      return false;
    }
  }

  // =========>
  goToJobSuccessPage(BuildContext context) async {
    OthersHelper().showToast('Hiring successful', Colors.black);

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LandingPage()),
        (Route<dynamic> route) => false);

    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const HireJobSuccessPage(),
      ),
    );
  }
}
