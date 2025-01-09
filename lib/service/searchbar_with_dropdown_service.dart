import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:qixer/model/search_bar_with_dropdown_service_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/db/db_service.dart';
import 'package:qixer/view/utils/others_helper.dart';

class SearchBarWithDropdownService with ChangeNotifier {
  var serviceMap = [];

  var userStateId;

  var sText;

  var cityDropdownList = [
    'Select City',
  ];
  var selectedCity;
  List cityDropdownIndexList = [0];
  var selectedCityId = 0;

  setCityValue(value) {
    selectedCity = value;
    notifyListeners();
  }

  setSelectedCityId(value) {
    selectedCityId = value;
    notifyListeners();
  }

  resetSearchParams() {
    sText = null;
    selectedCity = null;
    selectedCityId = 0;
    selectedonlineOfflineId = 0;
  }

  //Online offline
  //===========>
  var onlineOfflineDropdownList = [
    'Offline',
    'Online',
  ];
  var selectedonlineOffline = 'Offline';
  List onlineOfflineDropdownIndexList = [0, 1];
  var selectedonlineOfflineId = 0;

  setOnlineOfflineValue(value) {
    selectedonlineOffline = value;
    notifyListeners();
  }

  setSelectedOnlineOfflineId(value) {
    selectedonlineOfflineId = value;
    notifyListeners();
  }

  // List averageRateList = [];
  // List imageList = [];

  bool isLoading = false;
  bool alreadySaved = false;

  int currentPage = 1;
  late int totalPages;

  setLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  setCurrentPage(newValue) {
    currentPage = newValue;
    notifyListeners();
  }

  setTotalPage(newPageNumber) {
    totalPages = newPageNumber;
    notifyListeners();
  }

  // fetchStates() async {
  //   // all city / state
  //   if (cityDropdownList.length < 2) {
  //     //city means state
  //     //=================>

  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     userStateId = prefs.getString('state');
  //     //====================>

  //     var response = await http.get(Uri.parse('$baseApi/city/service-city'));

  //     if (response.statusCode == 201) {
  //       var data = AllCityDropdownModel.fromJson(jsonDecode(response.body));
  //       for (int i = 0; i < data.serviceCity.length; i++) {
  //         cityDropdownList.add(data.serviceCity[i].serviceCity);
  //         cityDropdownIndexList.add(data.serviceCity[i].id);
  //       }
  //     } else {
  //       //error fetching data
  //       cityDropdownList = [];
  //     }
  //     notifyListeners();
  //   } else {
  //     //country list already loaded from api
  //   }
  // }

  fetchService(context, {String? searchText}) async {
    var connection = await checkConnection();
    if (searchText != null) {
      sText = searchText;
    }
    if (connection) {
      String data;

      data = jsonEncode({
        'service_city_id': selectedCityId,
        'search_text': sText ?? '',
        'is_service_online': selectedonlineOfflineId
      });

      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        "Content-Type": "application/json"
      };

      setLoadingTrue();

      //if connection is ok
      var response = await http.post(Uri.parse("$baseApi/home/home-search"),
          body: data, headers: header);

      if (response.statusCode == 201) {
        debugPrint(response.body.toString());
        serviceMap = [];
        var data = SearchBarWithDropdownServiceModel.fromJson(
            jsonDecode(response.body));

        for (int i = 0; i < data.services.length; i++) {
          String? serviceImage;

          if (data.serviceImage.length > i) {
            serviceImage = data.serviceImage[i]?.imgUrl;
          } else {
            serviceImage = null;
          }

          int totalRating = 0;
          for (int j = 0; j < data.services[i].reviewsForMobile.length; j++) {
            totalRating = totalRating +
                data.services[i].reviewsForMobile[j].rating!.toInt();
          }
          double averageRate = 0;

          if (data.services[i].reviewsForMobile.isNotEmpty) {
            averageRate =
                (totalRating / data.services[i].reviewsForMobile.length);
          }
          setServiceList(
              data.services[i].id,
              data.services[i].title,
              data.services[i].sellerForMobile.name,
              data.services[i].price,
              averageRate,
              serviceImage,
              i,
              data.services[i].sellerId);
        }
        setLoadingFalse();
        notifyListeners();
      } else {
        setLoadingFalse();
        serviceMap = [];
        debugPrint(response.body.toString());
        // serviceMap = [];
        serviceMap.add('error');
        //No more data
        //Something went wrong
        // serviceMap.add('error');
        notifyListeners();
        return false;
      }
    }
  }

  saveOrUnsave(int serviceId, String title, image, int price, String sellerName,
      double rating, int index, BuildContext context, sellerId) async {
    var newListMap = serviceMap;
    alreadySaved = await DbService().saveOrUnsave(serviceId, title,
        image ?? placeHolderUrl, price, sellerName, rating, context, sellerId);
    newListMap[index]['isSaved'] = alreadySaved;
    serviceMap = newListMap;
    notifyListeners();
  }

  setServiceList(
      serviceId, title, sellerName, price, rating, image, index, sellerId) {
    serviceMap.add({
      'serviceId': serviceId,
      'title': title,
      'sellerName': sellerName,
      'price': price,
      'rating': rating,
      'image': image,
      'isSaved': false,
      'sellerId': sellerId,
    });

    checkIfAlreadySaved(serviceId, title, sellerName, index);
  }

  checkIfAlreadySaved(serviceId, title, sellerName, index) async {
    var newListMap = serviceMap;
    alreadySaved = await DbService().checkIfSaved(serviceId, title, sellerName);
    newListMap[index]['isSaved'] = alreadySaved;
    serviceMap = newListMap;
    notifyListeners();
  }
}
