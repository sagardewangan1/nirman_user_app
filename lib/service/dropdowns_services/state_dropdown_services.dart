import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/model/dropdown_models/states_dropdown_model.dart';
import 'package:qixer/service/dropdowns_services/country_dropdown_service.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StateDropdownService with ChangeNotifier {
  var statesDropdownList = [];
  var statesDropdownIndexList = [];

  dynamic selectedState = 'Select State';
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
      // ✅ Sirf refresh pe puri list clear ho
      statesDropdownList.clear();
      statesDropdownIndexList.clear();
      setStateDefault();
      setCurrentPage(1);
    } else if (currentPage == 1) {
      // ✅ Sirf page 1 load hone pe ek baar clear ho, baaki pages sirf naye data add karein
      statesDropdownList.clear();
      statesDropdownIndexList.clear();
    }

    var selectedCountryId =
        Provider.of<CountryDropdownService>(context, listen: false)
            .selectedCountryId;
    String url =
        '$baseApi/country/service-city/$selectedCountryId?page=$currentPage';

    var response = await http.get(Uri.parse(url));
    print("url states====> $url");

    if ((response.statusCode == 200 || response.statusCode == 201)) {
      var jsonResponse = jsonDecode(response.body);
      var data = StatesDropdownModel.fromJson(jsonResponse);

      if (data.serviceCities.data.isNotEmpty) {
        for (var city in data.serviceCities.data) {
          statesDropdownList.add(city.serviceCity);
          statesDropdownIndexList.add(city.id);
        }

        notifyListeners();

        // ✅ Pagination: Next Page ho to sirf naye data add ho
        if (jsonResponse['service_cities']['next_page_url'] != null) {
          currentPage++;
          setCurrentPage(currentPage);
        } else {
          // refreshController.loadNoData();
        }

        return true;
      }
    }

    return false;
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
    if (searchText.trim().isEmpty) {
      // ✅ Agar search text empty ho gaya, to poora list reload ho
      return fetchStates(context, isrefresh: true);
    }

    if (isSearching) {
      setStateDefault();
    }

    var url = Uri.parse('$baseApi/city-search?q=$searchText');
    print("🔍 Searching for: $searchText");
    var response = await http.get(url);

    if ((response.statusCode == 200 || response.statusCode == 201) &&
        jsonDecode(response.body)['service_cities']['data'].isNotEmpty) {
      // ✅ Purani list clear karke naye search results add karo
      statesDropdownList.clear();
      statesDropdownIndexList.clear();

      var data = StatesDropdownModel.fromJson(jsonDecode(response.body));
      for (var city in data.serviceCities.data) {
        statesDropdownList.add(city.serviceCity);
        statesDropdownIndexList.add(city.id);
      }

      notifyListeners();
      currentPage = 1; // ✅ Reset page number for next pagination
      return true;
    } else {
      // ✅ Agar koi result nahi mila, to default state dikhayein
      if (!statesDropdownList
          .contains(AppLocalizations.of(context)!.selectState)) {
        statesDropdownList.add(AppLocalizations.of(context)!.selectState);
        statesDropdownIndexList.add(defaultId);
        selectedState = AppLocalizations.of(context)!.selectState;
        selectedStateId = defaultId;
      }
      notifyListeners();
      return false;
    }
  }
}
