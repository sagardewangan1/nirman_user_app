import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:qixer/model/MyServiceListDataModel.dart';
import 'package:qixer/service/common_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../view/utils/others_helper.dart';

class AddServiceController extends ChangeNotifier {
  Map<String, dynamic>? _selectedCategory;

  Map<String, dynamic>? get selectedCategory => _selectedCategory;

  bool _isSwitched = false;

  bool get isSwitched => _isSwitched;

  setSwitch(value) {
    _isSwitched = value;
    notifyListeners();
  }

  TimeOfDay? _selectedOpenTime;

  TimeOfDay? get selectedOpenTime => _selectedOpenTime;

  setOpenTime(TimeOfDay? value) {
    _selectedOpenTime = value;
    notifyListeners();
  }

  TimeOfDay? _selectedCloseTime;

  TimeOfDay? get selectedCloseTime => _selectedCloseTime;

  setCloseTime(TimeOfDay? value) {
    _selectedCloseTime = value;
    notifyListeners();
  }

  int totalLength = 500;
  int _currentOverviewLength = 0;

  int get currentOverviewLength => _currentOverviewLength;

  setOverviewLength(value) {
    _currentOverviewLength = value;
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _isLoading2 = false;

  bool get isLoading2 => _isLoading2;

  setLoadingTrue() {
    _isLoading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    _isLoading = false;
    notifyListeners();
  }

  // category
  String? _selectedCatIds = "0";
  String? get selectedCatIds => _selectedCatIds;

  String? _selectedCatName;
  String? get selectedCatName => _selectedCatName;

  // sub category
  String? _selectedSubIds;
  String? get selectedSubIds => _selectedSubIds;

  String? _selectedSubCatName;
  String? get selectedSubCatName => _selectedSubCatName;
// sub child category
  String? _selectedChildIds;
  String? get selectedChildIds => _selectedChildIds;

  String? _selectedChildCatName;
  String? get selectedChildCatName => _selectedChildCatName;

  void setCatId(dynamic catId) {
    _selectedCatIds = catId.toString();

    print("selected cat id ====> $_selectedCatIds or $catId");

    if (catId.toString() == '0') {
      _selectedSubIds = null;
      _selectedSubCatName = null; // ✅ Reset properly
      _selectedSubCategoryList.clear();
    }
    notifyListeners();
  }

  void setSubCatId(dynamic subCatId) {
    _selectedSubIds = subCatId;
    print(
        "sub cat ids===> ${_selectedSubIds.runtimeType} and ${subCatId.runtimeType}");
    notifyListeners();
  }

  void setChildCatId(childCatId) {
    _selectedChildIds = childCatId;
    notifyListeners();
  }

  List<dynamic> _selectedCategoryList = [];
  List<dynamic> get selectedCategoryList => _selectedCategoryList;

  List<dynamic> _selectedSubCategoryList = [];
  List<dynamic> get selectedSubCategoryList => _selectedSubCategoryList;

  List<dynamic> _selectedChildCategoryList = [];
  List<dynamic> get selectedChildCategoryList => _selectedChildCategoryList;

  Future<bool> getSelectedCategory(
      {String? category_id, String? subCategory_id}) async {
    setLoadingTrue();
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

    try {
      // String url =
      //     "$baseApi/seller/service/get-category?sub_category_id=$subCategory_id&category_id=$category_id";
      String url = "$baseApi/seller/service/get-category";
      if (category_id != null || subCategory_id != null) {
        List<String> queryParams = [];
        queryParams.add("category_id=$category_id");
        queryParams.add("sub_category_id=$subCategory_id");
        url += "?${queryParams.join("&")}";
      }

      var headers = {
        // "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
      print("headers===> $headers");
      setLoadingFalse();
      var response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData["status"] == true) {
          if (_selectedCategoryList.isEmpty && category_id == null) {
            _selectedCategoryList.clear();
            _selectedCategoryList
                .insert(0, {"id": 0, "name": "Select Category"});
            _selectedCategoryList.addAll(responseData['data']);
            // print("✅ Updated Categories: $_selectedCategoryList");
          }

          // ✅ Subcategory list ko hamesha update karo jab category ho
          if (category_id != null && category_id != '0') {
            _selectedSubCategoryList.clear();
            // _selectedSubCategoryList
            //     .insert(0, {"id": 0, "name": "Select Sub Category"});
            _selectedSubCategoryList.addAll(responseData['data']);
            // print("✅ Selected sub Categories: $_selectedSubCategoryList");
          }

          // ✅ Child category list ko hamesha update karo jab subCategory_id ho
          if ((subCategory_id != null && subCategory_id != '0') ||
              (_selectedSubIds != '0' && _selectedSubIds != null)) {
            _selectedChildCategoryList.clear();
            _selectedChildCategoryList.addAll(responseData['data']);
            print(
                "✅ Selected sub Categories child: $_selectedChildCategoryList");
          }

          setLoadingFalse();
          return true;
        } else {
          print(
              "⚠️ API response status is false: ${responseData["message"] ?? "No message"}");
        }
      }
    } catch (e) {
      print("❌ Exception: $e");
      setLoadingFalse();
    }
    return false;
  }

