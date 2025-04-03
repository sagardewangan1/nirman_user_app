import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/model/navigationModel.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/dropdowns_services/area_dropdown_service.dart';
import 'package:qixer/service/dropdowns_services/country_dropdown_service.dart';
import 'package:qixer/service/dropdowns_services/state_dropdown_services.dart';
import 'package:qixer/service/getImageController.dart';
import 'package:qixer/view/chooseCategory/chooseCategorView.dart';
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

  Future<bool> signupvendor(
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
      {String? imagePath} // Single image path
      ) async {
    var connection = await checkConnection();
    if (!connection) {
      return false;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');
    if (token == null || token == '') {
      print("❌ Token not found. User not authenticated.");
      return false;
    }
    setLoadingTrue();

    String url = '$baseApi/register_seller';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // ✅ Headers
      request.headers.addAll({
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      });

      // ✅ Body Fields
      request.fields.addAll({
        'name': fullName,
        'email': email,
        'phone': phone ?? '',
        'businessName': businessName,
        'businessGstNumber': businessGstNumber,
        'businessPhoneNumber': businessPhoneNumber,
        'businessEmail': businessEmail,
        'businessFullAddress': businessFullAddress,
        'businessDescription': businessDescription,
        'service_city':
            Provider.of<StateDropdownService>(context, listen: false)
                .selectedStateId
                .toString(),
        // 'service_area': Provider.of<AreaDropdownService>(context, listen: false)
        //     .selectedAreaId
        //     .toString(),s
        'country_id':
            Provider.of<CountryDropdownService>(context, listen: false)
                .selectedCountryId
                .toString(),
        'terms_conditions': '1',
        'country_code': countryCode ?? '',
        "service_area_id":
            Provider.of<AreaDropdownService>(context, listen: false)
                .selectedAreaId
                .toString(),
      });

      if (imagePath != null && imagePath.isNotEmpty) {
        File file = File(imagePath);
        if (await file.exists()) {
          request.files.add(
            await http.MultipartFile.fromPath('file', file.path),
          );
        } else {
          print("⚠️ Image file not found at path: $imagePath");
        }
      }

      // ✅ Debugging Logs
      print("➡️ Request URL: $url");
      print("➡️ Request Headers: ${request.headers}");
      print("➡️ Request Fields: ${request.fields}");
      print(
          "➡️ Request Files: ${request.files.map((f) => f.filename).toList()}");

      // ✅ Send Request
      http.StreamedResponse response =
          await request.send().timeout(const Duration(seconds: 10));

      String responseBody = await response.stream.bytesToString();

      print("➡️ Response Status Code: ${response.statusCode}");
      print("➡️ Response Body: ${responseBody}");

      setLoadingFalse();

      if (response.statusCode == 201 || response.statusCode == 200) {
        OthersHelper().showToast(
            "Registration successful", ConstantColors().successColor);
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('shashaktnirman_is_logged_in', true);
        Provider.of<GetImageController>(context, listen: false).removeFile();
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => ChooseCategoryView(
              navigationModel: NavigationModel(navFrom: "SignUp"),
            ),
          ),
        );
        return true;
      } else {
        // ❌ Handle Errors
        var decodedResponse = jsonDecode(responseBody);
        if (decodedResponse.containsKey('errors')) {
          showError(decodedResponse['errors']);
        } else {
          OthersHelper().showToast(decodedResponse['message'], Colors.black);
        }
        return false;
      }
    } on SocketException {
      setLoadingFalse();
      print("❌ No internet connection.");
      return false;
    } catch (e) {
      setLoadingFalse();
      print('❌ Exception: $e');
      return false;
    }
  }

  Future<bool> updateBusinessProfile(
      String businessName,
      String businessGstNumber,
      String businessPhoneNumber,
      String businessEmail,
      String businessFullAddress,
      String businessDescription,
      BuildContext context,
      {String? imagePath}) async {
    var connection = await checkConnection();
    if (!connection) {
      return false;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');
    if (token == null) {
      print("❌ Token not found. User not authenticated.");
      return false;
    }
    setLoadingTrue();
    String url = '$baseApi/seller/profile/edit';
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll({
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });
      request.fields.addAll({
        'businessName': businessName,
        'businessGstNumber': businessGstNumber,
        'businessPhoneNumber': businessPhoneNumber,
        'businessEmail': businessEmail,
        'businessFullAddress': businessFullAddress,
        'businessDescription': businessDescription,
        // 'service_city':
        //     Provider.of<StateDropdownService>(context, listen: false)
        //         .selectedStateId
        //         .toString(),
        // 'service_area': Provider.of<AreaDropdownService>(context, listen: false)
        //     .selectedAreaId
        //     .toString(),
        // 'country_id':
        //     Provider.of<CountryDropdownService>(context, listen: false)
        //         .selectedCountryId
        //         .toString(),
        // 'country_code': countryCode ?? '',
        // "service_area_id":
        //     "[${context.read<AreaDropdownService>().selectedCityID.map((e) => '"$e"').join(",")}]",
      });
      if (imagePath != null && imagePath.isNotEmpty) {
        File file = File(imagePath);
        if (await file.exists()) {
          request.files.add(
            await http.MultipartFile.fromPath('image', file.path),
          );
        } else {
          print("⚠️ Image file not found at path: $imagePath");
        }
      }
      print("➡️ Request URL: $url");
      print("➡️ Request Headers: ${request.headers}");
      print("➡️ Request Fields: ${request.fields}");
      print(
          "➡️ Request Files: ${request.files.map((f) => f.filename).toList()}");
      http.StreamedResponse response =
          await request.send().timeout(const Duration(seconds: 10));
      String responseBody = await response.stream.bytesToString();
      print("➡️ Response Status Code: ${response.statusCode}");
      print("➡️ Response Body: $responseBody");
      setLoadingFalse();
      if (response.statusCode == 200 || response.statusCode == 201) {
        OthersHelper().showToast(
            "Profile updated successfully", ConstantColors().successColor);
        Provider.of<GetImageController>(context, listen: false).removeFile();
        return true;
      } else {
        var decodedResponse = jsonDecode(responseBody);
        if (decodedResponse.containsKey('errors')) {
          showError(decodedResponse['errors']);
        } else {
          OthersHelper().showToast(decodedResponse['message'], Colors.black);
        }
        return false;
      }
    } on SocketException {
      setLoadingFalse();
      print("❌ No internet connection.");
      return false;
    } catch (e) {
      setLoadingFalse();
      print('❌ Exception: $e');
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
