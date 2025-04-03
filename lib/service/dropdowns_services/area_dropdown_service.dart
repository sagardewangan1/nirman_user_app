// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/model/dropdown_models/area_dropdown_model.dart';
import 'package:qixer/service/dropdowns_services/country_dropdown_service.dart';
import 'package:qixer/service/dropdowns_services/state_dropdown_services.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/view/utils/others_helper.dart';

class AreaDropdownService with ChangeNotifier {
  var areaDropdownList = [];
  var areaDropdownIndexList = [];
  dynamic selectedArea = 'Select City';
  dynamic selectedAreaId = defaultId;

  final List<dynamic> _selectedCity = [];
  List<dynamic> get selectedCity => _selectedCity;
  final List<dynamic> _selectedCityID = [];
  List<dynamic> get selectedCityID => _selectedCityID;

  setSelectedCity(value, value2) {
    if (!_selectedCity.contains(value) && !_selectedCity.contains(value)) {
      _selectedCity.add(value);
      _selectedCityID.add(value2);
    } else {
      _selectedCity.remove(value);
      _selectedCityID.remove(value2);
    }
    notifyListeners();
  }

  late int totalPages;

  int currentPage = 1;

  setCurrentPage(newValue) {
    currentPage = newValue;
    notifyListeners();
  }

  setTotalPage(newPageNumber) {
    totalPages = newPageNumber;
    notifyListeners();
  }

  setAreaDefault() {
    areaDropdownList = [];
    areaDropdownIndexList = [];
    selectedArea = 'Select City';
    selectedAreaId = defaultId;

    currentPage = 1;
    notifyListeners();
  }

  setAreaValue(value) {
    selectedArea = value;
    notifyListeners();
  }

  setSelectedAreaId(value) {
    selectedAreaId = value;
    debugPrint("area id ----> $value");
    notifyListeners();
  }

  bool isLoading = false;

  setLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  //Set area based on user profile
//==============================>
  setAreaBasedOnUserProfile(BuildContext context) {
    selectedArea = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .area
            ?.serviceArea ??
        'Select City';
    selectedAreaId = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .area
            ?.id ??
        defaultId;
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   notifyListeners();
    // });
  }

  Future<bool> fetchArea(BuildContext context, {bool isrefresh = false}) async {
    if (isrefresh) {
      //making the list empty first to show loading bar (we are showing loading bar while the product list is empty)
      //we are make the list empty when the sub category or brand is selected because then the refresh is true
      setAreaDefault();

      setCurrentPage(currentPage);
    }

    var selectedCountryId =
        Provider.of<CountryDropdownService>(context, listen: false)
            .selectedCountryId;

    var selectedStateId =
        Provider.of<StateDropdownService>(context, listen: false)
            .selectedStateId;
    var apilink = Uri.parse(
        '$baseApi/country/service-city/service-area/$selectedCountryId/$selectedStateId?page=$currentPage');
    print("url==> $apilink");
    var response = await http.get(apilink);
    if ((response.statusCode == 200 || response.statusCode == 201) &&
        jsonDecode(response.body)['service_areas']['data'].isNotEmpty) {
      var data = AreaDropdownModel.fromJson(jsonDecode(response.body));
      for (int i = 0; i < data.serviceAreas.data.length; i++) {
        areaDropdownList.add(data.serviceAreas.data[i].serviceArea);
        areaDropdownIndexList.add(data.serviceAreas.data[i].id);
      }

      setArea(context, data: data);
      notifyListeners();

      currentPage++;
      setCurrentPage(currentPage);
      return true;
    } else {
      // areaDropdownList.add('Select City');
      areaDropdownIndexList.add(defaultId);
      selectedArea = 'Select City';
      selectedAreaId = defaultId;
      notifyListeners();
      return false;
    }
  }

// ==================>
  setArea(BuildContext context, {AreaDropdownModel? data}) {
    var profileData =
        Provider.of<ProfileService>(context, listen: false).profileDetails;

    if (profileData != null) {
      var userCountryId = Provider.of<ProfileService>(context, listen: false)
          .profileDetails
          .userDetails
          .countryId;

      var selectedCountryId =
          Provider.of<CountryDropdownService>(context, listen: false)
              .selectedCountryId;

      if (userCountryId == selectedCountryId) {
        //if user selected the country id which is save in his profile
        //only then show state/area based on that

        setAreaBasedOnUserProfile(context);
      } else {
        if (data != null) {
          selectedArea = data.serviceAreas.data[0].serviceArea;
          selectedAreaId = data.serviceAreas.data[0].id;
        }
      }
    } else {
      if (data != null) {
        selectedArea = data.serviceAreas.data[0].serviceArea;
        selectedAreaId = data.serviceAreas.data[0].id;
      }
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      notifyListeners();
    });
  }

  // ================>
  // Search
  // ================>
  Future<bool> searchArea(BuildContext context, String searchText,
      {bool isrefresh = false, bool isSearching = false}) async {
    if (isSearching) {
      setAreaDefault();
    }
    var selectedStateId =
        Provider.of<StateDropdownService>(context, listen: false)
            .selectedStateId;
    var response = await http.get(Uri.parse(
        '$baseApi/area-search?service_city_id=$selectedStateId&q=$searchText'));

    if ((response.statusCode == 200 || response.statusCode == 201) &&
        jsonDecode(response.body)['service_areas']['data'].isNotEmpty) {
      var data = AreaDropdownModel.fromJson(jsonDecode(response.body));
      for (int i = 0; i < data.serviceAreas.data.length; i++) {
        areaDropdownList.add(data.serviceAreas.data[i].serviceArea);
        areaDropdownIndexList.add(data.serviceAreas.data[i].id);
      }

      notifyListeners();

      currentPage++;
      setCurrentPage(currentPage);
      return true;
    } else {
      areaDropdownList.add('Select City');
      areaDropdownIndexList.add(defaultId);
      selectedArea = 'Select City';
      selectedAreaId = defaultId;
      notifyListeners();
      return false;
    }
  }
}
