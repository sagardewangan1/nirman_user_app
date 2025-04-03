import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qixer/model/AllCitiesDataModel.dart';
import 'package:qixer/model/HomeCitiesDataModel.dart';
import 'package:qixer/model/jobs/recent_jobs_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/view/utils/others_helper.dart';

class RecentJobsService with ChangeNotifier {
  var recentJobs;
  var recentJobsImages;

  bool isloading = false;

  setLoadingStatus(bool status) {
    isloading = status;
    notifyListeners();
  }

  fetchRecentJobs(BuildContext context) async {
    //check internet connection
    var connection = await checkConnection();
    if (!connection) return;

    if (recentJobs != null) return;

    var response = await http.get(
      Uri.parse('$baseApi/job/recent-jobs'),
    );
    if (response.statusCode == 201) {
      var data = RecentJobsModel.fromJson(jsonDecode(response.body));

      recentJobs = data.recent10Jobs;
      recentJobsImages = data.jobsImage;
      notifyListeners();
    } else {
      debugPrint(response.body.toString());
    }
  }

  AllCitiesDataModel _allCitiesDataModel = AllCitiesDataModel();
  AllCitiesDataModel get allCitiesDataModel => _allCitiesDataModel;

  List<Data> _filteredCities = [];
  List<Data> get filteredCities => _filteredCities;

  Future<void> fetchAllCities(BuildContext context) async {
    var connection = await checkConnection();
    if (!connection) return;

    if (_allCitiesDataModel.data != null &&
        _allCitiesDataModel.data!.isNotEmpty) {
      _filteredCities =
          List.from(_allCitiesDataModel.data!); // Ensure filtered list has data
      notifyListeners();
      return;
    }

    var response = await http.get(Uri.parse('$baseApi/all-cities'));

    if (response.statusCode == 201) {
      _allCitiesDataModel =
          AllCitiesDataModel.fromJson(jsonDecode(response.body));

      // ✅ Now set filtered list when data is fetched
      _filteredCities = List.from(_allCitiesDataModel.data ?? []);

      notifyListeners();
    } else {
      debugPrint(response.body.toString());
    }
  }

  void filterCities(String query) {
    if (query.isEmpty) {
      _filteredCities = List.from(_allCitiesDataModel.data ?? []);
    } else {
      _filteredCities = _allCitiesDataModel.data
              ?.where((city) =>
                  city.serviceArea!.toLowerCase().contains(query.toLowerCase()))
              .toList() ??
          [];
    }
    notifyListeners();
  }

  int? _cityID;
  String? _cityName;
  int? get cityID => _cityID;
  String? get cityName => _cityName;

  setCityID(int cityId, String cityName) {
    _cityID = cityId;
    _cityName = cityName;
    notifyListeners();
  }

  List<int> _selectedCityIds = [];
  List<int> get selectedCityIds => _selectedCityIds;

  bool isCitySelected(int cityId) {
    return _selectedCityIds.contains(cityId);
  }

  void addCitySelection(int cityId) {
    if (!_selectedCityIds.contains(cityId)) {
      _selectedCityIds.add(cityId);
      debugPrint("📌 Added from autoSelect: $cityId");
      notifyListeners();
    }
  }

  void toggleCitySelection(int cityId) {
    if (_selectedCityIds.contains(cityId)) {
      _selectedCityIds.remove(cityId);
    } else {
      _selectedCityIds.add(cityId);
    }
    debugPrint("Current selected IDs: $_selectedCityIds");
    notifyListeners();
  }

  HomeCitiesDataModel _homeCitiesDataModel = HomeCitiesDataModel();
  HomeCitiesDataModel get homeCitiesDataModel => HomeCitiesDataModel();

  bool _isLoadingLoc = false;
  bool get isLoadingLoc => _isLoadingLoc;

  Future<bool> fetchAllCitiesHome(BuildContext context) async {
    var connection = await checkConnection();
    if (!connection) return false;
    _isLoadingLoc = true;
    try {
      var response = await http.get(Uri.parse('$baseApi/all-cities-home'));

      if (response.statusCode == 201 || response.statusCode == 200) {
        debugPrint(response.body.toString());
        _homeCitiesDataModel =
            HomeCitiesDataModel.fromJson(jsonDecode(response.body));
        _isLoadingLoc = false;
        notifyListeners();
        return true;
      } else {
        _isLoadingLoc = false;
        notifyListeners();
        return false;
      }
    } catch (e, stackTrace) {
      _isLoadingLoc = false;
      notifyListeners();
      debugPrint("stack trace area getting====> $stackTrace");
      return false;
    }
  }
}
