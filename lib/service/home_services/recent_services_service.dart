import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/model/recent_service_model.dart';
import 'package:qixer/model/service_search_model.dart';
import 'package:qixer/service/cityAndAreaController/cityAndAreaController.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/db/db_service.dart';
import 'package:qixer/view/utils/others_helper.dart';

class RecentServicesService with ChangeNotifier {
  var recentServiceMap = [];
  bool alreadySaved = false;
  bool hasService = true;

  bool _isLoadingRecenetService = false;
  bool get isLoadingRecenetService => _isLoadingRecenetService;

  fetchRecentService({required BuildContext context, String? areaID}) async {
    // if (recentServiceMap.isEmpty) {
    recentServiceMap.clear();
    String apiLink;
    debugPrint("latest service city ===> $areaID ${areaID.runtimeType}");
    apiLink =
        '$baseApi/latest-services?areaId=${areaID != 'null' ? areaID : ''}';

    debugPrint("latest services apiLink===> $apiLink");
    var connection = await checkConnection();
    if (connection) {
      //if connection is ok
      var response = await http.get(Uri.parse(apiLink));

      debugPrint("latest services===> ${response.body.toString()}");

      if (response.statusCode == 201) {
        var data = RecentServiceModel.fromJson(jsonDecode(response.body));

        //check if have service under this state =====>
        if (data.latestServices.isEmpty) {
          hasService = false;
          notifyListeners();
          return;
        } else {
          hasService = true;
        }
        //==============>

        for (int i = 0; i < data.latestServices.length; i++) {
          String? serviceImage;
          if (data.serviceImage.length > i) {
            serviceImage = data.serviceImage[i]?.imgUrl;
          } else {
            serviceImage = null;
          }

          int totalRating = 0;
          for (int j = 0;
              j < data.latestServices[i].reviewsForMobile.length;
              j++) {
            totalRating = totalRating +
                data.latestServices[i].reviewsForMobile[j].rating!.toInt();
          }
          double averageRate = 0;
          if (data.latestServices[i].reviewsForMobile.isNotEmpty) {
            averageRate =
                (totalRating / data.latestServices[i].reviewsForMobile.length);
          }
          print("service name====> ${data.latestServices[i].serviceAreas?.map(
            (e) => e.serviceArea,
          )}");
          setServiceList(
            data.latestServices[i].id,
            data.latestServices[i].title,
            data.latestServices[i].sellerForMobile?.name ?? "",
            data.latestServices[i].price,
            averageRate,
            serviceImage,
            i,
            data.latestServices[i].sellerId,
            data.latestServices[i].status,
            data.latestServices[i].experience,
            data.latestServices[i].serviceAreas,
            data.latestServices[i].sellerForMobile?.phone,
            data.latestServices[i].sellerForMobile?.phone,
            data.latestServices[i].sellerForMobile?.businessName,
            data.latestServices[i].sellerForMobile?.businessGstNumber,
            data.latestServices[i].sellerForMobile?.businessPhoneNumber,
            data.latestServices[i].sellerForMobile?.businessEmail,
            data.latestServices[i].sellerForMobile?.businessFullAddress,
            data.latestServices[i].sellerForMobile?.businessDescription,
            data.latestServices[i].sellerForMobile?.sellerBusinessImg,
            data.latestServices[i].sellerForMobile?.userServiceArea,
          );
        }
        notifyListeners();
      } else {
        //Something went wrong
        recentServiceMap.add('error');
        notifyListeners();
      }
    }
    // } else {
    //   debugPrint("already loaded");
    // }
  }

  setServiceList(
      serviceId,
      title,
      sellerName,
      price,
      rating,
      image,
      index,
      sellerId,
      status,
      experience,
      serviceArea,
      whatsappNumber,
      callNumber,
      businessName,
      businessGstNumber,
      businessPhoneNumber,
      businessEmail,
      businessFullAddress,
      businessDescription,
      businessImage,
      userArea) {
    List processedServiceAreas = serviceArea is List<ServiceAreas>
        ? serviceArea.map((area) => area.serviceArea ?? "Unknown").toList()
        : [];

    List userAreas = userArea is List<UserServiceArea>
        ? userArea.map((area) => area.serviceArea ?? "Unknown").toList()
        : [];

    recentServiceMap.add({
      'serviceId': serviceId,
      'title': title,
      'sellerName': sellerName,
      'price': price,
      'rating': rating,
      'image': image,
      'isSaved': false,
      'sellerId': sellerId,
      "status": status,
      "experience": experience,
      "serviceArea": processedServiceAreas,
      'whatsappNumber': whatsappNumber,
      'callNumber': callNumber,
      "businessName": businessName,
      "businessGstNumber": businessGstNumber,
      "businessPhoneNumber": businessPhoneNumber,
      "businessEmail": businessEmail,
      "businessFullAddress": businessFullAddress,
      "businessDescription": businessDescription,
      "businessImage": businessImage,
      "userAreas": userAreas
    });

    checkIfAlreadySaved(serviceId, title, sellerName, index);
  }

  checkIfAlreadySaved(serviceId, title, sellerName, index) async {
    var newListMap = recentServiceMap;
    alreadySaved = await DbService().checkIfSaved(serviceId, title, sellerName);
    newListMap[index]['isSaved'] = alreadySaved;
    recentServiceMap = newListMap;
    notifyListeners();
  }

  saveOrUnsave(
      int serviceId,
      String title,
      image,
      String price,
      String sellerName,
      double rating,
      int index,
      BuildContext context,
      sellerId,
      experience) async {
    var newListMap = recentServiceMap;
    alreadySaved = await DbService().saveOrUnsave(
        serviceId,
        title,
        image ?? placeHolderUrl,
        price,
        sellerName,
        rating,
        context,
        sellerId,
        experience);
    newListMap[index]['isSaved'] = alreadySaved;
    recentServiceMap = newListMap;
    notifyListeners();
  }

  recentServiceSaveUnsaveFromOtherPage(
    int serviceId,
    String title,
    String sellerName,
  ) async {
    int? index;
    for (int i = 0; i < recentServiceMap.length; i++) {
      if (recentServiceMap[i]['serviceId'] == serviceId &&
          recentServiceMap[i]['title'] == title &&
          recentServiceMap[i]['sellerName'] == sellerName) {
        index = i;
        break;
      }
    }
    if (index != null) {
      var newListMap = recentServiceMap;
      alreadySaved =
          await DbService().checkIfSaved(serviceId, title, sellerName);
      newListMap[index]['isSaved'] = alreadySaved;
      recentServiceMap = newListMap;
      notifyListeners();
    }
  }
}
