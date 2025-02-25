import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/model/jobs/job_details_model.dart';
import 'package:qixer/model/jobs/my_jobs_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyJobsService with ChangeNotifier {
  var myJobsListMap = [];
  List imageList = [];

  bool isLoading = true;

  late int totalPages;

  int currentPage = 1;

  setLoadingStatus(bool status) {
    isLoading = status;
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

  setActiveStatus(bool status, int index) {
    myJobsListMap[index]['isActive'] = status;
    notifyListeners();
  }

  removeJobFromList(int i) {
    myJobsListMap.removeAt(i);
    imageList.removeAt(i);
    notifyListeners();
  }

  setDefault() {
    myJobsListMap = [];
    imageList = [];
    currentPage = 1;
    notifyListeners();
  }

  fetchMyJobs(context, {bool isrefresh = false}) async {
    if (isrefresh) {
      myJobsListMap = [];
      notifyListeners();

      Provider.of<MyJobsService>(context, listen: false)
          .setCurrentPage(currentPage);
    } else {}

    var connection = await checkConnection();
    if (connection) {
      //if connection is ok

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('shashaktnirmantoken');

      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      setLoadingStatus(true);

      var response = await http.get(
          Uri.parse("$baseApi/user/job/job-lists?page=$currentPage"),
          headers: header);

      setLoadingStatus(false);

      final decodedData = jsonDecode(response.body);
      if (response.statusCode == 201 &&
          decodedData['job_lists']['data'].isNotEmpty) {
        var data = MyJobsModel.fromJson(decodedData);

        setTotalPage(data.jobLists.lastPage);

        for (int i = 0; i < data.jobImage.length; i++) {
          String? serviceImage;

          serviceImage = data.jobImage[i]?.imgUrl ?? placeHolderUrl;

          imageList.add(serviceImage);
        }

        if (isrefresh) {
          //if refreshed, then remove all service from list and insert new data
          setServiceList(data.jobLists.data, imageList, false);
        } else {
          //else add new data
          setServiceList(data.jobLists.data, imageList, true);
        }

        currentPage++;
        setCurrentPage(currentPage);
        return true;
      } else {
        return false;
      }
    }
  }

  setServiceList(data, imageList, bool addnewData) {
    if (addnewData == false) {
      //make the list empty first so that existing data doesn't stay
      myJobsListMap = [];
      notifyListeners();
    }

    for (int i = 0; i < data.length; i++) {
      myJobsListMap.add({
        'id': data[i].id,
        'title': data[i].title,
        'isActive': data[i].isJobOn == 1 ? true : false,
        'price': data[i].price,
        'image': imageList[i],
        'viewCount': data[i].view,
        'description': data[i].description,
        'deadLine': data[i].deadLine,
        'categoryId': data[i].categoryId,
        'subcategoryId': data[i].subcategoryId,
        'countryId': data[i].countryId,
        'cityId': data[i].cityId,
        "isJobOnline": data[i].isJobOnline
      });
    }
  }

  //Fetch order details
  //=====================>

  bool loadingOrderDetails = false;

  setOrderDetailsLoadingStatus(bool status) {
    loadingOrderDetails = status;
    notifyListeners();
  }

  var jobDetails;

  fetchJobDetails(jobId, BuildContext context) async {
    //check internet connection
    var connection = await checkConnection();
    if (connection) {
      //internet connection is on
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('shashaktnirmantoken');

      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        // "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      setOrderDetailsLoadingStatus(true);

      var response = await http.get(
        Uri.parse('$baseApi/job/details/$jobId'),
        headers: header,
      );

      setOrderDetailsLoadingStatus(false);

      if (response.statusCode == 201) {
        final data = JobDetailsModel.fromJson(jsonDecode(response.body));

        jobDetails = data.jobDetails;

        notifyListeners();
      } else {
        OthersHelper().showToast('Something went wrong', Colors.black);
      }
    }
  }

  // ==============>
  //job on off
  jobOnOff(BuildContext context, {required index, required jobId}) async {
    var connection = await checkConnection();
    if (!connection) return;
    //internet connection is on
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');

    var header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var data = jsonEncode({'job_post_id': jobId});

    var response = await http.post(Uri.parse('$baseApi/user/job/on-off'),
        headers: header, body: data);

    debugPrint(response.body.toString());

    if (response.statusCode == 201) {
      final decodedData = jsonDecode(response.body);
      final statusData = decodedData['status'];

      final bool status;
      if (statusData == 1) {
        status = true;
      } else {
        status = false;
      }

      setActiveStatus(status, index);
    } else {}
  }

  //============
  //delete a job
  bool loadingDeleteJob = false;

  setLoadingDeleteJobStatus(bool status) {
    loadingDeleteJob = status;
    notifyListeners();
  }

  deleteJob(BuildContext context, {required index, required jobId}) async {
    var connection = await checkConnection();
    if (!connection) return;
    //internet connection is on
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');

    var header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    setLoadingDeleteJobStatus(true);

    var response = await http.post(
        Uri.parse('$baseApi/user/job/delete-job/$jobId'),
        headers: header);

    setLoadingDeleteJobStatus(false);

    if (response.statusCode == 201) {
      removeJobFromList(index);

      OthersHelper().showToast('Job deleted successfully', Colors.black);

      Navigator.pop(context);
    } else {
      OthersHelper().showToast('Something went wrong', Colors.black);
    }
  }
}
