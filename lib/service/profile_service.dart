import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qixer/model/profile_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService with ChangeNotifier {
  bool isloading = false;

  var profileDetails;
  var profileImage;

  List ordersList = [0, 0, 0, 0];
  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  setEverythingToDefault() {
    profileDetails = null;
    profileImage = null;
    ordersList = [0, 0, 0, 0];
    notifyListeners();
  }

  Future<bool> getProfileDetails({bool isFromProfileupdatePage = false}) async {
    if (isFromProfileupdatePage == true) {
      //if from update profile page then load it anyway

      setEverythingToDefault();
      await fetchData();
      return true;
    } else {
      //not from profile page. check if data already loaded
      if (profileDetails == null) {
        fetchData();
        return true;
      } else {
        return true;
      }
    }
  }

  Future<bool> fetchData() async {
    print("token form profile=====>");
    var connection = await checkConnection();
    if (!connection) return false;
    //internet connection is on
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');

    setLoadingTrue();

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      // "Content-Type": "application/json"
      "Authorization": "Bearer $token",
    };

    var response =
        await http.get(Uri.parse('$baseApi/user/profile'), headers: header);
    if (response.statusCode == 201) {
      var data = ProfileModel.fromJson(jsonDecode(response.body));
      profileDetails = data;

      ordersList[0] = profileDetails.pendingOrder;
      ordersList[1] = profileDetails.activeOrder;
      ordersList[2] = profileDetails.completeOrder;
      ordersList[3] = profileDetails.totalOrder;

      if (jsonDecode(response.body)['profile_image'] is List) {
        //then dont do anything because it means image is missing from database
      } else {
        profileImage = jsonDecode(response.body)['profile_image']['img_url'];
      }

      setLoadingFalse();
      notifyListeners();
      return true;
    } else {
      debugPrint(response.body.toString());
      profileDetails == 'error';
      setLoadingFalse();
      // OthersHelper().showToast('Something went wrong', Colors.black);
      notifyListeners();

      return false;
    }
  }
}
