import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qixer/model/top_service_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/db/db_service.dart';
import 'package:qixer/view/utils/others_helper.dart';

class TopRatedServicesSerivce with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  var topServiceMap = [];
  bool alreadySaved = false;

  List<Map<String, dynamic>> topServiceList = [];

  Future<void> fetchTopService() async {
    _isLoading = true;
    if (topServiceList.isEmpty) {
      String apiLink = '$baseApi/top-services';

      try {
        var connection = await checkConnection();
        if (connection) {
          var response = await http.get(Uri.parse(apiLink));
          if (response.statusCode == 200 || response.statusCode == 201) {
            var data = json.decode(response.body);
            if (data["top_services"] != null) {
              topServiceList = (data["top_services"] as List).map((service) {
                return {
                  "id": service["id"],
                  "name": service["name"],
                  "category": service["category"]["name"],
                  "categoryId": service["category"]["id"],
                  "image": service["image"],
                  "banner_img": service["banner_img"] is List &&
                          service["banner_img"].isNotEmpty
                      ? service["banner_img"][0][
                          "img_url"] // Taking first banner image if it's a list
                      : (service["banner_img"] is Map
                          ? service["banner_img"]["img_url"]
                          : null),
                  "status": service["status"],
                };
              }).toList();
              _isLoading = false;
              print(
                  "Top Services List: $topServiceList"); // Print the updated list
            }
          } else {
            _isLoading = false;
            print(
                "Error: Failed to fetch top services, Status Code: ${response.statusCode}");
          }
        } else {
          _isLoading = false;
          print("No internet connection");
        }
        _isLoading = false;
      } catch (e) {
        _isLoading = false;
        print("Exception occurred while fetching top services: $e");
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    } else {
      _isLoading = false;
      print("Top services already loaded");
    }
  }

  setServiceList(
      serviceId, title, sellerName, price, rating, image, index, sellerId) {
    topServiceMap.add({
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
    var newListMap = topServiceMap;
    alreadySaved = await DbService().checkIfSaved(serviceId, title, sellerName);
    newListMap[index]['isSaved'] = alreadySaved;
    topServiceMap = newListMap;
    notifyListeners();
  }

  saveOrUnsave(int serviceId, String title, image, var price, String sellerName,
      double rating, int index, BuildContext context, sellerId, exp) async {
    var newListMap = topServiceMap;
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
    topServiceMap = newListMap;
    notifyListeners();
  }

  topServiceSaveUnsaveFromOtherPage(
    int serviceId,
    String title,
    String sellerName,
  ) async {
    int? index;
    for (int i = 0; i < topServiceMap.length; i++) {
      if (topServiceMap[i]['serviceId'] == serviceId &&
          topServiceMap[i]['title'] == title &&
          topServiceMap[i]['sellerName'] == sellerName) {
        index = i;
        break;
      }
    }

    if (index != null) {
      //if that product exist in other page then change the saved button accordingly
      var newListMap = topServiceMap;
      alreadySaved =
          await DbService().checkIfSaved(serviceId, title, sellerName);
      newListMap[index]['isSaved'] = alreadySaved;
      topServiceMap = newListMap;
      notifyListeners();
    }
  }
}
