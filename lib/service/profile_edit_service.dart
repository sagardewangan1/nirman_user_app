import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/string_extension.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileEditService with ChangeNotifier {
  bool isloading = false;

  String countryCode = 'IN';

  setCountryCode(code) {
    countryCode = code ?? countryCode;
    // notifyListeners();
  }

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  final ImagePicker _picker = ImagePicker();
  Future pickImage() async {
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      return imageFile;
    } else {
      return null;
    }
  }

  updateProfile(name, email, phone, cityId, areaId, countryId, postCode,
      address, about, String? imagePath, context) async {
    setLoadingTrue();
    if (baseApi.toLowerCase().contains("qixer.bytesed.com")) {
      await Future.delayed(const Duration(seconds: 2));
      "This feature is turned off for demo app".showToast();
      setLoadingFalse();
      return false;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');

    print("Token profile===> $token");

    var dio = Dio();
    // dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Content-Type'] = 'multipart/form-data';
    dio.options.headers["Authorization"] = "Bearer $token";

    FormData formData;
    if (imagePath != null) {
      formData = FormData.fromMap({
        'name': name,
        'email': email,
        'phone': phone,
        'file': await MultipartFile.fromFile(imagePath,
            filename: 'profileImage$name$address$imagePath.jpg'),
        'service_city': cityId,
        'service_area': areaId,
        'country_id': countryId,
        'post_code': postCode,
        'address': address,
        'about': about,
        'country_code': countryCode
      });
    } else {
      formData = FormData.fromMap({
        'name': name,
        'email': email,
        'phone': phone,
        'service_city': cityId,
        'service_area': areaId,
        'country_id': countryId,
        'post_code': postCode,
        'address': address,
        'about': about,
        'country_code': countryCode
      });
    }
    var response = await dio.post(
      '$baseApi/user/update-profile',
      data: formData,
      options: Options(
        validateStatus: (status) {
          return true;
        },
      ),
    );
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 201) {
      setLoadingFalse();
      OthersHelper().showToast('Profile updated successfully', Colors.black);

      await Provider.of<ProfileService>(context, listen: false)
          .getProfileDetails(isFromProfileupdatePage: true, context: context);
      Navigator.pop(context);
      return true;
    } else {
      setLoadingFalse();

      OthersHelper().showToast('Something went wrong', Colors.black);
      return false;
    }
  }

  // Future submitSubscription(name, email, phone, cityId, areaId, countryId,
  //     postCode, address, about, context, File file, String filename) async {
  //   setLoadingTrue();

  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var token = prefs.getString('shashaktnirmantoken');

  //   ///MultiPart request
  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse(
  //         "https://nazmul.xgenious.com/qixer_with_api/api/v1/user/update-profile"),
  //   );
  //   Map<String, String> headers = {
  //     "Accept": "application/json",
  //     "Authorization": "Bearer $token",
  //     // "Content-type": "multipart/form-data"
  //   };
  //   request.files.add(
  //     http.MultipartFile(
  //       'file',
  //       file.readAsBytes().asStream(),
  //       file.lengthSync(),
  //       filename: filename,
  //       // contentType: MediaType('image','jpeg'),
  //     ),
  //   );
  //   request.headers.addAll(headers);
  //   request.fields.addAll({
  //     'name': 'ccc',
  //     'email': 'c@c',
  //     'phone': '554',
  //     'service_city': '2',
  //     'service_area': '2',
  //     'country_id': '2',
  //     'post_code': '222',
  //     'address': 'asdfa',
  //     'about': 'asdsfd'
  //   });
  //   var res = await request.send();
  //   setLoadingFalse();
  //   if (res.statusCode == 201) {
  //     Navigator.pop(context);
  //     Provider.of<ProfileService>(context, listen: false).getProfileDetails();
  //   } else {
  //     OthersHelper().showToast(
  //         'Something went wrong. status code ${res.statusCode}', Colors.black);
  //   }
  //   return true;
  // }
}
