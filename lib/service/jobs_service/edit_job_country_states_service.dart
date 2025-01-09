import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/model/states_dropdown_model.dart';
import 'package:qixer/service/dropdowns_services/country_dropdown_service.dart';
import 'package:qixer/service/jobs_service/my_jobs_service.dart';
import 'package:qixer/view/utils/others_helper.dart';

class EditJobCountryStatesService with ChangeNotifier {
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

  bool isLoading = false;

  setCountryValue(value) {
    selectedCountry = value;
    notifyListeners();
  }

  setStatesValue(value) {
    selectedState = value;
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

  setLoadingStatus(bool status) {
    isLoading = status;
    notifyListeners();
  }

  getCountryState(BuildContext context, {required jobIndex}) {
    countryDropdownList =
        Provider.of<CountryDropdownService>(context, listen: false)
            .countryDropdownList;

    countryDropdownIndexList =
        Provider.of<CountryDropdownService>(context, listen: false)
            .countryDropdownIndexList;

    //set Country id based on job
    var countryId = Provider.of<MyJobsService>(context, listen: false)
        .myJobsListMap[jobIndex]['countryId'];

    setSelectedCountryId(countryId);

    var countryName =
        countryDropdownList[countryDropdownIndexList.indexOf(countryId)];
    setCountryValue(countryName);

    // get state accordingly
  }

  Future<bool> fetchStates(
    BuildContext context, {
    required countryId,
    required jobIndex,
  }) async {
    //make states list empty first

    statesDropdownList = [];
    statesDropdownIndexList = [];
    Future.delayed(const Duration(milliseconds: 500), () {
      notifyListeners();
    });

    var response =
        await http.get(Uri.parse('$baseApi/country/service-city/$countryId'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = StatesDropdownModel.fromJson(jsonDecode(response.body));
      for (int i = 0; i < data.serviceCities.length; i++) {
        statesDropdownList.add(data.serviceCities[i].serviceCity);
        statesDropdownIndexList.add(data.serviceCities[i].id);
      }

      //state id from the job selected
      var stateId = Provider.of<MyJobsService>(context, listen: false)
          .myJobsListMap[jobIndex]['cityId'];

      setSelectedStatesId(stateId);

      var stateName =
          statesDropdownList[statesDropdownIndexList.indexOf(stateId)];

      setStatesValue(stateName);

      notifyListeners();
      return true;
    } else {
      //error fetching data
      statesDropdownList.add('Select State');
      statesDropdownIndexList.add('0');
      selectedState = 'Select State';
      selectedStateId = '0';
      notifyListeners();
      return false;
    }
  }
}
