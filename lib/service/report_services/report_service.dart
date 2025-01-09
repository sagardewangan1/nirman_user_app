import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/model/report_list_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/report_services/report_message_service.dart';
import 'package:qixer/view/report/report_chat_page.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportService with ChangeNotifier {
  var reportList = [];

  late int totalPages;
  int currentPage = 1;

  setCurrentPage(newValue) {
    currentPage = newValue;
    notifyListeners();
  }

  setTotalPage(newPageNumber) {
    totalPages = newPageNumber;
    notifyListeners();
  }

  setReportListDefault() {
    currentPage = 1;
    reportList = [];
    notifyListeners();
  }

  addNewDataReportList(subject, id, priority, status) {
    reportList.add(
        {'subject': subject, 'id': id, 'priority': priority, 'status': status});
    notifyListeners();
  }

  fetchReportList(context, {bool isrefresh = false}) async {
    if (isrefresh) {
      //making the list empty first to show loading bar (we are showing loading bar while the product list is empty)
      //we are make the list empty when the sub category or brand is selected because then the refresh is true
      reportList = [];

      notifyListeners();

      Provider.of<ReportService>(context, listen: false)
          .setCurrentPage(currentPage);
    } else {}

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

      var response = await http.post(
          Uri.parse("$baseApi/user/report/list?page=$currentPage"),
          headers: header);
      debugPrint(response.body.toString());
      if (response.statusCode == 200 &&
          jsonDecode(response.body)['data'].isNotEmpty) {
        var data = ReportListModel.fromJson(jsonDecode(response.body));

        setTotalPage(data.total);

        if (isrefresh) {
          //if refreshed, then remove all service from list and insert new data
          //make the list empty first so that existing data doesn't stay
          setServiceList(data.data, false);
        } else {
          //else add new data
          setServiceList(data.data, true);
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

  setServiceList(List<Datum> dataList, bool addnewData) {
    if (addnewData == false) {
      //make the list empty first so that existing data doesn't stay
      reportList = [];
      notifyListeners();
    }

    for (int i = 0; i < dataList.length; i++) {
      reportList.add({
        'subject': dataList[i].report,
        'id': dataList[i].id,
        'priority': dataList[i].buyerId,
        'status': dataList[i].status,
        'orderId': dataList[i].orderId,
        'serviceId': dataList[i].serviceId,
      });
    }

    notifyListeners();
  }

  goToMessagePage(BuildContext context, title, reportId) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => ReportChatPage(
          title: reportId.toString(),
          ticketId: reportId,
        ),
      ),
    );
    //fetch message
    Provider.of<ReportMessagesService>(context, listen: false)
        .fetchMessages(reportId);
  }
}
