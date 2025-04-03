import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/model/CategoryDataModel.dart';
import 'package:qixer/model/categoryModel.dart';
import 'package:qixer/model/sub_category_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/jobs_service/recent_jobs_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryService with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // var categories;

  CategoryDataModel _categoryDataModel = CategoryDataModel();
  CategoryDataModel get categoryDataModel => _categoryDataModel;

  var categoriesDropdownList = [];

  fetchCategory({String location_id = ''}) async {
    _isLoading = true;
    if (_categoryDataModel.categories is List) {
      _categoryDataModel.categories?.clear();
      notifyListeners();
    }

    var connection = await checkConnection();
    if (connection) {
      String url =
          '$baseApi/category?cat_area_id=${location_id != 'null' ? location_id.toString() : ''}';
      var response = await http.get(Uri.parse(url));
      print("cat list url ======> $url");
      if (response.statusCode == 200) {
        _categoryDataModel =
            CategoryDataModel.fromJson(jsonDecode(response.body));
        // ✅ Add all categories directly to the list (Flatten the data)
        categoriesDropdownList.addAll(_categoryDataModel.categories ?? []);

        _isLoading = false;
        notifyListeners();
      } else {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  final List<String> _selectedCatList = [];

  List<String> get selectedCatList => _selectedCatList;

  addCategory(String catId) {
    if (!_selectedCatList.contains(catId)) {
      _selectedCatList.add(catId);
    } else {
      _selectedCatList.remove(catId);
    }
    notifyListeners();
  }

  clearLists() {
    if (_categoryDataModel.categories is List) {
      _categoryDataModel.categories?.clear();
    }
    _selectedCatList.clear();
    _catIds.clear();
  }

  bool _isExpanded = false;
  bool get isExpanded => _isExpanded;

  setExpanded() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }

  Future<bool> setCategoryForSeller() async {
    var connection = await checkConnection();
    if (!connection) {
      return false;
    }
    _isLoading = true;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');
    if (token == null) {
      print("❌ Token not found. User not authenticated.");
      return false;
    }
    try {
      String url = "$baseApi/seller/service/add-seller-category";
      var headers = {
        // "Accept": "application/json",
        // "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      var body = {
        "categories":
            jsonEncode(_selectedCatList), // Convert list to JSON array
      };

      var response =
          await http.post(Uri.parse(url), body: body, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = jsonDecode(response.body);
        if (responseData["status"] == true) {
          _isLoading = false;
          notifyListeners();
          return true;
        } else {
          debugPrint(
              "⚠️ API response status is false: ${responseData["message"] ?? "No message"}");
          _isLoading = false;
          notifyListeners();
          return false;
        }
      }
    } catch (e) {
      print("❌ Exception: $e");
      _isLoading = false;
      notifyListeners();
    }
    return false;
  }

  List<Map<String, dynamic>> _catIds = [];
  List<Map<String, dynamic>> get catIds => _catIds;

  void addCategoryInList({Categories? category}) {
    if (category?.id == null) {
      // debugPrint("❌ `Skipping, categoryId is NULL");
      return;
    }

    int catIndex =
        _catIds.indexWhere((element) => element["catId"] == category?.id);

    if (catIndex != -1) {
      _catIds.removeAt(catIndex);
    } else {
      // ✅ Add category with empty subcategory list
      _catIds.add({
        "catId": category?.id,
        "name": category?.name,
        "mobile_icon": category?.mobileIcon,
        "subCatIds": [],
      });
      // debugPrint("✅ Added new category: ${category?.id}");
    }

    notifyListeners();
    // debugPrint("📌 Final _catIds list: $_catIds");
  }

  void addSubCategoryInList(
      {required int categoryId, required Subcategories subCategory}) {
    int catIndex =
        _catIds.indexWhere((element) => element["catId"] == categoryId);

    if (catIndex == -1) {
      debugPrint("⚠️ Cannot add subcategory, category not found: $categoryId");
      return;
    }

    List<Map<String, dynamic>> subCatList =
        List<Map<String, dynamic>>.from(_catIds[catIndex]["subCatIds"]);

    int subCatIndex =
        subCatList.indexWhere((element) => element["id"] == subCategory.id);

    if (subCatIndex == -1) {
      // ➕ Add new subcategory
      subCatList.add({
        "id": subCategory.id,
        "name": subCategory.name,
        "image": subCategory.image,
      });
      // debugPrint("➕ Added subcategory to categoryId: $categoryId");
    } else {
      // ❌ Remove existing subcategory
      subCatList.removeAt(subCatIndex);
      // debugPrint("❌ Removed subcategory from categoryId: $categoryId");
    }

    _catIds[catIndex]["subCatIds"] = subCatList;
    notifyListeners();
    // debugPrint("📌 Final _catIds list: $_catIds");
  }

  void setClearList() {
    _catIds.clear();
    notifyListeners();
  }

  bool _isLoading2 = false;
  bool get isLoading2 => _isLoading2;

  printLargeResponse(String responseBody) {
    const int chunkSize = 1000; // Ek bar me sirf 1000 characters print honge
    for (int i = 0; i < responseBody.length; i += chunkSize) {
      print(responseBody.substring(
          i,
          i + chunkSize > responseBody.length
              ? responseBody.length
              : i + chunkSize));
    }
  }

  Future<bool> addServiceByCategory(BuildContext context,
      {bool isFromLoginPage = true}) async {
    try {
      var connection = await checkConnection();
      if (!connection) {
        print("❌ No internet connection.");
        return false;
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('shashaktnirmantoken');
      if (token == null) {
        print("❌ Token not found.");
        return false;
      }

      _isLoading2 = true;
      notifyListeners();

      var headers = {
        "Accept": "application/json",
        'Content-Type': 'application/x-www-form-urlencoded',
        // "Content-Type": "application/json", // ✅ Correct format for JSON
        "Authorization": "Bearer $token"
      };

      var body = jsonEncode({"service_cat_subcat_id": _catIds});
      var encodedBody = {"service_cat_subcat_id": body};
      String url = "$baseApi/seller/service/add-service";

      print("➡️ Sending HTTP Request...");
      print("🔹 URL: $url");
      print("🔹 Headers: $headers");
      print("🔹 Body: $body");
      print("🔹 encoded body: $encodedBody");

      // ✅ Await the HTTP request properly
      final response = await http.post(
        Uri.parse(url),
        body: encodedBody,
        headers: headers,
      );

      print("✅ Response Status Code: ${response.statusCode}");
      print("✅ Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("🎉 Service added successfully!");
        _isLoading2 = false;
        notifyListeners();
        return true;
      } else {
        print("❌ API Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e, stackTrace) {
      print("❌ Exception while sending request: $e");
      print("📌 StackTrace: $stackTrace");
    }

    _isLoading2 = false;
    notifyListeners();
    return false;
  }

  Future<bool> updateServiceByCategory(
    BuildContext context,
    var body,
  ) async {
    try {
      var connection = await checkConnection();
      if (!connection) {
        print("❌ No internet connection.");
        return false;
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('shashaktnirmantoken');
      if (token == null) {
        print("❌ Token not found.");
        return false;
      }

      _isLoading2 = true;
      notifyListeners();

      var headers = {
        "Accept": "application/json",
        'Content-Type': 'application/x-www-form-urlencoded',
        // "Content-Type": "application/json", // ✅ Correct format for JSON
        "Authorization": "Bearer $token"
      };

      String url = "$baseApi/seller/service/update-service";

      print("➡️ Sending HTTP Request...");
      print("🔹 URL: $url");
      print("🔹 Headers: $headers");
      print("🔹 Body: $body");
      print("🔹 encoded body: $body");

      // ✅ Await the HTTP request properly
      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: headers,
      );

      print("✅ Response Status Code: ${response.statusCode}");
      print("✅ Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("🎉 Service added successfully!");
        Provider.of<RecentJobsService>(context, listen: false)
            .selectedCityIds
            .clear();
        _isLoading2 = false;
        notifyListeners();
        return true;
      } else {
        print("❌ API Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e, stackTrace) {
      print("❌ Exception while sending request: $e");
      print("📌 StackTrace: $stackTrace");
    }

    _isLoading2 = false;
    notifyListeners();
    return false;
  }
}
