import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/string_extension.dart';
import 'package:qixer/model/OTPResponseModel.dart';
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
  bool _isloading2 = false;
  bool get isloading2 => _isloading2;
  String countryCode = 'IN';
  setCountryCode(code) {
    countryCode = code;
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

  setLoading2() {
    _isloading2 = !_isloading2;
    notifyListeners();
  }

  Future<bool> login(
      email, pass, BuildContext context, bool shashaktnirmanIsLoggedIn,
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

        if (shashaktnirmanIsLoggedIn) {
          saveDetails(email, token, userId, state, countryId,
              pass: pass, keepLogin: shashaktnirmanIsLoggedIn);
        } else {
          setshashaktnirman_is_logged_inFalseSaveToken(token);
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

  Future<bool> sendOTP(
      mobile, userType, BuildContext context, bool shashaktnirmanIsLoggedIn,
      {isFromLoginPage = true}) async {
    var connection = await checkConnection();
    if (connection) {
      //

      setLoadingTrue();
      var data = jsonEncode({
        'phone': mobile,
        'user_type': userType,
        'country_code': countryCode
      });
      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        "Content-Type": "application/json"
      };

      print("send otp body====> $data");
      var response = await http.post(Uri.parse('$baseApi/send-otp'),
          body: data, headers: header);

      debugPrint(response.body.toString());

      if (response.statusCode == 201 || response.statusCode == 200) {
        if (isFromLoginPage) {
          OthersHelper().showToast(
              "OTP Successfully Sent in Your Mobile Number",
              ConstantColors().successColor);
        }
        setLoadingFalse();
        return true;
      } else {
        debugPrint(response.body.toString());
        //Login unsuccessful ==========>
        if (isFromLoginPage) {
          OthersHelper().showToast(
              "Invalid Mobile Number", ConstantColors().warningColor);
        }
        setLoadingFalse();
        return false;
      }
    } else {
      //internet off
      return false;
    }
  }

  OtpResponseModel _otpResponseModel = OtpResponseModel();
  OtpResponseModel get otpResponseModel => _otpResponseModel;

  Future<OtpResponseModel?> otpVerify(String mobile, String otp, userType,
      BuildContext context, bool shashaktnirmanIsLoggedIn,
      {bool isFromLoginPage = true}) async {
    var connection = await checkConnection();

    if (!connection) {
      OthersHelper().showToast(
          "Check your Network Connections", ConstantColors().warningColor);
      return _otpResponseModel;
    }

    setLoading2();

    var data = jsonEncode({'phone': mobile, 'otp': otp, 'user_type': userType});
    print("otv verify body =====> $data");
    var header = {
      "Accept": "application/json",
      "Content-Type": "application/json"
    };

    try {
      final response = await http.post(Uri.parse('$baseApi/login'),
          body: data, headers: header);

      if (response.statusCode == 201) {
        print("actaul reponse====> ${response.body}");
        _otpResponseModel =
            OtpResponseModel.fromJson(jsonDecode(response.body));
        print("token genaeka====> ${_otpResponseModel.token}");
        String token = _otpResponseModel.token ?? '';
        dynamic userId =
            _otpResponseModel.user != null ? _otpResponseModel.user!.id : 0;
        String state = _otpResponseModel.user?.state ?? '';
        String countryId = _otpResponseModel.user?.countryId ?? '';

        if (userId == 0) {
          debugPrint("User ID is not available");
        }

        if (shashaktnirmanIsLoggedIn) {
          saveDetails(mobile, token, userId, state, countryId);
        } else {
          setshashaktnirman_is_logged_inFalseSaveToken(token);
        }

        setLoading2();
        return _otpResponseModel;
      }
    } catch (e) {
      debugPrint("Error during HTTP request: $e");
      setLoadingFalse();
      OthersHelper().showToast("Something went wrong. Please try again.",
          ConstantColors().warningColor);
      return _otpResponseModel;
    }
    return null;
  }

  saveDetails(
    String number,
    String token,
    int userId,
    state,
    countryId, {
    String? pass,
    bool keepLogin = false,
    String? email,
    bool? registerStatus,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email ?? '');
    prefs.setString("phone", number);
    prefs.setBool('shashaktnirman_is_logged_in', keepLogin);
    prefs.setBool('registerStatus', registerStatus ?? false);
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

  setshashaktnirman_is_logged_inFalseSaveToken(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('shashaktnirman_is_logged_in', false);
    prefs.setString("token", token);
  }
}
