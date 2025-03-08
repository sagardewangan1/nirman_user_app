import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/model/CategoryDataModel.dart';
import 'package:qixer/model/service_by_filter_model.dart';
import 'package:qixer/model/service_search_model.dart';
import 'package:qixer/model/sub_category_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/db/db_service.dart';
import 'package:qixer/service/home_services/category_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';

class AllServicesService with ChangeNotifier {
  bool isLoading = true;

  var categoryDropdownList = [lnProvider.getString('Select Category')];
  var categoryDropdownIndexList = [0];
  var selectedCategory = lnProvider.getString('Select Category');
  var selectedCategoryId = 0;

  var subcatDropdownList = [lnProvider.getString('Select Subcategory')];
  var subcatDropdownIndexList = [0];
  var selectedSubcat = lnProvider.getString('Select Subcategory');
  var selectedSubcatId = 0;

  var ratingDropdownList = [
    'All',
    '5 Star',
    '4 Star',
    '3 Star',
    '2 Star',
    '1 Star'
  ];
  var ratingDropdownIndexList = [0, 5, 4, 3, 2, 1];
  var selectedRating = 'All';
  var selectedRatingId = 0;

  //=================>

  var sortbyDropdownList = [
    'All',
    'Highest Price',
    'Lowest Price',
    'Latest Service'
  ];
  var sortbyDropdownIndexList = [
    '',
    'highest_price',
    'lowest_price',
    'latest_service'
  ];

  var selectedSortby = 'All';
  var selectedSortbyId = '';

  setSortbyValue(value) {
    selectedSortby = value;
    notifyListeners();
  }

  setSelectedSortbyId(value) {
    selectedSortbyId = value;
    notifyListeners();
  }

  defaultSortBy() {
    selectedSortby = 'All';
    selectedSortbyId = '';
    notifyListeners();
  }

  // ===============>
  setCategoryValue(value) {
    selectedCategory = value;
    print("✅ New selected value: $selectedCategory");
    notifyListeners();
  }

  setSelectedCategoryId(value) {
    selectedCategoryId = value;
    print("✅ Selected Category ID: $selectedCategoryId");
  }

  setSubcatValue(value) {
    selectedSubcat = value;
    notifyListeners();
  }

  setRatingValue(value) {
    selectedRating = value;
    notifyListeners();
  }

  setSelectedSubcatsId(value) {
    selectedSubcatId = value;
    notifyListeners();
  }

  setSelectedRatingId(value) {
    selectedRatingId = value;
    notifyListeners();
  }

  defaultSubcategory() {
    subcatDropdownList = [lnProvider.getString('Select Subcategory')];
    subcatDropdownIndexList = [0];
    selectedSubcat = lnProvider.getString('Select Subcategory');
    selectedSubcatId = 0;
    notifyListeners();
  }

  setLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  var serviceMap = [];
  bool alreadySaved = false;

  late int totalPages;

  int currentPage = 1;
  var alreadyAddedtoFav = false;

  setCurrentPage(newValue) {
    currentPage = newValue;
    notifyListeners();
  }

  setTotalPage(newPageNumber) {
    totalPages = newPageNumber;
    notifyListeners();
  }

  // var refreshController;

  // setRefreshController(value) {
  //   refreshController = value;
  // }

  List averageRateList = [];
  List imageList = [];

  setEverythingToDefault() {
    serviceMap = [];
    currentPage = 1;
    averageRateList = [];
    imageList = [];
    notifyListeners();
  }

  fetchCategories(BuildContext context) async {
    var categoryDataModel =
        Provider.of<CategoryService>(context, listen: false).categoryDataModel;

    if (categoryDataModel.categories != null &&
        categoryDataModel.categories!.isNotEmpty) {
      categoryDropdownList.clear();
      categoryDropdownIndexList.clear();
      categoryDropdownList.insert(0, "All Categories");
      categoryDropdownIndexList.insert(0, 0);
      for (var category in categoryDataModel.categories!) {
        categoryDropdownList.add(category.name);
        categoryDropdownIndexList.add(category.id ?? 0);
      }

      if (categoryDataModel.categories!.isNotEmpty) {
        selectedCategory = categoryDataModel.categories![0].name;
        selectedCategoryId = categoryDataModel.categories![0].id ?? 0;
        if (selectedCategoryId != 0) {
          fetchSubcategory(selectedCategoryId.toString());
        }
      }
    }
  }

