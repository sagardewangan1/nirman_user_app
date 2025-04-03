import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/model/CategoryDataModel.dart';
import 'package:qixer/model/profile_model.dart';
import 'package:qixer/model/recent_service_model.dart';
import 'package:qixer/model/service_search_model.dart';
import 'package:qixer/view/utils/others_helper.dart';

import '../data/network/network_api_services.dart';
import '../model/categoryModel.dart';
import '../model/child_category_model.dart';
import '../model/google_places_model.dart';
import '../model/sub_category_model.dart';
import '../view/search/service_filter_model.dart';
import 'db/db_service.dart';
import 'package:collection/collection.dart'; // Import for forEachIndexed

class FilterServicesService with ChangeNotifier {
  ServiceSearchModel? _serviceSearchModel;
  var serviceMap = [];
  var markerKeys = [];

  ServiceSearchModel get serviceSearchModel =>
      _serviceSearchModel ?? ServiceSearchModel();

  String searchText = '';
  String searchUrl = '';
  String minPrice = "";
  String maxPrice = "";
  SortModel? selectedSorting;
  num? rating;

  int distance = 50;
  String? _cityId;
  String? get cityId => _cityId;

  setCityId(String? cityId) {
    _cityId = cityId;
    notifyListeners();
  }

  Prediction? prediction;
  String? serviceType = "All";

  Category? selectedCategory;
  Categories? selectedCategories;
  SubCategory? selectedSubcategory;
  ChildCategory? selectedChildCategory;

  bool searchLoading = false;

  setNormalFilters({
    required String minPrice,
    required String maxPrice,
    required SortModel? sort,
    required num? rating,
  }) {
    this.minPrice = minPrice;
    this.maxPrice = maxPrice;
    selectedSorting = sort;
    this.rating = rating;
    fetchServices();
  }

  setLocationFilters({
    required int distance,
    Prediction? prediction,
    String? serviceType,
  }) {
    this.distance = distance;
    this.prediction = prediction;
    this.serviceType = serviceType;

    fetchServices();
  }

  setSearchText(text) {
    searchText = text;
    fetchServices();
  }

  String? _areaId;
  String? get areaId => _areaId;
  setAreaID(areaId) {
    _areaId = areaId;
    debugPrint("set area id ====> $_areaId");
    fetchServices();
  }

  setCategoryFilters({
    Category? selectedCategory,
    Categories? categories,
    SubCategory? selectedSubcategory,
    ChildCategory? selectedChildCategory,
  }) async {
    selectedCategories = categories;
    this.selectedCategory = selectedCategory;
    this.selectedSubcategory = selectedSubcategory;
    this.selectedChildCategory = selectedChildCategory;

    fetchServices();
  }

  setClearCategoryFilters({
    Category? selectedCategory,
    Categories? categories,
    SubCategory? selectedSubcategory,
    ChildCategory? selectedChildCategory,
  }) async {
    selectedCategories = categories;
    this.selectedCategory = selectedCategory;
    this.selectedSubcategory = selectedSubcategory;
    this.selectedChildCategory = selectedChildCategory;

    // fetchServices();
  }

  resetFilters({st}) {
    serviceMap.clear();

    searchText = st ?? "";
    minPrice = "";
    maxPrice = "";
    selectedSorting = null;
    rating = null;
    distance = 50;
    prediction = null;
    serviceType = "All";
    selectedCategories = null;
    selectedCategory = null;
    selectedSubcategory = null;
    selectedChildCategory = null;
    _areaId = '';
    // fetchServices();
    notifyListeners();
  }

  get _searchUrl {
    var url = "$baseApi/service/search?search_text=$searchText";
    url += "&cat=${selectedCategory?.id ?? ""}";
    url += "&subcat=${selectedSubcategory?.id ?? ""}";
    url += "&child_cat=${selectedChildCategory?.id ?? ""}";
    url += "&sortby=${selectedSorting?.id ?? ""}";
    url += "&rating=${rating ?? ""}";
    url += "&latitude=${prediction?.lat ?? ""}";
    url += "&longitude=${prediction?.lng ?? ""}";
    url += "&distance_kilometers_value=$distance";
    url += "&area=${_areaId ?? ""}";
    if (minPrice.isNotEmpty || maxPrice.isNotEmpty) {
      url +=
          "&price_range_value=${minPrice.isEmpty ? 0 : minPrice},${maxPrice.isEmpty ? 0 : maxPrice}";
    }
    switch (serviceType) {
      case "Online":
        url += "&is_service_online=1";

        break;
      case "Offline":
        url += "&is_service_online=0";

        break;
      default:
    }
    return url;
  }

