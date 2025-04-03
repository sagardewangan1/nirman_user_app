import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/model/dropdown_models/country_dropdown_model.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/view/utils/others_helper.dart';

var defaultId = '';

class CountryDropdownService with ChangeNotifier {
  var countryDropdownList = [];
  var countryDropdownIndexList = [];
  dynamic selectedCountry = 'India';
  dynamic selectedCountryId = "6";

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

  setCountryValue(value) {
    selectedCountry = value;
    notifyListeners();
  }

  setSelectedCountryId(value) {
    selectedCountryId = value;
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

  setDefault() {
    countryDropdownList = [];
    countryDropdownIndexList = [];
    selectedCountry = 'Select Country';
    selectedCountryId = defaultId;
    notifyListeners();
  }

  Future<bool> fetchCountries(BuildContext context,
      {bool isrefresh = false}) async {
    if (countryDropdownList.isNotEmpty) return false;

    if (isrefresh) {
      //making the list empty first to show loading bar (we are showing loading bar while the product list is empty)
      //we are make the list empty when the sub category or brand is selected because then the refresh is true
      setDefault();

      setCurrentPage(currentPage);
    }

    if (countryDropdownList.isEmpty) {
      Future.delayed(const Duration(milliseconds: 500), () {
        setLoadingTrue();
      });
      var response =
          await http.get(Uri.parse('$baseApi/country?page=$currentPage'));
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          jsonDecode(response.body)['countries']['data'].isNotEmpty) {
        var data = CountryDropdownModel.fromJson(jsonDecode(response.body));
        for (int i = 0; i < data.countries.data.length; i++) {
          countryDropdownList.add(data.countries.data[i].country);
          countryDropdownIndexList.add(data.countries.data[i].id);
        }

        setCountry(context, data: data);

        notifyListeners();

        currentPage++;
        setCurrentPage(currentPage);
        return true;
      } else {
        //error fetching data
        countryDropdownList.add('Select Country');
        countryDropdownIndexList.add(defaultId);
        selectedCountry = 'Select Country';
        selectedCountryId = defaultId;
        notifyListeners();

        return false;
      }
    } else {
      //country list already loaded from api
      setCountry(context);

      return false;
    }
  }

  //Set country based on user profile
//==============================>

  setCountryBasedOnUserProfile(BuildContext context) {
    selectedCountry = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .country
            ?.country ??
        'Select Country';
    selectedCountryId = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .countryId ??
        defaultId;

    Future.delayed(const Duration(milliseconds: 500), () {
      notifyListeners();
    });
  }

  setCountry(BuildContext context, {CountryDropdownModel? data}) {
    var profileData =
        Provider.of<ProfileService>(context, listen: false).profileDetails;
    //if profile of user loaded then show selected dropdown data based on the user profile
    if (profileData != null &&
        profileData.userDetails.country.country != null) {
      setCountryBasedOnUserProfile(context);
    } else {
      if (data != null) {
        selectedCountry = data.countries.data[0].country;
        selectedCountryId = data.countries.data[0].id;
      }
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      notifyListeners();
    });
  }

  // ================>
  // Search country
  // ================>

  Future<bool> searchCountry(BuildContext context, String searchText,
      {bool isrefresh = false, bool isSearching = false}) async {
    if (isSearching) {
      setDefault();
    }

    var response =
        await http.get(Uri.parse('$baseApi/country-search?q=$searchText'));

    if ((response.statusCode == 200 || response.statusCode == 201) &&
        jsonDecode(response.body)['countries']['data'].isNotEmpty) {
      var data = CountryDropdownModel.fromJson(jsonDecode(response.body));
      for (int i = 0; i < data.countries.data.length; i++) {
        countryDropdownList.add(data.countries.data[i].country);
        countryDropdownIndexList.add(data.countries.data[i].id);
      }

      notifyListeners();

      currentPage++;
      setCurrentPage(currentPage);
      return true;
    } else {
      //error fetching data
      countryDropdownList.add('Select Country');
      countryDropdownIndexList.add(defaultId);
      selectedCountry = 'Select Country';
      selectedCountryId = defaultId;
      notifyListeners();

      return false;
    }
  }
}
