// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
// import 'package:qixer/model/country_dropdown_model.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';

import '../model/dropdown_models/area_dropdown_model.dart';
import '../model/dropdown_models/country_dropdown_model.dart';
import '../model/dropdown_models/states_dropdown_model.dart';

class CountryStatesService with ChangeNotifier {
  var countryDropdownList = [];
  var countryDropdownIndexList = [];
  var selectedCountry;
  var selectedCountryId;

  var statesDropdownList = [];
  var statesDropdownIndexList = [];
  // var oldStateDropdownList;
  // var oldStatesDropdownIndexList = [];
  var selectedState;
  var selectedStateId;

  var areaDropdownList = [];
  var areaDropdownIndexList = [];
  var selectedArea;
  var selectedAreaId;

  bool isLoading = false;

  // setStateAndAreaValueToDefault() {
  //   statesDropdownList = oldStateDropdownList;
  //   statesDropdownIndexList = oldStatesDropdownIndexList;
  //   notifyListeners();
  // }

  setCountryValue(value) {
    selectedCountry = value;
    notifyListeners();
  }

  setStatesValue(value) {
    selectedState = value;
    notifyListeners();
  }

  setAreaValue(value) {
    selectedArea = value;
    notifyListeners();
  }

  setSelectedCountryId(value) {
    selectedCountryId = value;
    notifyListeners();
  }

  setSelectedStatesId(value) {
    selectedStateId = value;
    notifyListeners();
  }

  setSelectedAreaId(value) {
    selectedAreaId = value;
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

//Set country based on user profile
//==============================>

  setCountryBasedOnUserProfile(BuildContext context) {
    selectedCountry = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .country
            .country ??
        lnProvider.getString('Select Country');
    selectedCountryId = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .countryId ??
        '0';

    Future.delayed(const Duration(milliseconds: 500), () {
      notifyListeners();
    });
  }

//Set state based on user profile
//==============================>
  setStateBasedOnUserProfile(BuildContext context) {
    selectedState = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .city
            .serviceCity ??
        lnProvider.getString('Select State');
    selectedStateId = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .city
            .id ??
        '0';
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   notifyListeners();
    // });
  }

  //Set area based on user profile
//==============================>
  setAreaBasedOnUserProfile(BuildContext context) {
    selectedArea = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .area
            .serviceArea ??
        lnProvider.getString('Select Area');
    selectedAreaId = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .area
            .id ??
        '0';
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   notifyListeners();
    // });
  }

  fetchCountries(BuildContext context) async {
    if (countryDropdownList.isNotEmpty) return;

    if (countryDropdownList.isEmpty) {
      Future.delayed(const Duration(milliseconds: 500), () {
        setLoadingTrue();
      });
      var response = await http.get(Uri.parse('$baseApi/country'));

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = CountryDropdownModel.fromJson(jsonDecode(response.body));
        for (int i = 0; i < data.countries.data.length; i++) {
          countryDropdownList.add(data.countries.data[i].country);
          countryDropdownIndexList.add(data.countries.data[i].id);
        }

        setCountry(context, data: data);

        notifyListeners();
        fetchStates(selectedCountryId, context);
      } else {
        //error fetching data
        countryDropdownList.add(lnProvider.getString('Select Country'));
        countryDropdownIndexList.add('0');
        selectedCountry = lnProvider.getString('Select Country');
        selectedCountryId = '0';
        fetchStates(selectedCountryId, context);
        notifyListeners();
      }
    } else {
      //country list already loaded from api
      setCountry(context);
      fetchStates(selectedCountryId, context);
      // set_State(context);
      // setArea(context);
    }
  }