  fetchServices() async {
    searchUrl = _searchUrl;
    serviceMap = [];
    markerKeys = [];
    searchLoading = true;
    // notifyListeners();
    final responseData = await NetworkApiServices().getApi(
      searchUrl,
      "Search services",
    );

    if (responseData != null) {
      // printLargeResponse(responseData.toString());
      var tempData = ServiceSearchModel.fromJson(responseData);
      _serviceSearchModel = tempData;
      // debugPrint((tempData.mainServices?.length).toString());
      tempData.mainServices?.forEachIndexed((index, element) {
        setServiceList(
          element.service?.id,
          element.service?.title ?? "",
          element.service?.sellerForMobile?.name ?? "",
          element.service?.price,
          calculateAverage(
            element.service?.reviewsForMobile
                ?.map(
                  (e) => e.rating,
                )
                .toList(),
          ),
          element.imageUrl,
          index,
          element.service?.sellerId,
          element.service?.sellerForMobile?.latitude ?? 0.0,
          element.service?.sellerForMobile?.latitude ?? 0.0,
          element.service?.experience,
          element.service?.status,
          element.service?.sellerForMobile?.phone,
          element.service?.sellerForMobile?.phone,
          element.serviceAreas ?? [],
          element.service?.sellerForMobile?.businessName,
          element.service?.sellerForMobile?.businessGstNumber,
          element.service?.sellerForMobile?.businessPhoneNumber,
          element.service?.sellerForMobile?.businessEmail,
          element.service?.sellerForMobile?.businessFullAddress,
          element.service?.sellerForMobile?.businessDescription,
          element.service?.sellerForMobile?.sellerBusinessImg,
          element.service?.sellerForMobile?.userServiceArea,
        );
      });
      notifyListeners();
    }
    searchLoading = false;
    notifyListeners();
  }

  bool alreadySaved = false;
  double calculateAverage(List<num>? numbers) {
    if (numbers?.isEmpty ?? true) {
      return 0.0; // Return 0 if the list is empty to avoid division by zero
    }

    // Calculate the sum of numbers
    num sum = numbers!.reduce((a, b) => a + b);

    // Calculate the average
    double average = sum / numbers.length;

    return average;
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
    notifyListeners();
    serviceMap[index]['isSaved'] = alreadySaved;
    notifyListeners();
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
      lat,
      lng,
      experience,
      status,
      whatsappNumber,
      callNumber,
      serviceArea,
      businessName,
      businessGstNumber,
      businessPhoneNumber,
      businessEmail,
      businessFullAddress,
      businessDescription,
      businessImage,
      userArea) {
    double randomLat = lat;
    double randomLng = lng;
    var latLng = "$randomLat, $randomLng";
    if (markerKeys.contains(latLng) && !latLng.contains("null")) {
      do {
        final ranLatLng = getRandomCoordinates(lat, lng, 500);
        randomLat = ranLatLng.first;
        randomLng = ranLatLng.last;
        latLng = "$randomLat, $randomLng";
      } while (markerKeys.contains(latLng));
    }
    markerKeys.add(latLng);

    /// ✅ Convert `List<ServiceAreas>` to `List<String>` (Extract `service_area`)
    List processedServiceAreas = serviceArea is List<ServiceAreas>
        ? serviceArea.map((area) => area.serviceArea ?? "Unknown").toList()
        : [];

    List userAreas = userArea is List<UserServiceArea>
        ? userArea.map((area) => area.serviceArea ?? "Unknown").toList()
        : [];

    serviceMap.add({
      'serviceId': serviceId,
      'title': title,
      'sellerName': sellerName,
      'price': price,
      'rating': rating,
      'image': image,
      'isSaved': false,
      'sellerId': sellerId,
      'lat': randomLat,
      'lng': randomLng,
      'experience': experience,
      'status': status,
      'whatsappNumber': whatsappNumber,
      'callNumber': callNumber,
      "serviceArea": processedServiceAreas,
      "businessName": businessName,
      "businessGstNumber": businessGstNumber,
      "businessPhoneNumber": businessPhoneNumber,
      "businessEmail": businessEmail,
      "businessFullAddress": businessFullAddress,
      "businessDescription": businessDescription,
      "businessImage": businessImage,
      "userAreas": userAreas
    });
    try {
      checkIfAlreadySaved(serviceId, title, sellerName, index);
    } catch (e, stackTrace) {
      print("stacktrace====> $stackTrace");
    }
  }

  checkIfAlreadySaved(serviceId, title, sellerName, index) async {
    try {
      alreadySaved =
          await DbService().checkIfSaved(serviceId, title, sellerName);
      serviceMap[index]['isSaved'] = alreadySaved;
      notifyListeners();
    } catch (e, stackTrace) {
      print("stacktrace====> $stackTrace");
    }
  }

  List<double> getRandomCoordinates(double originalLatitude,
      double originalLongitude, double radiusInMeters) {
    // Earth radius in meters
    const earthRadius = 6371000.0;

    // Convert radius from meters to radians
    double radiusInRadians = radiusInMeters / earthRadius;

    // Generate random angle
    double randomAngle = Random().nextDouble() * 2 * pi;

    // Calculate new latitude and longitude
    double newLatitude = originalLatitude + radiusInRadians * cos(randomAngle);
    double newLongitude =
        originalLongitude + radiusInRadians * sin(randomAngle);

    return [
      // newLatitude,
      // newLongitude,
      double.parse(newLatitude.toStringAsFixed(6)),
      double.parse(newLongitude.toStringAsFixed(6))
    ];
  }
}
