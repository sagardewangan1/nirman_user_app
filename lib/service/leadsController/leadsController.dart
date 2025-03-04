import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  Timer? _timer; // ✅ Timer for auto-fetching
  bool _isFetching = false;

  LeadsController() {
    _startAutoFetch(); // ✅ Start auto-fetch when Provider initializes
  }

  void _startAutoFetch() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      getMyLeads(autoFetch: true); // ✅ Fetch new leads every 5 sec
    });
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

  Future<bool> getMyLeads({bool autoFetch = false}) async {
    if (_isFetching && !autoFetch) return false;
    _isFetching = true;
    notifyListeners();
    var connection = await checkConnection();
    if (!connection) {
      _isLoading = false;
      _isFetching = false;
      return false;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');
    if (token == null) {
      _isLoading = false;
      _isFetching = false;

      return false;
    }
    try {
      String url = "$baseApi/seller/leads/list";
      var headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
      var response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _myLeadsDataModel =
            MyLeadsDataModel.fromJson(jsonDecode(response.body));
        _leadsStreamController.add(_myLeadsDataModel);
        _isLoading = false;
        notifyListeners();
        return true;
      }
    } on SocketException catch (_) {
      OthersHelper()
          .showToast("No internet connection. Please try again!", Colors.red);
    } catch (e, stackTrace) {
      if (!_leadsStreamController.isClosed) {
        _leadsStreamController
            .addError("Something went wrong. Please try again later.");
      }
    }
    _isFetching = false;
    _isLoading = false;
    notifyListeners();
    return false;
  }

  @override
  void dispose() {
    _timer?.cancel(); // ✅ Stop Timer when Provider is disposed
    super.dispose();
  }

  bool _isLoading2 = false;
  bool get isLoading2 => _isLoading2;
  Future<bool> updateLeadStatus({String? leadId}) async {
    _isLoading2 = true;
    notifyListeners();

    var connection = await checkConnection();
    if (!connection) {
      _isLoading2 = false;
      notifyListeners();
      return false;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');
    if (token == null) {
      _isLoading = false;
      _isFetching = false;

      return false;
    }

    try {
      String url = "$baseApi/seller/leads/list/update-status/$leadId";
      var headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      var response =
          await http.get(Uri.parse(url), headers: headers); // Changed from GET

      if (kDebugMode) {
        print("📡 Response url: $url");
        print("📡 Response Status Code: ${response.statusCode}");
        print("📜 Response Body: ${response.body}");
        print("📜 Response Headers: $headers");
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        getMyLeads(autoFetch: true);
        _isLoading2 = false;
        notifyListeners();
        return true;
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("❌ Exception: $e");
        print("🔍 Stack Trace: $stackTrace");
      }
    }

    _isLoading2 = false; // Ensure loading is turned off even in failure
    notifyListeners();
    return false;
  }
}
