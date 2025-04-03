import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/data/network/network_api_services.dart';
import 'package:qixer/model/service_by_filter_model.dart';
import 'package:qixer/model/serviceby_category_model.dart';
import 'package:qixer/model/sub_category_model.dart';
import 'package:qixer/service/cityAndAreaController/cityAndAreaController.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/db/db_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';
import 'package:qixer/model/recent_service_model.dart' as recent;
import 'package:qixer/model/service_search_model.dart' as search;

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
      // final decodedResponse = jsonDecode(response.body);
      // print(decodedResponse["all_services"]["data"].toString());

      var jsonDataServiceList =
          jsonDecode(response.body)['all_services']['data'];
      printLargeResponse(jsonDecode(response.body));
      print(jsonDataServiceList[0]['seller_for_mobile'].toString());

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
          setServiceList(data, averageRateList, imageList, false);
        } else {
          //else add new data
          setServiceList(data, averageRateList, imageList, true);
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

  fetchServiceBySubCateId(context, categoryId, subCatId,
      {bool isrefresh = false}) async {
    //=================>
    var areaId =
        Provider.of<CityAndAreaController>(context, listen: false).cityId;
    String apiLink;
    apiLink =
        '$baseApi/service-list/category-subcategory-rating-sort-by-search/?cat=$categoryId&subcat=${subCatId ?? ""}&page=$currentPage&area_Id=${areaId ?? ''}';
    //====================>
    print("url-======> $apiLink");
    if (isrefresh) {
      //making the list empty first to show loading bar (we are showing loading bar while the product list is empty)
      //we are make the list empty when the sub category or brand is selected because then the refresh is true
      serviceMap = [];
      notifyListeners();

      Provider.of<ServiceByCategoryService>(context, listen: false)
          .setCurrentPage(1);
    } else {}
    var connection = await checkConnection();
    if (connection) {
      //if connection is ok
      var response = await http.get(Uri.parse(apiLink));

      // var jsonDataServiceList = jsonDecode(response.body)['all_services']
      //     ['data'][0]["seller_for_mobile"];
      //
      // debugPrint("api response : ======> ${jsonDataServiceList.toString()}");

      if (response.statusCode == 201) {
        ServicebyCategoryModel data =
            ServicebyCategoryModel.fromJson(jsonDecode(response.body));

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
          setServiceList(data, averageRateList, imageList, false);
        } else {
          //else add new data
          setServiceList(data, averageRateList, imageList, true);
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

  setServiceList(ServicebyCategoryModel data, averageRateList, imageList,
      bool addnewData) {
    if (!addnewData) {
      // Clear the list if not appending new data
      serviceMap = [];
      notifyListeners();
    }

    // Loop through each service in the data
    for (int i = 0; i < data.allServices.data.length; i++) {
      var serviceItem = data.allServices.data[i];
      SellerForMobile? seller = serviceItem.sellerForMobile;

      // If seller is null, set a demo seller object using fromJson
      seller ??= SellerForMobile(
          id: 0,
          name: "Demo Seller",
          image: "",
          countryId: 0,
          phone: "0000000000",
          serviceCity: "Unknown",
          serviceArea: [],
          address: "No Address",
          latitude: 0.0,
          longitude: 0.0,
          sellerAddress: "No Address",
          postCode: "000000",
          username: "demo_user",
          businessName: "Demo Business",
          businessGstNumber: "GST000000",
          businessPhoneNumber: "0000000000",
          businessEmail: "demo@email.com",
          businessFullAddress: "Demo City",
          businessDescription: "This is a demo seller",
          sellerBusinessImg: "",
          workingCategories: "[]",
          userServiceArea: []);

      // Process service areas safely using the correct index from serviceItem
      List processedServiceAreas =
          (serviceItem.serviceAreas is List<search.ServiceAreas>)
              ? serviceItem.serviceAreas
                      ?.map((area) => area.serviceArea ?? "Unknown")
                      .toList() ??
                  []
              : [];

      // Process user service areas from seller safely
      List userAreas = (seller?.userServiceArea is List<recent.UserServiceArea>)
          ? seller?.userServiceArea!
                  .map((area) => area.serviceArea ?? "Unknown")
                  .toList() ??
              []
          : [];

      // Add the service information into the serviceMap
      serviceMap.add({
        'serviceId': serviceItem.id,
        'title': serviceItem.title,
        'name': seller?.name ?? "Unknown",
        'price': serviceItem.price,
        'rating': averageRateList[i],
        'image': imageList[i],
        'isSaved': false,
        'sellerId': serviceItem.sellerId,
        'experience': serviceItem.experience,
        'status': serviceItem.status,
        'whatsappNumber': seller?.phone ?? "N/A",
        'callNumber': seller?.phone ?? "N/A",
        "serviceArea": processedServiceAreas,
        "businessName": seller?.businessName,
        "businessGstNumber": seller?.businessGstNumber,
        "businessPhoneNumber": seller?.businessPhoneNumber,
        "businessEmail": seller?.businessEmail,
        "businessFullAddress": seller?.businessFullAddress,
        "businessDescription": seller?.businessDescription,
        "businessImage": seller?.sellerBusinessImg,
        "userAreas": userAreas
      });

      // Call the function to check if the service is already saved
      checkIfAlreadySaved(serviceItem.id, serviceItem.title,
          seller?.name ?? "Unknown", serviceMap.length - 1);
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
    print("serviceId: $serviceId");
    print("title: $title");
    print("image: $image");
    print("price: $price");
    print("sellerName: $sellerName");
    print("rating: $rating");
    print("index: $index");
    print("context: $context");
    print("sellerId: $sellerId");
    print("exp: $exp");

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
      subCatList = SubcategoryModel.fromJson(responseData).subCategories;
      notifyListeners();
    }
  }
}
