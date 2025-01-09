import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qixer/model/service_search_model.dart';
import 'package:qixer/view/utils/others_helper.dart';

import '../data/network/network_api_services.dart';
import '../model/categoryModel.dart';
import '../model/child_category_model.dart';
import '../model/google_places_model.dart';
import '../model/sub_category_model.dart';
import '../view/search/service_filter_model.dart';
import 'db/db_service.dart';

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
  Prediction? prediction;
  String? serviceType = "All";

  Category? selectedCategory;
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

  setCategoryFilters({
    Category? selectedCategory,
    SubCategory? selectedSubcategory,
    ChildCategory? selectedChildCategory,
  }) {
    this.selectedCategory = selectedCategory;
    this.selectedSubcategory = selectedSubcategory;
    this.selectedChildCategory = selectedChildCategory;

    fetchServices();
  }

  resetFilters({st}) {
    searchText = st ?? "";
    minPrice = "";
    maxPrice = "";
    selectedSorting = null;
    rating = null;
    distance = 50;
    prediction = null;
    serviceType = "All";
    selectedCategory = null;
    selectedSubcategory = null;
    selectedChildCategory = null;

    fetchServices();
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
    notifyListeners();
    final responseData = await NetworkApiServices().getApi(
      searchUrl,
      "Search services",
    );

    if (responseData != null) {
      debugPrint(responseData.toString());
      var tempData = ServiceSearchModel.fromJson(responseData);
      _serviceSearchModel = tempData;
      debugPrint((tempData.mainServices?.length).toString());
      tempData.mainServices?.forEach((element) {
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
          1,
          element.service?.sellerId,
          element.service?.sellerForMobile?.lat,
          element.service?.sellerForMobile?.lng,
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

  saveOrUnsave(int serviceId, String title, image, int price, String sellerName,
      double rating, int index, BuildContext context, sellerId) async {
    alreadySaved = await DbService().saveOrUnsave(serviceId, title,
        image ?? placeHolderUrl, price, sellerName, rating, context, sellerId);
    serviceMap[index]['isSaved'] = alreadySaved;
    notifyListeners();
  }

  setServiceList(serviceId, title, sellerName, price, rating, image, index,
      sellerId, lat, lng) {
    double randomLat = lat;
    double randomLng = lng;
    var latLng = randomLat.toString() + ", " + randomLng.toString();
    if (markerKeys.contains(latLng) && !latLng.contains("null")) {
      do {
        final ranLatLng = getRandomCoordinates(lat, lng, 500);
        randomLat = ranLatLng.first;
        randomLng = ranLatLng.last;
        latLng = randomLat.toString() + ", " + randomLng.toString();
      } while (markerKeys.contains(latLng));
    }
    markerKeys.add(latLng);
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
    });
    try {
      checkIfAlreadySaved(serviceId, title, sellerName, index);
    } catch (e) {}
  }

  checkIfAlreadySaved(serviceId, title, sellerName, index) async {
    alreadySaved = await DbService().checkIfSaved(serviceId, title, sellerName);
    serviceMap[index]['isSaved'] = alreadySaved;
    notifyListeners();
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
