import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qixer/model/AllCitiesDataModel.dart';
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

  fetchAllCities(BuildContext context) async {
    //check internet connection
    var connection = await checkConnection();
    if (!connection) return;

    if (recentJobs != null) return;

    var response = await http.get(
      Uri.parse('$baseApi/all-cities'),
    );
    if (response.statusCode == 201) {
      _allCitiesDataModel =
          AllCitiesDataModel.fromJson(jsonDecode(response.body));
      notifyListeners();
    } else {
      debugPrint(response.body.toString());
    }
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
}
