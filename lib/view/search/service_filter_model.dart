import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/model/categoryModel.dart';
import 'package:qixer/model/child_category_model.dart';
import 'package:qixer/model/google_places_model.dart';
import 'package:qixer/model/sub_category_model.dart';
import 'package:qixer/service/filter_services_service.dart';

class ServiceFilterViewModel {
  TextEditingController searchTextController = TextEditingController();

  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  ValueNotifier<SortModel?> selectedSorting = ValueNotifier(null);
  ValueNotifier<num?> rating = ValueNotifier(null);

  ValueNotifier<int> distance = ValueNotifier(50);
  ValueNotifier<Prediction?> prediction = ValueNotifier(null);
  ValueNotifier<String?> serviceType = ValueNotifier("All");

  ValueNotifier<Category?> selectedCategory = ValueNotifier(null);
  ValueNotifier<SubCategory?> selectedSubcategory = ValueNotifier(null);
  ValueNotifier<ChildCategory?> selectedChildCategory = ValueNotifier(null);

  Timer? timer;

  final sortList = [
    SortModel(id: "latest_service", name: "Latest Service"),
    SortModel(id: "lowest_price", name: "Lowest Price"),
    SortModel(id: "highest_price", name: "Highest Price"),
    SortModel(id: "best_selling", name: "Best Selling Service"),
    SortModel(id: "popular", name: "Popular Service"),
    SortModel(id: "featured", name: "Featured Service"),
  ];

  ServiceFilterViewModel._init();
  static ServiceFilterViewModel? _instance;
  static ServiceFilterViewModel get instance {
    _instance ??= ServiceFilterViewModel._init();
    return _instance!;
  }

  ServiceFilterViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }

  void setNFilters(BuildContext context) {
    final fsProvider =
        Provider.of<FilterServicesService>(context, listen: false);
    minPriceController.text = fsProvider.minPrice;
    maxPriceController.text = fsProvider.maxPrice;
    rating.value = fsProvider.rating;
    selectedSorting.value = fsProvider.selectedSorting;
  }

  void setLFilters(BuildContext context) {
    final fsProvider =
        Provider.of<FilterServicesService>(context, listen: false);
    prediction.value = fsProvider.prediction;

    distance.value = fsProvider.distance;
    serviceType.value = fsProvider.serviceType;
  }

  void setCFilters(BuildContext context) {
    final fsProvider =
        Provider.of<FilterServicesService>(context, listen: false);
    selectedCategory.value = fsProvider.selectedCategory;
    selectedSubcategory.value = fsProvider.selectedSubcategory;
    selectedChildCategory.value = fsProvider.selectedChildCategory;
  }
}

class SortModel {
  final dynamic id;
  final String name;
  SortModel({
    required this.id,
    required this.name,
  });
}
