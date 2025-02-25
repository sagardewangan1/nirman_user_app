import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:qixer/model/MyLeadsDataModel.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LeadsController extends ChangeNotifier {
  bool _isNew = false;
  bool get isNew => _isNew;

  setIsNew(value) {
    _isNew = value;
  }

  int _count = 1;
  int get count => _count;

  Stream<int> countStream() async* {
    for (int i = 1; i <= 5; i++) {
      await Future.delayed(const Duration(seconds: 1));
      yield _count = i; // Emit the current count
    }
  }

  String _selectedDateFilter = 'today';
  String get selectedDateFilter => _selectedDateFilter;

  void setDateFilter(String value) {
    _selectedDateFilter = value;
    notifyListeners();
  }

  MyLeadsDataModel _myLeadsDataModel = MyLeadsDataModel();
  MyLeadsDataModel get myLeadsDataModel => _myLeadsDataModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final StreamController<MyLeadsDataModel> _leadsStreamController =
      StreamController<MyLeadsDataModel>.broadcast();
  Stream<MyLeadsDataModel> get leadsStream => _leadsStreamController.stream;

  /// Fetch My Leads and emit data through stream
  Future<void> fetchLeadsStream() async {
    while (true) {
      bool success = await getMyLeads();
      if (success) {
        _leadsStreamController.sink.add(_myLeadsDataModel);
      } else {
        _leadsStreamController.sink.addError("Failed to fetch leads");
      }
      await Future.delayed(const Duration(seconds: 10)); // Fetch every 10 sec
    }
  }

  Future<bool> getMyLeads() async {
    _isLoading = true;
    notifyListeners();

    var connection = await checkConnection();
    if (!connection) {
      _isLoading = false;
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
        print("📜 Leads data length: ${_myLeadsDataModel.data?.length}");
        _isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e, stackTrace) {
      print("❌ Exception: $e");
      print("🔍 Stack Trace: $stackTrace");
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  @override
  void dispose() {
    _leadsStreamController.close();
    super.dispose();
  }
}
