import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qixer/model/service_models/seller_all_service_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/db/db_service.dart';
import 'package:qixer/view/utils/others_helper.dart';

class SellerAllServicesService with ChangeNotifier {
  var serviceMap = [];
  bool alreadySaved = false;
  bool hasError = false;

  late int totalPages;

  int currentPage = 1;
  var alreadyAddedtoFav = false;
  List averageRateList = [];

  setCurrentPage(newValue) {
    currentPage = newValue;
    notifyListeners();
  }

  setTotalPage(newPageNumber) {
    totalPages = newPageNumber;
    notifyListeners();
  }

  setEverythingToDefault() {
    serviceMap = [];
    currentPage = 1;
    averageRateList = [];
    hasError = false;
  }

  fetchSellerAllService(context, sellerId, {bool isrefresh = false}) async {
    //=================>

    if (isrefresh) {
      //making the list empty first to show loading bar (we are showing loading bar while the product list is empty)
      //we make the list empty when the sub category or brand is selected because then the refresh is true

      serviceMap = [];
      notifyListeners();

      setCurrentPage(1);
    } else {
      // if (currentPage > 2) {
      //   refreshController.loadNoData();
      //   return false;
      // }
    }
    if (!isrefresh && currentPage > totalPages) {
      return false;
    }

    var connection = await checkConnection();
    if (connection) {
      //if connection is ok

      String apiLink =
          '$baseApi/services-by-seller-id?seller_id=$sellerId?page=$currentPage';
      var response = await http.get(Uri.parse(apiLink));
      debugPrint(response.body.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = SellerAllServiceModel.fromJson(jsonDecode(response.body));

        setTotalPage(data.services.lastPage);

        for (int i = 0; i < data.services.data.length; i++) {
          int totalRating = 0;
          for (int j = 0;
              j < data.services.data[i].reviewsForMobile.length;
              j++) {
            totalRating = totalRating +
                data.services.data[i].reviewsForMobile[j].rating!.toInt();
          }
          double averageRate = 0;

          if (data.services.data[i].reviewsForMobile.isNotEmpty) {
            averageRate =
                (totalRating / data.services.data[i].reviewsForMobile.length);
          }
          averageRateList.add(averageRate);
        }

        if (isrefresh) {
          //if refreshed, then remove all service from list and insert new data
          setServiceList(data.services.data, averageRateList, false);
        } else {
          //else add new data
          setServiceList(data.services.data, averageRateList, true);
        }

        currentPage++;
        hasError = serviceMap.isEmpty;
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

  setServiceList(data, averageRateList, bool addnewData) {
    if (addnewData == false) {
      //make the list empty first so that existing data doesn't stay
      serviceMap = [];
      notifyListeners();
    }

    for (int i = 0; i < data.length; i++) {
      serviceMap.add({
        'serviceId': data[i].id,
        'title': data[i].title,
        'sellerName': data[i].sellerName ?? '',
        'price': data[i].price,
        'rating': averageRateList[i],
        'image': data[i].imageUrl,
        'isSaved': false,
        'sellerId': data[i].sellerId,
      });
      checkIfAlreadySaved(data[i].id, data[i].title, data[i].sellerName ?? '',
          serviceMap.length - 1);
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
      double rating, int index, BuildContext context, sellerId, exp) async {
    var newListMap = serviceMap;
    alreadySaved = await DbService().saveOrUnsave(
        serviceId,
        title,
        image ?? placeHolderUrl,
        price,
        sellerName,
        rating,
        context,
        sellerId,
        exp);
    newListMap[index]['isSaved'] = alreadySaved;
    serviceMap = newListMap;
    notifyListeners();
  }
}
