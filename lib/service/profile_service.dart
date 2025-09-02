import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qixer/helper/SharedPreferencesHelper.dart';
import 'package:qixer/model/profile_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/view/selectionRole/selectionRoleView.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qixer/generated/app_localizations.dart';

class ProfileService with ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;

  var profileDetails;
  var profileImage;
  var businessProfile;

  List ordersList = [0, 0, 0, 0];
  setLoadingTrue() {
    _isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    _isloading = false;
    notifyListeners();
  }

  setEverythingToDefault() {
    profileDetails = null;
    profileImage = null;
    businessProfile = null;
    ordersList = [0, 0, 0, 0];

    // notifyListeners();
  }

  Future<bool> getProfileDetails(
      {bool isFromProfileupdatePage = false,
      required BuildContext context}) async {
    if (isFromProfileupdatePage == true) {
      //if from update profile page then load it anyway
      setEverythingToDefault();
      print("calling profile service");
      await fetchData(context);
      return true;
    } else {
      if (profileDetails == null) {
        print("calling profile service2222");
        fetchData(context);
        return true;
      } else {
        return true;
      }
    }
  }

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  getLoggedIn() async {
    final pref = await SharedPreferences.getInstance();
    _isLoggedIn = pref.getBool("shashaktnirman_is_logged_in") ?? false;
    print("isLoggedIn ===> $_isLoggedIn");
    notifyListeners();
  }

  Future<bool> fetchData(BuildContext context) async {
    _isloading = true;
    print("token form profile=====>");
    var connection = await checkConnection();
    if (!connection) return false;
    //internet connection is on
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');
    bool isLoggedIn = prefs.getBool('shashaktnirman_is_logged_in') ?? false;
    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      // "Content-Type": "application/json"
      "Authorization": "Bearer $token",
    };

    var response =
        await http.get(Uri.parse('$baseApi/user/profile'), headers: header);
    print("headers====> $header");
    if (response.statusCode == 201) {
      var data = ProfileModel.fromJson(jsonDecode(response.body));
      debugPrint("business name ====> ${data.userDetails?.businessName}");
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
      print(
          "image business ===> ${jsonDecode(response.body)['business_profile_image']}");
      if (jsonDecode(response.body)['business_profile_image'] is List) {
        //then dont do anything because it means image is missing from database
      } else {
        businessProfile =
            jsonDecode(response.body)['business_profile_image']['img_url'];
      }
      _isloading = false;
      notifyListeners();
      return true;
    } else {
      var decodedBody = jsonDecode(response.body);
      debugPrint(response.body.toString());
      debugPrint("message :==== ${decodedBody['message']}");
      if (decodedBody['message'] == "Unauthenticated.") {
        if (isLoggedIn) {
          SharedPreferencesHelper.clearData();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelectionRoleView(hasBackButton: false),
              ));
        } else {
          OthersHelper()
              .showToast(AppLocalizations.of(context)!.skipModeMsg, Colors.red);
        }
      }
      profileDetails == 'error';
      // OthersHelper().showToast('Something went wrong', Colors.black);
      _isloading = false;
      notifyListeners();
      return false;
    }
  }
}
