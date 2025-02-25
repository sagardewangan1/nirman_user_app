import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qixer/model/categoryModel.dart';
import 'package:qixer/model/child_category_model.dart';
import 'package:qixer/model/sub_category_model.dart';
import 'package:qixer/view/utils/others_helper.dart';

import '../data/network/network_api_services.dart';

class FilterCategoryService with ChangeNotifier {
  CategoryModel? _categoryModel;
  SubcategoryModel? _subcategoryModel;
  ChildCategoryModel? _childCategoryModel;

  CategoryModel get categoryModel =>
      _categoryModel ?? CategoryModel(category: []);
  SubcategoryModel get subcategoryModel =>
      _subcategoryModel ?? SubcategoryModel(subCategories: []);
  ChildCategoryModel get childCategoryModel =>
      _childCategoryModel ?? ChildCategoryModel(childCategory: []);

  bool get shouldFC => _categoryModel == null;
  bool get shouldFS => _subcategoryModel == null;
  bool get shouldFCC => _subcategoryModel == null;

  bool subCatLoading = false;
  bool childCatLoading = false;

  fetchCategory({String? location}) async {
    var url = "$baseApi/category?cat_area_id=$location";
    try {
      final responseData = await NetworkApiServices().getApi(url, "Category");

      if (responseData != null) {
        var decodedData = jsonDecode(responseData['body']);

        if (decodedData != null && decodedData["category"] != null) {
          var tempData = CategoryModel.fromJson(decodedData);
          _categoryModel = tempData;
          return true;
        } else {
          debugPrint("Category data is null or invalid.");
          return false;
        }
      } else {
        debugPrint("Response is null");
        return false;
      }
    } catch (e) {
      debugPrint("Error: $e");
      return false;
    }
  }

  fetchSubcategory(catId) async {
    var url = "$baseApi/category/sub-category/$catId";
    subCatLoading = true;
    notifyListeners();
    final responseData = await NetworkApiServices().getApi(url, "Subcategory");

    if (responseData != null) {
      var tempData = SubcategoryModel.fromJson(responseData);
      _subcategoryModel = tempData;
    }
    subCatLoading = false;
    notifyListeners();
  }

  fetchChildCategory(childCatId) async {
    var url = "$baseApi/category/sub-category/child-category/$childCatId";
    childCatLoading = true;
    notifyListeners();
    final responseData =
        await NetworkApiServices().getApi(url, "Child-category");

    if (responseData != null) {
      var tempData = ChildCategoryModel.fromJson(responseData);
      _childCategoryModel = tempData;
    }
    childCatLoading = false;
    notifyListeners();
  }

  Category? getCat(name) {
    try {
      return categoryModel.category
          ?.firstWhere((element) => element.name == name);
    } catch (e) {}
    return null;
  }

  SubCategory? getSubCat(name) {
    try {
      return subcategoryModel.subCategories
          .firstWhere((element) => element.name == name);
    } catch (e) {}
    return null;
  }

  ChildCategory? getChildCat(name) {
    try {
      return childCategoryModel.childCategory
          .firstWhere((element) => element.name == name);
    } catch (e) {}
    return null;
  }
}
