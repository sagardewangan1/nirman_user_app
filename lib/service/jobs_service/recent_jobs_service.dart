import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
}
