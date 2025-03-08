import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qixer/model/CategoryDataModel.dart';
import 'package:qixer/service/common_service.dart';
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
    }

    var connection = await checkConnection();
    if (connection) {
      var response = await http.get(
          Uri.parse('$baseApi/category?cat_area_id=${location_id.toString()}'));
      print(
          "acutal cat list ====> ${response.body}  ${location_id.toString()} ");
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
          print(
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
}