  Future<bool> addService(
      BuildContext context, var data, bool shashaktnirmanIsLoggedIn,
      {bool isFromLoginPage = true,
      String? imagePath, // Single image path
      required var images}) async {
    var connection = await checkConnection();
    if (!connection) {
      return false;
    }
    setLoadingTrue();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');
    if (token == null) {
      print("❌ Token not found.");
      return false;
    }
    // var sanitizedData = sanitizeData(data);

    String url = "$baseApi/seller/service/add-service";

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // ✅ Correct headers
      request.headers.addAll({
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });

      var sanitizedData = {
        "category_id": data["category_id"].toString(),
        "subcategory_id": data["subcategory_id"].toString(),
        "child_category_id": data["child_category_id"] != null
            ? data["child_category_id"].toString()
            : "0", // ✅ Send empty string instead of "null"
        "title": data["title"] ?? "",
        "description": data["description"] ?? "",
        "price": data["price"] != null
            ? data["price"].toString()
            : "0", // ✅ Ensure price is a string
        "service_city_id": data["service_city_id"]?.toString() ?? "",
        "service_area_id": data["service_area_id"] is List
            ? (data["service_area_id"] as List)
                .join(",") // ✅ Convert List to comma-separated string
            : data["service_area_id"]?.toString() ?? "",
        "experience": data["experience"] ?? "",
      };

      request.fields.addAll(
          sanitizedData.map((key, value) => MapEntry(key, value.toString())));

      // ✅ Handle Single Image Upload
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

      // ✅ Debugging Logs
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
        return true;
      } else {
        print('❌ Error: ${response.statusCode}');
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

  void resetCategories() {
    _selectedCatIds = "0"; // ✅ Reset category ID
    _selectedCatName = null; // ✅ Reset category name

    _selectedSubIds = null; // ✅ Reset subcategory ID
    _selectedSubCatName = null; // ✅ Reset subcategory name

    _selectedChildIds = null; // ✅ Reset child category ID
    _selectedChildCatName = null; // ✅ Reset child category name

    _selectedCategoryList.clear();
    _selectedSubCategoryList.clear();
    _selectedChildCategoryList.clear();

    notifyListeners(); // ✅ UI update karega
  }

  Map<String, dynamic>? _myServiceData;
  Map<String, dynamic>? get myServiceData => _myServiceData;

  Future<bool> getMyServiceById({String? serviceId}) async {
    _isLoading2 = true;
    notifyListeners();

    var connection = await checkConnection();
    if (!connection) {
      _isLoading2 = false;
      notifyListeners();
      return false;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');
    if (token == null) {
      print("❌ Token not found.");
      _isLoading2 = false;
      notifyListeners();
      return false;
    }

    String url = "$baseApi/seller/service/my-service-details/$serviceId";
    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    try {
      var response = await http.get(Uri.parse(url), headers: headers);

      if (kDebugMode) {
        print("📡 Request URL: $url");
        print("📡 Response Status Code: ${response.statusCode}");
        print("📜 Response Body: ${response.body}");
        print("📜 Request Headers: $headers");
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = jsonDecode(response.body);
        if (responseData['my_services'] != null) {
          _myServiceData = responseData['my_services'];
        }
        _isLoading2 = false;
        notifyListeners();
        return true;
      } else {
        print("❌ API Error: ${response.statusCode}");
        print("❌ API Response: ${response.body}");
      }
    } catch (e, stackTrace) {
      print("❌ Exception: $e and $stackTrace");
    }

    _isLoading2 = false;
    notifyListeners();
    return false;
  }

  Future<bool> updateService(
      BuildContext context, var data, bool shashaktnirmanIsLoggedIn,
      {bool isFromLoginPage = true,
      String? imagePath, // Single image path
      required var images}) async {
    var connection = await checkConnection();
    if (!connection) {
      return false;
    }
    setLoadingTrue();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');
    if (token == null) {
      print("❌ Token not found.");
      return false;
    }
    // var sanitizedData = sanitizeData(data);

    String url = "$baseApi/seller/service/update-service";

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // ✅ Correct headers
      request.headers.addAll({
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });

      var sanitizedData = {
        "service_id": data["service_id"].toString(),
        "category_id": data["category_id"].toString(),
        "subcategory_id": data["subcategory_id"].toString(),
        "child_category_id": data["child_category_id"] != null
            ? data["child_category_id"].toString()
            : "0", // ✅ Send empty string instead of "null"
        "title": data["title"] ?? "",
        "description": data["description"] ?? "",
        "price": data["price"] != null
            ? data["price"].toString()
            : "0", // ✅ Ensure price is a string
        "service_city_id": data["service_city_id"]?.toString() ?? "",
        "service_area_id": data["service_area_id"] is List
            ? (data["service_area_id"] as List)
                .join(",") // ✅ Convert List to comma-separated string
            : data["service_area_id"]?.toString() ?? "",
        "experience": data["experience"] ?? "",
      };

      request.fields.addAll(
          sanitizedData.map((key, value) => MapEntry(key, value.toString())));

      // ✅ Handle Image Upload (File or URL)
      if (imagePath != null && imagePath.isNotEmpty) {
        File file = File(imagePath);
        if (await file.exists()) {
          request.files.add(
            await http.MultipartFile.fromPath('image', file.path),
          );
        } else {
          print("⚠️ Image file not found at path: $imagePath");
        }
      } else if (images is String && images.startsWith("http")) {
        // ✅ If imagePath is empty and "images" is a URL, send it as a form field
        request.fields['image'] = images;
      }

      // // ✅ Handle Single Image Upload
      // if (imagePath != null && imagePath.isNotEmpty) {
      //   File file = File(imagePath);
      //
      //   if (await file.exists()) {
      //     request.files.add(
      //       await http.MultipartFile.fromPath('image', file.path),
      //     );
      //   } else {
      //     print("⚠️ Image file not found at path: $imagePath");
      //   }
      // }

      // ✅ Debugging Logs
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
        return true;
      } else {
        print('❌ Error: ${response.statusCode}');
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

  Future<bool> deleteService({String? serviceId}) async {
    _isLoading2 = true;
    notifyListeners();

    var connection = await checkConnection();
    if (!connection) {
      _isLoading2 = false;
      notifyListeners();
      return false;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');
    if (token == null) {
      print("❌ Token not found.");
      _isLoading2 = false;
      notifyListeners();
      return false;
    }

    String url =
        "$baseApi/seller/service/delete/service-with-all-attributes/$serviceId";
    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    try {
      var response = await http.post(Uri.parse(url), headers: headers);

      if (kDebugMode) {
        print("📡 Request URL: $url");
        print("📡 Response Status Code: ${response.statusCode}");
        print("📜 Response Body: ${response.body}");
        print("📜 Request Headers: $headers");
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        _isLoading2 = false;
        notifyListeners();
        return true;
      } else {
        print("❌ API Error: ${response.statusCode}");
        print("❌ API Response: ${response.body}");
      }
    } catch (e, stackTrace) {
      print("❌ Exception: $e and $stackTrace");
    }

    _isLoading2 = false;
    notifyListeners();
    return false;
  }
}

/// Out of class
Map<String, String> sanitizeData(Map<dynamic, dynamic> data) {
  Map<String, String> sanitizedData = {};
  data.forEach((key, value) {
    if (value != null) {
      sanitizedData[key.toString()] = value.toString().trim();
    }
  });
  return sanitizedData;
}

Map<String, String> sanitizeImages(Map<dynamic, dynamic> images) {
  Map<String, String> sanitizedImages = {};
  images.forEach((key, value) {
    if (value != null && value.toString().isNotEmpty) {
      sanitizedImages[key.toString()] = value.toString().trim();
    }
  });
  return sanitizedImages;
}

Map<String, String> sanitizeImageUrls(Map<dynamic, dynamic> imageUrls) {
  Map<String, String> sanitizedImageUrls = {};
  imageUrls.forEach((key, value) {
    if (value != null && value.toString().isNotEmpty) {
      sanitizedImageUrls[key.toString()] = value.toString().trim();
    }
  });
  return sanitizedImageUrls;
}
