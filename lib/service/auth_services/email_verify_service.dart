import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/helper/extension/string_extension.dart';
import 'package:qixer/service/auth_services/login_service.dart';
import 'package:qixer/service/auth_services/reset_password_service.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/view/utils/others_helper.dart';

import '../push_notification_service.dart';

class EmailVerifyService with ChangeNotifier {
  bool isloading = false;

  bool verifyOtpLoading = false;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  Future<bool> sendOtpForEmailValidation(
      email, BuildContext context, token) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      OthersHelper()
          .showToast("Please turn on your internet connection", Colors.black);
      return false;
    } else {
      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        "Content-Type": "application/json",
      };
      var data = jsonEncode({
        'email': email,
      });

      var response = await http.post(Uri.parse('$baseApi/send-otp-in-mail'),
          headers: header, body: data);
      if (response.statusCode == 201) {
        var otpNumber = jsonDecode(response.body)['otp'];
        Provider.of<ResetPasswordService>(context, listen: false)
            .setOtp(otpNumber);

        debugPrint('otp is $otpNumber');
        notifyListeners();

        return true;
      } else {
        debugPrint(response.body.toString());
        jsonDecode(response.body)['message']?.toString().showToast();

        return false;
      }
    }
  }

  verifyOtpAndLogin(enteredOtp, BuildContext context, email, token, userId,
      state, countryId) async {
    var otpNumber =
        Provider.of<ResetPasswordService>(context, listen: false).otpNumber;
    if (otpNumber != null) {
      if (enteredOtp == otpNumber) {
        //Set Loading true
        verifyOtpLoading = true;
        notifyListeners();

        var header = {
          //if header type is application/json then the data should be in jsonEncode method
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        };
        var data = jsonEncode({'user_id': userId, 'email_verified': 1});

        var response = await http.post(
            Uri.parse('$baseApi/user/send-otp-in-mail/success'),
            headers: header,
            body: data);

        //Set loading false
        verifyOtpLoading = false;
        notifyListeners();

        if (response.statusCode >= 200 && response.statusCode < 300) {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute<void>(
          //     builder: (BuildContext context) => const LandingPage(),
          //   ),
          //save the details for later login
          LoginService().saveDetails(email, token, userId, state, countryId);
          // );
          await Provider.of<ProfileService>(context, listen: false)
              .fetchData(context);
          await Provider.of<PushNotificationService>(context, listen: false)
              .fetchPusherCredential(context: context);

          context.popTrue;
          context.popTrue;
        } else {
          debugPrint(response.body.toString());
          OthersHelper().showToast(
              'Your entered the otp correctly but something went wrong. Please try again later',
              Colors.black);
        }
      } else {
        OthersHelper().showToast("Otp didn't match", Colors.black);
      }
    } else {
      OthersHelper().showToast('Otp is null', Colors.black);
    }
  }
}

// Navigator.pushReplacement(
//           context,
//           MaterialPageRoute<void>(
//             builder: (BuildContext context) => ResetPasswordPage(
//               email: email,
//             ),
//           ),
//         );
