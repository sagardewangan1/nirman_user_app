import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/model/dropdown_models/states_dropdown_model.dart';
import 'package:qixer/service/dropdowns_services/country_dropdown_service.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/view/utils/others_helper.dart';

class StateDropdownService with ChangeNotifier {
  var statesDropdownList = [];
  var statesDropdownIndexList = [];

  dynamic selectedState = 'Select City';
  dynamic selectedStateId = defaultId;

  bool isLoading = false;

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

  setStateDefault() {
    statesDropdownList = [];
    statesDropdownIndexList = [];
    selectedState = 'Select City';
    selectedStateId = defaultId;

    currentPage = 1;
    notifyListeners();
  }

  setStatesValue(value) {
    selectedState = value;
    notifyListeners();
  }

  setSelectedStatesId(value) {
    selectedStateId = value;
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

  Future<bool> fetchStates(BuildContext context,
      {bool isrefresh = false}) async {
    if (isrefresh) {
      //making the list empty first to show loading bar (we are showing loading bar while the product list is empty)
      //we are make the list empty when the sub category or brand is selected because then the refresh is true
      setStateDefault();

      setCurrentPage(currentPage);
    }

    var selectedCountryId =
        Provider.of<CountryDropdownService>(context, listen: false)
            .selectedCountryId;

    var response = await http.get(Uri.parse(
        '$baseApi/country/service-city/$selectedCountryId?page=$currentPage'));

    if ((response.statusCode == 200 || response.statusCode == 201) &&
        jsonDecode(response.body)['service_cities']['data'].isNotEmpty) {
      var data = StatesDropdownModel.fromJson(jsonDecode(response.body));
      for (int i = 0; i < data.serviceCities.data.length; i++) {
        statesDropdownList.add(data.serviceCities.data[i].serviceCity);
        statesDropdownIndexList.add(data.serviceCities.data[i].id);
      }

      set_State(context, data: data);
      notifyListeners();

      currentPage++;
      setCurrentPage(currentPage);

      return true;
    } else {
      //error fetching data
      statesDropdownList.add('Select City');
      statesDropdownIndexList.add(defaultId);
      selectedState = 'Select City';
      selectedStateId = defaultId;
      notifyListeners();
      return false;
    }
  }

  //Set state based on user profile
//==============================>
  setStateBasedOnUserProfile(BuildContext context) {
    selectedState = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .city
            ?.serviceCity ??
        'Select City';
    selectedStateId = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .city
            ?.id ??
        defaultId;
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   notifyListeners();
    // });
  }

  //==============>
  set_State(BuildContext context, {StatesDropdownModel? data}) {
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

        setStateBasedOnUserProfile(context);
      } else {
        if (data != null) {
          selectedState = data.serviceCities.data[0].serviceCity;
          selectedStateId = data.serviceCities.data[0].id;
        }
      }
    } else {
      if (data != null) {
        selectedState = data.serviceCities.data[0].serviceCity;
        selectedStateId = data.serviceCities.data[0].id;
      }
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      notifyListeners();
    });
  }

  // ================>
  // Search
  // ================>

  Future<bool> searchState(BuildContext context, String searchText,
      {bool isrefresh = false, bool isSearching = false}) async {
    if (isSearching) {
      setStateDefault();
    }

    var response =
        await http.get(Uri.parse('$baseApi/city-search?q=$searchText'));
    if ((response.statusCode == 200 || response.statusCode == 201) &&
        jsonDecode(response.body)['service_cities']['data'].isNotEmpty) {
      var data = StatesDropdownModel.fromJson(jsonDecode(response.body));
      for (int i = 0; i < data.serviceCities.data.length; i++) {
        statesDropdownList.add(data.serviceCities.data[i].serviceCity);
        statesDropdownIndexList.add(data.serviceCities.data[i].id);
      }

      notifyListeners();

      currentPage++;
      setCurrentPage(currentPage);

      return true;
    } else {
      //error fetching data
      statesDropdownList.add('Select City');
      statesDropdownIndexList.add(defaultId);
      selectedState = 'Select City';
      selectedStateId = defaultId;
      notifyListeners();
      return false;
    }
  }
}
