import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/dropdowns_services/area_dropdown_service.dart';
import 'package:qixer/service/dropdowns_services/country_dropdown_service.dart';
import 'package:qixer/service/dropdowns_services/state_dropdown_services.dart';
import 'package:qixer/view/home/landing_page.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupVendorService with ChangeNotifier {
  int selectedPage = 0;
  late PageController _pageController = PageController();
  PageController get pagecontroller => _pageController;
  bool isloading = false;

  String phoneNumber = '0';
  String countryCode = 'IN';

  setPhone(value) {
    phoneNumber = value;
    notifyListeners();
  }

  setCountryCode(code) {
    countryCode = code;
    notifyListeners();
  }

  setPageController(PageController controller) {
    _pageController = controller;
    print('PageController initialized: $controller');
    notifyListeners();
  }

  setSelectedPage(int i) {
    selectedPage = i;
    notifyListeners();
  }

  setSelectedPageO(int i) {
    selectedPage = i;
  }

  prevPage(int i) {
    selectedPage = i;
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

  bool _readOnly = false;
  bool get readOnly => _readOnly;
  setReadOnly(bool value) {
    _readOnly = value;
    notifyListeners();
  }

  Future signupvendor(
    String fullName,
    String email,
    String? phone,
    String businessName,
    String businessGstNumber,
    String businessPhoneNumber,
    String businessEmail,
    String businessFullAddress,
    String businessDescription,
    BuildContext context,
  ) async {
    var connection = await checkConnection();

    if (connection) {
      setLoadingTrue();

      //   seller body
      //   'name' => 'required|max:191',
      // 'email' => 'required|email|unique:users|max:191',
      // 'phone' => 'required|max:191',
      // 'businessName'=> 'required|max:250',
      // 'businessGstNumber'=> 'required|max:15',
      // 'businessPhoneNumber'=> 'required|max:12',
      // 'businessEmail'=> 'required|unique:users|max:150',
      // 'businessFullAddress'=> 'required|max:250',
      // 'businessDescription'=> 'required|max:250',
      // 'service_city' => 'required',
      // 'service_area' => 'required',
      // 'country_id' => 'required',
      // 'terms_conditions' => 'required'

      var data = jsonEncode({
        'name': fullName,
        'email': email,
        'businessName': businessName,
        'phone': phone,
        "businessGstNumber": businessGstNumber,
        "businessPhoneNumber": businessPhoneNumber,
        "businessEmail": businessEmail,
        "businessFullAddress": businessFullAddress,
        "businessDescription": businessDescription,
        // 'password': password,
        'service_city':
            Provider.of<StateDropdownService>(context, listen: false)
                .selectedStateId,
        'service_area': Provider.of<AreaDropdownService>(context, listen: false)
            .selectedAreaId,
        'country_id':
            Provider.of<CountryDropdownService>(context, listen: false)
                .selectedCountryId,
        'terms_conditions': 1,
        'country_code': countryCode,
      });
      print("body ======> $data");
      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        "Content-Type": "application/json"
      };

      var response = await http.post(Uri.parse('$baseApi/register_seller'),
          body: data, headers: header);
      print("response==> ${response.body}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        setLoadingFalse();
        OthersHelper().showToast(
            "Registration successful", ConstantColors().successColor);
        debugPrint(response.body.toString());
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const LandingPage(),
          ),
        );

        // String token = jsonDecode(response.body)['token'];
        // int userId = jsonDecode(response.body)['users']['id'];
        // String state = jsonDecode(response.body)['users']['state'].toString();
        // String countryId =
        //     jsonDecode(response.body)['users']['country_id'].toString();
        //
        // //Send otp
        // var isOtepSent =
        //     await Provider.of<EmailVerifyService>(context, listen: false)
        //         .sendOtpForEmailValidation(email, context, token);
        // setLoadingFalse();
        // if (isOtepSent) {
        //   Navigator.pushReplacement<void, void>(
        //     context,
        //     MaterialPageRoute<void>(
        //       builder: (BuildContext context) => EmailVerifyPage(
        //         email: email,
        //         token: token,
        //         userId: userId,
        //         state: state,
        //         countryId: countryId,
        //       ),
        //     ),
        //   );
        // } else {
        //   OthersHelper().showToast('Otp send failed', Colors.black);
        // }
        return true;
      } else {
        //Sign up unsuccessful ==========>
        if (jsonDecode(response.body).containsKey('errors')) {
          showError(jsonDecode(response.body)['errors']);
        } else {
          OthersHelper()
              .showToast(jsonDecode(response.body)['message'], Colors.black);
        }
        setLoadingFalse();
        return false;
      }
    } else {
      //internet connection off
      return false;
    }
  }

  Future updateBusinessProfile(
    String businessName,
    String businessGstNumber,
    String businessPhoneNumber,
    String businessEmail,
    String businessFullAddress,
    String businessDescription,
    BuildContext context,
  ) async {
    var connection = await checkConnection();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');

    if (connection) {
      setLoadingTrue();

      var data = jsonEncode({
        'businessName': businessName,
        "businessGstNumber": businessGstNumber,
        "businessPhoneNumber": businessPhoneNumber,
        "businessEmail": businessEmail,
        "businessFullAddress": businessFullAddress,
        "businessDescription": businessDescription,
        // 'password': password,
        'service_city':
            Provider.of<StateDropdownService>(context, listen: false)
                .selectedStateId,
        'service_area': Provider.of<AreaDropdownService>(context, listen: false)
            .selectedAreaId,
        'country_id':
            Provider.of<CountryDropdownService>(context, listen: false)
                .selectedCountryId,
        'country_code': countryCode,
      });
      print("body ======> $data");
      var header = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      var response = await http.post(Uri.parse('$baseApi/seller/profile/edit'),
          body: data, headers: header);

      if (response.statusCode == 201 || response.statusCode == 200) {
        setLoadingFalse();
        OthersHelper().showToast(
            "Registration successful", ConstantColors().successColor);
        debugPrint(response.body.toString());
        // Navigator.pushReplacement<void, void>(
        //   context,
        //   MaterialPageRoute<void>(
        //     builder: (BuildContext context) => const LandingPage(),
        //   ),
        // );

        // String token = jsonDecode(response.body)['token'];
        // int userId = jsonDecode(response.body)['users']['id'];
        // String state = jsonDecode(response.body)['users']['state'].toString();
        // String countryId =
        //     jsonDecode(response.body)['users']['country_id'].toString();
        //
        // //Send otp
        // var isOtepSent =
        //     await Provider.of<EmailVerifyService>(context, listen: false)
        //         .sendOtpForEmailValidation(email, context, token);
        // setLoadingFalse();
        // if (isOtepSent) {
        //   Navigator.pushReplacement<void, void>(
        //     context,
        //     MaterialPageRoute<void>(
        //       builder: (BuildContext context) => EmailVerifyPage(
        //         email: email,
        //         token: token,
        //         userId: userId,
        //         state: state,
        //         countryId: countryId,
        //       ),
        //     ),
        //   );
        // } else {
        //   OthersHelper().showToast('Otp send failed', Colors.black);
        // }
        return true;
      } else {
        if (jsonDecode(response.body).containsKey('errors')) {
          showError(jsonDecode(response.body)['errors']);
        } else {
          OthersHelper()
              .showToast(jsonDecode(response.body)['message'], Colors.black);
        }
        setLoadingFalse();
        return false;
      }
    } else {
      //internet connection off
      return false;
    }
  }

  showError(error) {
    if (error.containsKey('email')) {
      OthersHelper().showToast(error['email'][0], Colors.black);
    } else if (error.containsKey('username')) {
      OthersHelper().showToast(error['username'][0], Colors.black);
    } else if (error.containsKey('phone')) {
      OthersHelper().showToast(error['phone'][0], Colors.black);
    } else if (error.containsKey('password')) {
      OthersHelper().showToast(error['password'][0], Colors.black);
    } else {
      OthersHelper().showToast('Something went wrong', Colors.black);
    }
  }

  int totalLength = 500;
  int _currentOverviewLength = 0;
  int get currentOverviewLength => _currentOverviewLength;

  setOverviewLength(value) {
    _currentOverviewLength = value;
    notifyListeners();
  }
}
