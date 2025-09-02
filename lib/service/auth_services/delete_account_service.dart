import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/helper/SharedPreferencesHelper.dart';
import 'package:qixer/helper/extension/string_extension.dart';
import 'package:qixer/service/auth_services/facebook_login_service.dart';
import 'package:qixer/service/auth_services/google_sign_service.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/getImageController.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/view/home/homepage_helper.dart';
import 'package:qixer/view/selectionRole/selectionRoleView.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qixer/generated/app_localizations.dart';

class DeleteAccountService with ChangeNotifier {
  bool isloading = false;
  var deactivateReasonDropdownList = [
    'Concern about my data',
    'Want to create second account',
    'Too many ads',
    "Can't find leads",
    'Privacy concern',
    'Too Busy',
    'Something Else',
  ];

  var selecteddeactivateReason = 'Concern about my data';

  var deactivateReasonDropdownIndexList = [
    'concern_data',
    'second_account',
    'too_many_ads',
    'no_leads',
    'privacy_concern',
    'too_busy',
    'something_else',
  ];

  var selecteddeactivateReasonId = 'concern_data';

  void setdeactivateReasonValue(String? newValue) {
    if (newValue != null) {
      selecteddeactivateReason = newValue;
      notifyListeners();
    }
  }

  void setSelecteddeactivateReasonId(String id) {
    selecteddeactivateReasonId = id;
    notifyListeners();
  }

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  deleteAccount(BuildContext context, String description) async {
    var connection = await checkConnection();
    if (connection) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('shashaktnirmantoken');

      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        // "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
      setLoadingTrue();
      // if (baseApi == 'https://sashaktnirmaan.com/api/v1') {
      //   await Future.delayed(const Duration(seconds: 1));
      //   OthersHelper().showToast(
      //       AppLocalizations.of(context)!.thisFeatureIsTurnedOffForDemoApp,
      //       Colors.black);
      //   setLoadingFalse();
      //   return;
      // }
      var body = {
        "reason": selecteddeactivateReason,
        "description": description.toString()
      };
      var response = await http.post(Uri.parse('$baseApi/account-delete'),
          headers: header, body: body);
      if (response.statusCode == 201) {
        try {
          SharedPreferencesHelper.clearData();
          //if logged in by google then logout from it
          // GoogleSignInService().logOutFromGoogleLogin();
          // //if logged in by facebook then logout from it
          // FacebookLoginService().logoutFromFacebook();
          notifyListeners();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SelectionRoleView(hasBackButton: false),
              ));
          final data = jsonDecode(response.body);
          if (data['message'] != null) {
            OthersHelper().showToast(data['message'], Colors.black);
          }
        } catch (e) {
          debugPrint("error====> $e");
        }
        // var appleId = sPref.getString("appleId");
        // var appleUserToken = sPref.getString("userToken");
        //
        // await appleTokenRevoke(
        //   appleUserToken,
        //   appleId,
        // );
        // clear profile data =====>
        Provider.of<ProfileService>(context, listen: false)
            .setEverythingToDefault();
        Provider.of<GetImageController>(context, listen: false)
            .removeBannerImages();
        clear();
        setLoadingFalse();
      } else {
        try {
          final data = jsonDecode(response.body);
          if (data['message'] != null) {
            OthersHelper().showToast(data['message'], Colors.black);
            setLoadingFalse();
            return;
          }
        } catch (e) {}
        debugPrint(response.body.toString());
        OthersHelper().showToast(
            AppLocalizations.of(context)!.somethingWentWrong, Colors.black);
        setLoadingFalse();
      }
    }
  }

  appleTokenRevoke(token, id) async {
    if (!Platform.isIOS) {
      return;
    }
    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      // "Accept": "application/json",
      'content-type': 'application/x-www-form-urlencoded',
    };

    debugPrint(
        'https://appleid.apple.com/auth/revoke?client_id=$id&client_secret=$clientSecret&token=$token&token_type_hint=access_token');
    var response = await http.post(
      Uri.parse(
          'https://appleid.apple.com/auth/revoke?client_id=$id&client_secret=$clientSecret&token=$token&token_type_hint=access_token'),
      headers: header,
    );
    if (response.statusCode == 200) {
      "Apple id revoked successfully".tr().showToast();
    } else {
      "Apple id revoke failed".tr().showToast();
    }
  }

  //clear saved email, pass and token
  clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
