import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/string_extension.dart';
import 'package:qixer/model/OTPResponseModel.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../view/auth/signup/components/email_verify_page.dart';
import '../pushNotificationFirebase.dart';
import 'email_verify_service.dart';
import 'package:qixer/generated/app_localizations.dart';

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

        await Provider.of<ProfileService>(context, listen: false)
            .fetchData(context);
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

  Future<bool> sendOTP(mobile, userType, BuildContext context,
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
              AppLocalizations.of(context)!
                  .otpSuccessfullySentInYourMobileNumber,
              ConstantColors().successColor);
        }
        setLoadingFalse();
        return true;
      } else {
        debugPrint(response.body.toString());
        //Login unsuccessful ==========>
        if (isFromLoginPage) {
          OthersHelper().showToast(
              AppLocalizations.of(context)!.invalidMobileNumber,
              ConstantColors().warningColor);
        }
        setLoadingFalse();
        return false;
      }
    } else {
      //internet off
      return false;
    }
  }

  // provider.sendOTP(
  // phoneNumber,
  // widget.navigationModel?.roleType.toString(),
  // context,
  // ).then((value) {
  //
  // },);

  String? _verificationId;
  String? get verificationId => _verificationId;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? _verificationErrorCode;
  String? get verificationErrorCode => _verificationErrorCode;
  String? _verificationErrorMessage;
  String? get verificationErrorMessage => _verificationErrorMessage;
  int? _resendToken;
  int? get resendToken => _resendToken;

  Future<bool> sendOTPWithFirebase({
    required String phoneNumber,
    required BuildContext context,
  }) async {
    setLoadingTrue();
    final completer = Completer<bool>();
    print('📱 Starting OTP process for: $phoneNumber');
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber.trim(),
      timeout: const Duration(seconds: 60),
      forceResendingToken: resendToken,
      verificationCompleted: (PhoneAuthCredential credential) async {
        print('✅ Auto-verification successful');
        try {
          await auth.signInWithCredential(credential);
          print('🎉 Auto sign-in completed');
        } catch (e) {
          print('❌ Auto sign-in error: $e');
          if (!completer.isCompleted) completer.complete(false);
        } finally {
          setLoadingFalse();
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        print('🚨 Verification failed: ${e.message}');
        OthersHelper().showToast(e.message.toString(), cc.warningColor);
        String msg;
        _verificationErrorCode = e.code;
        switch (e.code) {
          case 'invalid-phone-number':
            msg = 'Invalid phone number. Please check format.';
            OthersHelper().showToast(msg, cc.warningColor);
            break;
          case 'too-many-requests':
            msg = 'Too many requests. SMS quota exceeded. Try after some time.';
            OthersHelper().showToast(msg, cc.warningColor);
            break;
          case 'quota-exceeded':
            msg = 'Too many requests. SMS quota exceeded. Try after some time.';
            OthersHelper().showToast(msg, cc.warningColor);
            break;
          case 'operation-not-allowed':
            msg = 'Phone authentication not enabled. Contact support.';
            OthersHelper().showToast(msg, cc.warningColor);
            break;
          default:
            msg = e.message ?? 'Something went wrong during verification.';
            OthersHelper().showToast(msg, cc.warningColor);
        }
        _verificationErrorMessage = msg;
        if (!completer.isCompleted) completer.complete(false);
        setLoadingFalse();
      },
      codeSent: (String verificationId, int? resendToken) {
        print('📨 OTP code sent – ID saved');
        _verificationId = verificationId;
        _resendToken = resendToken;
        OthersHelper()
            .showToast("OTP Code Successfully Sent!", cc.successColor);
        if (!completer.isCompleted) completer.complete(true);
        setLoadingFalse();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('⏰ Auto-retrieval timed out');
        _verificationId = verificationId;
        if (!completer.isCompleted) completer.complete(false);
        setLoadingFalse();
      },
    );
    bool result = await completer.future;
    setLoadingFalse();
    return result;
  }

  bool _isLoadingVerifyOTP = false;
  bool get isLoadingVerifyOTP => _isLoadingVerifyOTP;

  setIsLoading(bool value) {
    _isLoadingVerifyOTP = value;
    notifyListeners();
  }

  Future<UserCredential?> verifyOTP({
    required String verificationId,
    required String smsCode,
    required BuildContext context,
  }) async {
    setIsLoading(true);
    try {
      // Build the PhoneAuthCredential
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode.trim(),
      );
      debugPrint(
          '🔐 Verifying OTP... ${verificationId} and otp ===>${smsCode} ');
      // Sign in with credential
      final userCredential = await auth.signInWithCredential(credential);
      debugPrint('✅ OTP verified — UID: ${userCredential.user?.uid}');
      OthersHelper().showToast("✅ OTP verified", cc.successColor);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      debugPrint('🚨 OTP verification failed: ${e.code} — ${e.message}');
      String msg;
      _verificationErrorCode = e.code;
      switch (e.code) {
        case 'invalid-verification-code':
          msg = 'Invalid OTP code entered';
          break;
        case 'session-expired':
        case 'code-expired':
          msg = 'OTP session expired. Request a new one.';
          break;
        default:
          msg = 'OTP verification failed. Please try again.';
      }
      _verificationErrorMessage = msg;
      notifyListeners();
      OthersHelper().showToast(msg, cc.warningColor);
      return null;
    } catch (e) {
      debugPrint('❌ Unexpected error during OTP verification: $e');
      OthersHelper().showCompactSuccessDialog2(context,
          messageType: "Error",
          messageTitle: "Error",
          message: "An unexpected error occurred",
          image: "assets/icons/error.gif",
          onTap: () => Navigator.pop(context));
      return null;
    } finally {
      setIsLoading(false);
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
          AppLocalizations.of(context)!.checkYourNetworkConnections,
          ConstantColors().warningColor);
      return _otpResponseModel;
    }
    PushNotifications.isTokenRefreshed();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var deviceToken = prefs.getString('sashaktNirmaanDeviceToken') ?? '';
    await SharedPreferences.getInstance();
    prefs.setBool('intro', true);
    setLoading2();

    var data = jsonEncode({
      'phone': mobile,
      'otp': otp,
      'user_type': userType,
      'device_token': deviceToken.toString(),
    });
    print("otv verify body =====> $data");
    var header = {
      "Accept": "application/json",
      "Content-Type": "application/json"
    };

    try {
      // String url = '$baseApi/login';
      String url = '$baseApi/user-login';
      final response =
          await http.post(Uri.parse(url), body: data, headers: header);
      print("actual raw response ====> ${response.body}");
      if (response.statusCode == 201) {
        print("actaul reponse====> ${response.body}");
        _otpResponseModel =
            OtpResponseModel.fromJson(jsonDecode(response.body));
        print("token genaeka====> ${_otpResponseModel.token}");
        String token = _otpResponseModel.token ?? '';
        dynamic userId =
            _otpResponseModel.user != null ? _otpResponseModel.user!.id : 0;
        String state = _otpResponseModel.user?.state.toString() ?? '';
        String countryId = _otpResponseModel.user?.countryId.toString() ?? '';

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
    } catch (e, stackTrace) {
      debugPrint("Error during HTTP request: $e, stackTrace ====> $stackTrace");
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