  List<Subcategories> _subCatList = [];
  List<Subcategories> get subCatList => _subCatList;

  Future<bool> fetchSubcategory(categoryId) async {
    setSelectedCategoryId(int.parse(categoryId));
    //make sub category list to default first
    if (selectedCategoryId == 0) {
      defaultSubcategory();
      return true;
    } else {
      // defaultSubcategory();

      if (selectedCategoryId != 0) {
        //this trick is only to show loading when category other than 'All' is selected
        subcatDropdownList = [];
        _subCatList = [];
        selectedSubcat = '';
        // notifyListeners();
      }
      var url = Uri.parse('$baseApi/category/sub-category/$categoryId');
      var response = await http.get(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        defaultSubcategory();
        var data = SubcategoryModel.fromJson(jsonDecode(response.body));
        for (int i = 0; i < data.subCategories.length; i++) {
          subcatDropdownList.add(data.subCategories[i].name!);
          _subCatList.add(Subcategories(
            id: data.subCategories[i].id,
            name: data.subCategories[i].name,
            image: data.subCategories[i].image,
          ));
          subcatDropdownIndexList.add(data.subCategories[i].id!);
        }

        // selectedSubcat = data.subCategories[0].name!;
        // selectedSubcatId = data.subCategories[0].id!;
        notifyListeners();
        return true;
      } else {
        //error fetching data // no data found
        // subcatDropdownList = [];
        // notifyListeners();
        defaultSubcategory();
        return false;
      }
    }
  }

  fetchServiceByFilter(context, {bool isrefresh = false}) async {
    if (isrefresh) {
      //making the list empty first to show loading bar (we are showing loading bar while the product list is empty)
      //we are make the list empty when the sub category or brand is selected because then the refresh is true
      serviceMap = [];
      notifyListeners();

      setLoadingTrue();
      setCurrentPage(1);
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
      String url =
          "$baseApi/service-list/category-subcategory-rating-sort-by-search/?cat=$selectedCategoryId&subcat=$selectedSubcatId&rating=$selectedRatingId&sortby=$selectedSortbyId&page=$currentPage";
      var response = await http.get(Uri.parse(url));

      print("URL =====> $url");

      if (response.statusCode == 201) {
        var data = ServiceByFilterModel.fromJson(jsonDecode(response.body));
        print(
            "data from model ===> ${data.allServices.data[0].serviceAreas?.map(
          (e) => e.serviceArea,
        )}");

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
        imageList = [];
        averageRateList = [];
        setCurrentPage(currentPage);
        setLoadingFalse();
        return true;
      } else {
        setLoadingFalse();
        return false;
      }
    }
  }

  setServiceList(
    data,
    averageRateList,
    imageList,
    bool addnewData,
  ) {
    if (addnewData == false) {
      //make the list empty first so that existing data doesn't stay
      serviceMap = [];
      notifyListeners();
    }

    for (int i = 0; i < data.length; i++) {
      /// ✅ Convert `List<ServiceAreas>` to `List<String>` (Extract `service_area`)
      List processedServiceAreas = data[i].serviceAreas is List<ServiceAreas>
          ? data[i]
              .serviceAreas
              .map((area) => area.serviceArea ?? "Unknown")
              .toList()
          : [];

      serviceMap.add({
        'serviceId': data[i].id,
        'title': data[i].title,
        'sellerName': data[i].sellerForMobile.name,
        'price': data[i].price,
        'rating': averageRateList[i],
        'image': imageList[i],
        'isSaved': false,
        'sellerId': data[i].sellerId,
        'experience': data[i].experience,
        'status': data[i].status,
        'whatsappNumber': data[i].sellerForMobile.phone,
        'callNumber': data[i].sellerForMobile.phone,
        "serviceArea": processedServiceAreas
      });
      // print("✅ Processed service areas: ${serviceMap.last["serviceArea"]}");

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
