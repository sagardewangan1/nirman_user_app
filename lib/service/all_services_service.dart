import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/model/CategoryDataModel.dart';
import 'package:qixer/model/recent_service_model.dart';
import 'package:qixer/model/service_by_filter_model.dart';
import 'package:qixer/model/service_search_model.dart';
import 'package:qixer/model/sub_category_model.dart';
import 'package:qixer/service/cityAndAreaController/cityAndAreaController.dart';
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

  String? _searchText;
  String? get searchText => _searchText;
  setSearch(BuildContext context, newValue) {
    _searchText = newValue;
    fetchAllService(context);
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

  Future<bool> fetchSubcategory(String categoryId) async {
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
      debugPrint("url =====> $url\n  response =======> ${response.body}");
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

  Future<bool> fetchServiceByFilter(BuildContext context,
      {bool isrefresh = false}) async {
    try {
      if (isrefresh) {
        // Making the list empty first to show loading bar
        serviceMap = [];
        notifyListeners();

        setLoadingTrue();
        setCurrentPage(1);
      }

      var connection = await checkConnection();
      if (!connection) {
        print("❌ No internet connection.");
        return false;
      }

      // Construct API URL
      String url =
          "$baseApi/service-list/category-subcategory-rating-sort-by-search/?cat=$selectedCategoryId&subcat=$selectedSubcatId&rating=$selectedRatingId&sortby=$selectedSortbyId&page=$currentPage&searchText=${searchText == null ? '' : searchText}";

      print("🌍 Fetching from URL: $url\n");

      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200 || response.statusCode == 201) {
        var decodedResponse = jsonDecode(response.body);

        // printLargeResponse(
        //     "actual data ===> ${decodedResponse["all_services"]["data"][0]["seller_for_mobile"]["seller_business_img"].runtimeType}");

        ServiceByFilterModel serviceByFilterModel =
            ServiceByFilterModel.fromJson(decodedResponse);
        print(
            "✅ Data received: ${serviceByFilterModel.allServices.data.length} services");

        setTotalPage(serviceByFilterModel.allServices.lastPage);

        List<double> averageRateList = [];
        List<String?> imageList = [];

        for (int i = 0; i < serviceByFilterModel.allServices.data.length; i++) {
          String? serviceImage = (serviceByFilterModel.serviceImage.length > i)
              ? serviceByFilterModel.serviceImage[i]?.imgUrl
              : null;

          int totalRating = 0;
          for (var review
              in serviceByFilterModel.allServices.data[i].reviewsForMobile) {
            totalRating += review.rating?.toInt() ?? 0;
          }

          double averageRate = (serviceByFilterModel
                  .allServices.data[i].reviewsForMobile.isNotEmpty)
              ? totalRating /
                  serviceByFilterModel
                      .allServices.data[i].reviewsForMobile.length
              : 0;

          averageRateList.add(averageRate);
          imageList.add(serviceImage);
        }

        if (isrefresh) {
          setServiceList(
              serviceByFilterModel, averageRateList, imageList, false);
        } else {
          setServiceList(
              serviceByFilterModel, averageRateList, imageList, true);
        }

        currentPage++;
        setCurrentPage(currentPage);
        setLoadingFalse();

        return true;
      } else {
        serviceMap.clear();
        print("❌ API Error: ${response.statusCode} - ${response.body}");
        setLoadingFalse();
        return false;
      }
    } catch (e, stackTrace) {
      print("❌ Exception in fetchServiceByFilter: $e");
      print("📌 StackTrace: $stackTrace");
      setLoadingFalse();
      return false;
    }
  }

  void setServiceList(
    ServiceByFilterModel data,
    List<double> averageRateList,
    List<String?> imageList,
    bool addNewData,
  ) {
    try {
      if (!addNewData) {
        serviceMap = [];
        notifyListeners();
      }

      for (int i = 0; i < data.allServices.data.length; i++) {
        // print(
        //     "data after for loop ===> ${data.allServices.data[i].id} ${data.allServices.data[i].sellerForMobile?.sellerBusinessImg}\n\n");
        try {
          List processedServiceAreas = data.allServices.data[i].serviceAreas
                  ?.map((area) => area.serviceArea ?? "Unknown")
                  .toList() ??
              [];

          List<String> userServiceAreas = data
                  .allServices.data[i].sellerForMobile?.userServiceArea
                  ?.map((area) => area.serviceArea ?? "Unknown")
                  .toList() ??
              [];

          serviceMap.add({
            'serviceId': data.allServices.data[i].id,
            'title': data.allServices.data[i].title,
            'sellerName': data.allServices.data[i].sellerForMobile?.name,
            'price': data.allServices.data[i].price,
            'rating': averageRateList[i],
            'image': imageList[i],
            'isSaved': false,
            'sellerId': data.allServices.data[i].sellerId,
            'experience': data.allServices.data[i].experience,
            'status': data.allServices.data[i].status,
            'whatsappNumber': data.allServices.data[i].sellerForMobile?.phone,
            'callNumber': data.allServices.data[i].sellerForMobile?.phone,
            "serviceArea": processedServiceAreas,
            "businessName":
                data.allServices.data[i].sellerForMobile?.businessName,
            "businessGstNumber":
                data.allServices.data[i].sellerForMobile?.businessGstNumber,
            "businessPhoneNumber":
                data.allServices.data[i].sellerForMobile?.businessPhoneNumber,
            "businessEmail":
                data.allServices.data[i].sellerForMobile?.businessEmail,
            "businessFullAddress":
                data.allServices.data[i].sellerForMobile?.businessFullAddress,
            "businessDescription":
                data.allServices.data[i].sellerForMobile?.businessDescription,
            "businessImage":
                data.allServices.data[i].sellerForMobile?.sellerBusinessImg,
            "userAreas": userServiceAreas
          });

          checkIfAlreadySaved(
              data.allServices.data[i].id,
              data.allServices.data[i].title,
              data.allServices.data[i].sellerForMobile?.name,
              serviceMap.length - 1);
        } catch (innerError, innerStackTrace) {
          print("⚠️ Error processing service at index $i: $innerError");
          print("📌 StackTrace: $innerStackTrace");
        }
      }
      notifyListeners();
    } catch (e, stackTrace) {
      print("❌ Exception in setServiceList: $e");
      print("📌 StackTrace: $stackTrace");
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

  void resetFilters() {
    selectedCategory = lnProvider.getString('Select Category');
    selectedCategoryId = 0;

    selectedSubcat = lnProvider.getString('Select Subcategory');
    selectedSubcatId = 0;

    selectedRating = 'All';
    selectedRatingId = 0;

    selectedSortby = 'All';
    selectedSortbyId = '';

    serviceMap = [];
    averageRateList = [];
    imageList = [];
    currentPage = 1;
    _searchText = null;

    notifyListeners();
  }

  Future<bool> fetchAllService(BuildContext context,
      {bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        serviceMap = []; // Clear the existing service map
        notifyListeners(); // 🔹 Ensure UI updates
        setLoadingTrue(); // Set loading state to true
        setCurrentPage(1); // Reset current page to 1
      }

      var connection = await checkConnection();
      if (!connection) {
        print("❌ No internet connection.");
        setLoadingFalse();
        notifyListeners();
        return false;
      }

      String url =
          "$baseApi/service-list/category-subcategory-rating-sort-by-search?page=$currentPage&searchText=${searchText ?? ''}";

      print("🌍 Fetching from URL: $url\n");

      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200 || response.statusCode == 201) {
        var decodedResponse = jsonDecode(response.body);
        ServiceByFilterModel serviceByFilterModel =
            ServiceByFilterModel.fromJson(decodedResponse);

        print(
            "✅ Data received: ${serviceByFilterModel.allServices.data.length} services");

        setTotalPage(serviceByFilterModel.allServices.lastPage);

        List<double> averageRateList = [];
        List<String?> imageList = [];

        for (var service in serviceByFilterModel.allServices.data) {
          String? serviceImage = serviceByFilterModel.serviceImage
              .firstWhere((img) => img != null, orElse: () => null)
              ?.imgUrl;

          int totalRating = service.reviewsForMobile
              .fold(0, (sum, review) => sum + (review.rating?.toInt() ?? 0));

          double averageRate = service.reviewsForMobile.isNotEmpty
              ? totalRating / service.reviewsForMobile.length
              : 0;

          averageRateList.add(averageRate);
          imageList.add(serviceImage);
        }

        setServiceList(
            serviceByFilterModel, averageRateList, imageList, !isRefresh);

        // Increment currentPage only if not refreshing
        if (!isRefresh) {
          currentPage++;
          setCurrentPage(currentPage);
        }

        setLoadingFalse();
        notifyListeners(); // 🔹 Ensure UI updates after fetching data
        return true;
      } else {
        // serviceMap.clear();
        print("❌ API Error: ${response.statusCode} - ${response.body}");
        setLoadingFalse();
        notifyListeners(); // 🔹 Ensure UI updates on error
        return false;
      }
    } catch (e, stackTrace) {
      print("❌ Exception in fetchAllService: $e");
      print("📌 StackTrace: $stackTrace");
      setLoadingFalse();
      notifyListeners(); // 🔹 Ensure UI updates on error
      return false;
    }
  }
}
