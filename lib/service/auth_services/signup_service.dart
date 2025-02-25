import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/dropdowns_services/area_dropdown_service.dart';
import 'package:qixer/service/dropdowns_services/country_dropdown_service.dart';
import 'package:qixer/service/dropdowns_services/state_dropdown_services.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';

class SignupService with ChangeNotifier {
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
    // notifyListeners();
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

  Future<bool> signup(
    String fullName,
    String email,
    String userName,
    BuildContext context,
  ) async {
    var connection = await checkConnection();

    if (connection) {
      setLoadingTrue();

      //   user body
      //   'name' => 'required|max:191',
      // 'email' => 'required|email|unique:users|max:191',
      // 'phone' => 'required|max:191',
      // 'service_city' => 'required',
      // 'service_area' => 'required',
      // 'country_id' => 'required',
      // 'terms_conditions' => 'required'

      var data = jsonEncode({
        'name': fullName,
        'email': email,
        // 'username': userName,
        'phone': phoneNumber,
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
        'country_code': countryCode
      });

      print("signup user body===>$data");
      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        "Content-Type": "application/json"
      };

      var response = await http.post(Uri.parse('$baseApi/register_user'),
          body: data, headers: header);
      if (response.statusCode == 201 || response.statusCode == 200) {
        setLoadingFalse();
        OthersHelper().showToast(
            "Registration successful", ConstantColors().successColor);
        debugPrint("after registration ${response.body.toString()}");
        //Send otp
        // var isOtepSent =
        //     await Provider.of<EmailVerifyService>(context, listen: false)
        //         .sendOtpForEmailValidation(email, context, token);

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
}
