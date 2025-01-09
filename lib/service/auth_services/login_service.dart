import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/string_extension.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/service/push_notification_service.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../view/auth/signup/components/email_verify_page.dart';
import 'email_verify_service.dart';

class LoginService with ChangeNotifier {
  bool isloading = false;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  Future<bool> login(email, pass, BuildContext context, bool keepLoggedIn,
      {isFromLoginPage = true}) async {
    var connection = await checkConnection();
    if (connection) {
      setLoadingTrue();
      var data = jsonEncode({
        'email': email,
        'password': pass,
      });
      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        "Content-Type": "application/json"
      };

      var response = await http.post(Uri.parse('$baseApi/login'),
          body: data, headers: header);

      debugPrint(response.body.toString());

      if (response.statusCode == 201) {
        if (isFromLoginPage) {
          OthersHelper()
              .showToast("Login successful", ConstantColors().successColor);
        }
        var responseData = jsonDecode(response.body);
        String token = jsonDecode(response.body)['token'];
        int userId = jsonDecode(response.body)['users']['id'];
        String state = jsonDecode(response.body)['users']['state'].toString();
        String countryId =
            jsonDecode(response.body)['users']['country_id'].toString();
        if (responseData["users"]["email_verified"].toString() != "1") {
          var isOtepSent =
              await Provider.of<EmailVerifyService>(context, listen: false)
                  .sendOtpForEmailValidation(
                      responseData["users"]["email"], context, token);

          if (isOtepSent) {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => EmailVerifyPage(
                  email: responseData["users"]["email"].toString(),
                  token: token,
                  userId: userId,
                  state: state,
                  countryId: countryId,
                ),
              ),
            );
          } else {
            "Otp send failed".tr().showToast();
          }
          setLoadingFalse();
          return false;
        }

        if (keepLoggedIn) {
          saveDetails(email, token, userId, state, countryId,
              pass: pass, keepLogin: keepLoggedIn);
        } else {
          setKeepLoggedInFalseSaveToken(token);
        }

        //start pusher
        //============>
        await Provider.of<PushNotificationService>(context, listen: false)
            .fetchPusherCredential(context: context);

        await Provider.of<ProfileService>(context, listen: false).fetchData();
        //start stripe
        //============>

        // =======>
        // Navigator.pushReplacement<void, void>(
        //   context,
        //   MaterialPageRoute<void>(
        //     builder: (BuildContext context) => const LandingPage(),
        //   ),
        // );
        setLoadingFalse();

        return true;
      } else {
        debugPrint(response.body.toString());
        //Login unsuccessful ==========>
        if (isFromLoginPage) {
          OthersHelper().showToast(
              "Invalid Email or Password", ConstantColors().warningColor);
        }
        setLoadingFalse();
        return false;
      }
    } else {
      //internet off
      return false;
    }
  }

  saveDetails(String email, String token, int userId, state, countryId,
      {String? pass, bool keepLogin = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
    prefs.setBool('keepLoggedIn', keepLogin);
    if (keepLogin) {
      prefs.setString("pass", pass ?? "");
    } else {
      prefs.remove("pass");
    }
    prefs.setString("token", token);
    prefs.setInt('userId', userId);
    prefs.setString("state", state);
    prefs.setString("countryId", countryId);
  }

  setKeepLoggedInFalseSaveToken(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('keepLoggedIn', false);
    prefs.setString("token", token);
  }
}