  Future<bool> fetchStates(countryId, BuildContext context) async {
    //make states list empty first
    statesDropdownList = [];
    statesDropdownIndexList = [];
    Future.delayed(const Duration(milliseconds: 500), () {
      notifyListeners();
    });

    var apilink = Uri.parse('$baseApi/country/service-city/$countryId');
    print("api link====> $apilink");
    var response = await http.get(apilink);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = StatesDropdownModel.fromJson(jsonDecode(response.body));
      for (int i = 0; i < data.serviceCities.data.length; i++) {
        statesDropdownList.add(data.serviceCities.data[i].serviceCity);
        statesDropdownIndexList.add(data.serviceCities.data[i].id);
      }

      //keeping the data
      // oldStateDropdownList = statesDropdownList;
      // oldStatesDropdownIndexList = oldStatesDropdownIndexList;

      set_State(context, data: data);
      notifyListeners();
      fetchArea(countryId, selectedStateId, context);
      print("calling if");
      return true;
    } else {
      print("calling else");
      fetchArea(countryId, selectedStateId, context);
      //error fetching data
      statesDropdownList.add(lnProvider.getString('Select State'));
      statesDropdownIndexList.add('0');
      selectedState = lnProvider.getString('Select State');
      selectedStateId = '0';
      notifyListeners();
      return false;
    }
  }

  fetchArea(countryId, stateId, BuildContext context) async {
    //make states list empty first
    areaDropdownList = [];
    areaDropdownIndexList = [];
    notifyListeners();

    var response = await http.get(Uri.parse(
        '$baseApi/country/service-city/service-area/$countryId/$stateId'));
    printLargeResponse(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = AreaDropdownModel.fromJson(jsonDecode(response.body));
      for (int i = 0; i < data.serviceAreas.data.length; i++) {
        areaDropdownList.add(data.serviceAreas.data[i].serviceArea);
        areaDropdownIndexList.add(data.serviceAreas.data[i].id);
      }

      setArea(context, data: data);
      notifyListeners();
    } else {
      areaDropdownList.add(lnProvider.getString('Select Area'));
      areaDropdownIndexList.add('0');
      selectedArea = lnProvider.getString('Select Area');
      selectedAreaId = '0';
      notifyListeners();
    }
  }

  setCountry(BuildContext context, {data}) {
    var profileData =
        Provider.of<ProfileService>(context, listen: false).profileDetails;
    //if profile of user loaded then show selected dropdown data based on the user profile
    if (profileData != null &&
        profileData.userDetails.country.country != null) {
      setCountryBasedOnUserProfile(context);
    } else {
      if (data != null) {
        selectedCountry = data.countries[0].country;
        selectedCountryId = data.countries[0].id;
      }
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      notifyListeners();
    });
  }

//==============>
  set_State(BuildContext context, {data}) {
    var profileData =
        Provider.of<ProfileService>(context, listen: false).profileDetails;

    if (profileData != null) {
      var userCountryId = Provider.of<ProfileService>(context, listen: false)
          .profileDetails
          .userDetails
          .countryId;

      if (userCountryId == selectedCountryId) {
        //if user selected the country id which is save in his profile
        //only then show state/area based on that

        setStateBasedOnUserProfile(context);
      } else {
        if (data != null) {
          selectedState = data.serviceCities[0].serviceCity;
          selectedStateId = data.serviceCities[0].id;
        }
      }
    } else {
      if (data != null) {
        selectedState = data.serviceCities[0].serviceCity;
        selectedStateId = data.serviceCities[0].id;
      }
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      notifyListeners();
    });
  }

// ==================>
  setArea(BuildContext context, {data}) {
    var profileData =
        Provider.of<ProfileService>(context, listen: false).profileDetails;

    if (profileData != null) {
      var userCountryId = Provider.of<ProfileService>(context, listen: false)
          .profileDetails
          .userDetails
          .countryId;
      if (userCountryId == selectedCountryId) {
        //if user selected the country id which is save in his profile
        //only then show state/area based on that

        setAreaBasedOnUserProfile(context);
      } else {
        if (data != null) {
          selectedArea = data.serviceAreas[0].serviceArea;
          selectedAreaId = data.serviceAreas[0].id;
        }
      }
    } else {
      if (data != null) {
        selectedArea = data.serviceAreas[0].serviceArea;
        selectedAreaId = data.serviceAreas[0].id;
      }
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      notifyListeners();
    });
  }
}
