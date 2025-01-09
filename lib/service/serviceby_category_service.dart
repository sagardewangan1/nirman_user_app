import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/data/network/network_api_services.dart';
import 'package:qixer/model/serviceby_category_model.dart';
import 'package:qixer/model/sub_category_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/db/db_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';

class ServiceByCategoryService with ChangeNotifier {
  var serviceMap = [];
  bool alreadySaved = false;
  bool hasError = false;

  List<SubCategory> subCatList = [];
  SubCategory? selectedSubCat;
  var currentCategory;

  late int totalPages;

  int currentPage = 1;
  var alreadyAddedtoFav = false;
  List averageRateList = [];
  List imageList = [];

  setCurrentPage(newValue) {
    currentPage = newValue;
    // notifyListeners();
  }

  setTotalPage(newPageNumber) {
    totalPages = newPageNumber;
    notifyListeners();
  }

  selectSubCategory(context, categoryId, name) {
    try {
      selectedSubCat = subCatList.firstWhere((element) => element.name == name);
      serviceMap = [];
      currentPage = 1;

      imageList = [];
      hasError = false;
      fetchCategoryService(context, categoryId, isrefresh: true);
    } catch (e) {}
  }

  setEverythingToDefault() {
    serviceMap = [];
    currentPage = 1;
    selectedSubCat = null;
    subCatList = [];
    averageRateList = [];
    imageList = [];
    hasError = false;
    notifyListeners();
  }

  fetchCategoryService(context, categoryId, {bool isrefresh = false}) async {
    //=================>
    String apiLink;
    apiLink =
        '$baseApi/service-list/category-subcategory-rating-sort-by-search/?cat=$categoryId&subcat=${selectedSubCat?.id ?? ""}&page=$currentPage';
    //====================>

    if (isrefresh) {
      //making the list empty first to show loading bar (we are showing loading bar while the product list is empty)
      //we are make the list empty when the sub category or brand is selected because then the refresh is true
      serviceMap = [];
      notifyListeners();

      Provider.of<ServiceByCategoryService>(context, listen: false)
          .setCurrentPage(1);
    } else {
      // if (currentPage > 2) {
      //   refreshController.loadNoData();
      //   return false;
      // }
    }
    // serviceMap = [];
    // Future.delayed(const Duration(microseconds: 500), () {
    //   notifyListeners();
    // });
    var connection = await checkConnection();
    if (connection) {
      //if connection is ok
      var response = await http.get(Uri.parse(apiLink));

      debugPrint(response.body.toString());

      // var jsonDataServiceList =
      //     jsonDecode(response.body)['all_services']['data'];

      if (response.statusCode == 201) {
        var data = ServicebyCategoryModel.fromJson(jsonDecode(response.body));
        imageList = [];
        setTotalPage(data.allServices.lastPage);

        for (int i = 0; i < data.allServices.data.length; i++) {
          String? serviceImage;

          if (data.serviceImage.length > i) {
            serviceImage = data.serviceImage[i]?.imgUrl;
          } else {
            serviceImage = null;
          }

          int totalRating = 0;
          for (int j = 0;
              j < data.allServices.data[i].reviewsForMobile.length;
              j++) {
            totalRating = totalRating +
                data.allServices.data[i].reviewsForMobile[j].rating!.toInt();
          }
          double averageRate = 0;

          if (data.allServices.data[i].reviewsForMobile.isNotEmpty) {
            averageRate = (totalRating /
                data.allServices.data[i].reviewsForMobile.length);
          }
          averageRateList.add(averageRate);
          imageList.add(serviceImage);
        }

        if (isrefresh) {
          //if refreshed, then remove all service from list and insert new data
          setServiceList(
              data.allServices.data, averageRateList, imageList, false);
        } else {
          //else add new data
          setServiceList(
              data.allServices.data, averageRateList, imageList, true);
        }

        currentPage++;
        setCurrentPage(currentPage);
        return true;
      } else {
        if (serviceMap.isEmpty) {
          hasError = true;
          notifyListeners();
        }
        notifyListeners();
        return false;
      }
    }
  }

  setServiceList(data, averageRateList, imageList, bool addnewData) {
    if (addnewData == false) {
      //make the list empty first so that existing data doesn't stay
      serviceMap = [];
      notifyListeners();
    }

    for (int i = 0; i < data.length; i++) {
      serviceMap.add({
        'serviceId': data[i].id,
        'title': data[i].title,
        'sellerName': data[i].sellerForMobile.name,
        'price': data[i].price,
        'rating': averageRateList[i],
        'image': imageList[i],
        'isSaved': false,
        'sellerId': data[i].sellerId,
      });
      checkIfAlreadySaved(data[i].id, data[i].title,
          data[i].sellerForMobile.name, serviceMap.length - 1);
    }
  }

  checkIfAlreadySaved(serviceId, title, sellerName, index) async {
    var newListMap = serviceMap;
    alreadySaved = await DbService().checkIfSaved(serviceId, title, sellerName);
    newListMap[index]['isSaved'] = alreadySaved;
    serviceMap = newListMap;
    notifyListeners();
  }

  saveOrUnsave(int serviceId, String title, image, int price, String sellerName,
      double rating, int index, BuildContext context, sellerId) async {
    var newListMap = serviceMap;
    alreadySaved = await DbService().saveOrUnsave(serviceId, title,
        image ?? placeHolderUrl, price, sellerName, rating, context, sellerId);
    newListMap[index]['isSaved'] = alreadySaved;
    serviceMap = newListMap;
    notifyListeners();
    categoryServiceSaveUnsaveFromOtherPage(serviceId, title, sellerName);
  }

  categoryServiceSaveUnsaveFromOtherPage(
    int serviceId,
    String title,
    String sellerName,
  ) async {
    int? index;
    for (int i = 0; i < serviceMap.length; i++) {
      if (serviceMap[i]['serviceId'] == serviceId &&
          serviceMap[i]['title'] == title &&
          serviceMap[i]['sellerName'] == sellerName) {
        index = i;
        break;
      }
    }

    if (index != null) {
      //if that product exist in other page then change the saved button accordingly
      var newListMap = serviceMap;
      alreadySaved =
          await DbService().checkIfSaved(serviceId, title, sellerName);
      newListMap[index]['isSaved'] = alreadySaved;
      serviceMap = newListMap;
      notifyListeners();
    }
  }

  fetchSubcategoryList(catId) async {
    subCatList = [];
    var responseData = await NetworkApiServices().getApi(
        "$baseApi/category/sub-category/$catId", "Subcategory list",
        headers: commonAuthHeader);

    if (responseData != null) {
      debugPrint(responseData.toString());
      subCatList = SubcategoryModel.fromJson(responseData).subCategories;
      notifyListeners();
    }
  }
}
