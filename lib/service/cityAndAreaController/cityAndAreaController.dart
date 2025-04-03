import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:qixer/model/dropdown_models/states_dropdown_model.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:http/http.dart' as http;

class CityAndAreaController extends ChangeNotifier {
  // State related variables and methods
  int? _stateId;
  int? get stateId => _stateId;
  String? _stateName = "Select State";
  String? get stateName => _stateName;
  ConstantColors cc = ConstantColors();

  void setStateNameAndID({required int? stateId, required String stateName}) {
    _stateId = stateId;
    _stateName = stateName;
    notifyListeners();
  }

  int _statePageNo = 1;
  int get statePageNo => _statePageNo;

  // Track total pages for pagination
  int _totalPages = 1;
  int get totalPages => _totalPages;

  // Total items count
  int _totalItems = 0;
  int get totalItems => _totalItems;

  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Method to set the page number to a specific value
  void setStatePageNo(int pageNo) {
    _statePageNo = pageNo;
    notifyListeners();
  }

  // Method to increment the page number for loading more data
  void nextPage() {
    if (_statePageNo < _totalPages) {
      _statePageNo++;
      print("Moving to page $_statePageNo of $_totalPages");
      notifyListeners();
    } else {
      print("Already at last page: $_statePageNo");
    }
  }

  // Method to reset pagination to first page
  void resetPagination() {
    _statePageNo = 1;
    _myState = [];
    notifyListeners();
  }

  // Check if there are more pages to load
  bool hasMorePages() {
    return _statePageNo < _totalPages;
  }

  List<Datum> _myState = [];
  List<Datum> get myState => _myState;

  String _searchQuery = "";
  String get searchQuery => _searchQuery;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<bool> fetchState(BuildContext context) async {
    if (_isLoading) {
      print("Already loading data, ignoring request");
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      var apilink =
          Uri.parse('$baseApi/country/service-city/6?page=$_statePageNo');
      print("API Link: $apilink");

      var response = await http.get(apilink);
      var decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Check if the response contains service_cities
        if (decodedResponse.containsKey("service_cities") &&
            decodedResponse["service_cities"].containsKey("data")) {
          var citiesData = decodedResponse["service_cities"]["data"] as List;

          // If no data is returned, handle it
          if (citiesData.isEmpty) {
            print("No cities data returned from API");
            _isLoading = false;
            notifyListeners();
            return false;
          }

          List<Datum> newStates =
              citiesData.map((e) => Datum.fromJson(e)).toList();

          print("New states loaded: ${newStates.length}");

          if (_statePageNo == 1) {
            _myState = newStates; // Replace only on first page
            print(
                "First page: Replaced state list with ${_myState.length} items");
          } else {
            // Check for duplicates before adding
            final existingIds = _myState.map((state) => state.id).toSet();
            final uniqueNewStates = newStates
                .where((state) => !existingIds.contains(state.id))
                .toList();

            _myState.addAll(uniqueNewStates); // Append for next pages
            print(
                "Next page: Added ${uniqueNewStates.length} new items. Total: ${_myState.length}");
          }

          // Update pagination information
          _totalPages = int.parse(
              decodedResponse["service_cities"]["last_page"].toString());
          _totalItems =
              int.parse(decodedResponse["service_cities"]["total"].toString());

          print("Current page: $_statePageNo, Last page: $_totalPages");
          print(
              "Total states: $_totalItems, Current loaded: ${_myState.length}");
          print("State List: ${_myState.map((e) => e.serviceCity).toList()}");

          _isLoading = false;
          notifyListeners();
          return true;
        } else {
          print("Error: API response format incorrect");
          print("Response: $decodedResponse");
          _isLoading = false;
          notifyListeners();
          return false;
        }
      } else {
        OthersHelper()
            .showToast(decodedResponse["message"].toString(), cc.errorColor);
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e, stackTrace) {
      print("Exception: $e");
      print("StackTrace: $stackTrace");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> searchState(BuildContext context) async {
    if (_isLoading) {
      print("Already loading data, ignoring request");
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      String queryParam = _searchQuery.isNotEmpty ? _searchQuery : "";

      if (queryParam.isEmpty) {
        print("Search query is empty, returning.");
        _isLoading = false;
        notifyListeners();
        return false;
      }

      var apilink = Uri.parse('$baseApi/city-search?q=$queryParam');
      print("API Link: $apilink");

      var response = await http.get(apilink);
      var decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (decodedResponse.containsKey("service_cities") &&
            decodedResponse["service_cities"].containsKey("data")) {
          var citiesData = decodedResponse["service_cities"]["data"] as List;

          if (citiesData.isEmpty) {
            print("No cities data returned from API");
            _myState = [];
            _isLoading = false;
            notifyListeners();
            return false;
          }

          List<Datum> newStates =
              citiesData.map((e) => Datum.fromJson(e)).toList();

          // **Search reset karke naye data ko set karna hai**
          _myState = newStates;
          _statePageNo = 1; // Reset pagination
          _totalPages = 1; // Search ke liye pagination reset
          _totalItems = newStates.length;

          print("Search Result: ${_myState.length} states found");

          _isLoading = false;
          notifyListeners();
          return true;
        } else {
          print("Error: API response format incorrect");
          _isLoading = false;
          notifyListeners();
          return false;
        }
      } else {
        OthersHelper()
            .showToast(decodedResponse["message"].toString(), cc.errorColor);
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e, stackTrace) {
      print("Exception: $e");
      print("StackTrace: $stackTrace");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // For Get Area

  // State related variables and methods
  int? _cityId;
  int? get cityId => _cityId;
  String? _cityName = "Select Area";
  String? get cityName => _cityName;

  void setCityNameAndID({required int? cityID, required String cityName}) {
    _cityId = cityID;
    _cityName = cityName;
    debugPrint("cityid and name ====> $_cityId and $_cityName");
    notifyListeners();
  }

  int _cityPageNo = 1;
  int get cityPageNo => _cityPageNo;

  List<Datum> _myCity = [];
  List<Datum> get myCity => _myCity;

  Future<bool> fetchArea(BuildContext context) async {
    if (_isLoading) {
      print("Already loading data, ignoring request");
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      var apilink = Uri.parse(
          '$baseApi/country/service-city/service-area/6/$_stateId?page=$_statePageNo');
      print("API Link: $apilink");

      var response = await http.get(apilink);
      printLargeResponse(response.body);
      var decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Check if the response contains service_cities
        if (decodedResponse.containsKey("service_areas") &&
            decodedResponse["service_areas"].containsKey("data")) {
          var citiesData = decodedResponse["service_areas"]["data"] as List;

          // If no data is returned, handle it
          if (citiesData.isEmpty) {
            print("No cities data returned from API");
            _isLoading = false;
            notifyListeners();
            return false;
          }

          List<Datum> newCity =
              citiesData.map((e) => Datum.fromJson(e)).toList();

          print("New myCity loaded: ${newCity.length}");

          if (_statePageNo == 1) {
            _myCity = newCity; // Replace only on first page
            print(
                "First page: Replaced state list with ${_myCity.length} items");
          } else {
            // Check for duplicates before adding
            final existingIds = _myCity.map((city) => city.id).toSet();
            final uniqueNewStates = newCity
                .where((state) => !existingIds.contains(state.id))
                .toList();

            _myCity.addAll(uniqueNewStates); // Append for next pages
            print(
                "Next page: Added ${uniqueNewStates.length} new items. Total: ${_myCity.length}");
          }

          // Update pagination information
          _totalPages = int.parse(
              decodedResponse["service_areas"]["last_page"].toString());
          _totalItems =
              int.parse(decodedResponse["service_areas"]["total"].toString());

          print("Current page: $_statePageNo, Last page: $_totalPages");
          print("Total area: $_totalItems, Current loaded: ${_myCity.length}");
          print("area List: ${_myCity.map((e) => e.serviceArea).toList()}");

          _isLoading = false;
          notifyListeners();
          return true;
        } else {
          print("Error: API response format incorrect");
          print("Response: $decodedResponse");
          _isLoading = false;
          notifyListeners();
          return false;
        }
      } else {
        OthersHelper()
            .showToast(decodedResponse["message"].toString(), cc.errorColor);
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e, stackTrace) {
      print("Exception: $e");
      print("StackTrace: $stackTrace");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> searchArea(BuildContext context) async {
    if (_isLoading) {
      print("Already loading data, ignoring request");
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      String queryParam = _searchQuery.isNotEmpty ? _searchQuery : "";

      if (queryParam.isEmpty) {
        print("Search query is empty, returning.");
        _isLoading = false;
        notifyListeners();
        return false;
      }

      var apilink = Uri.parse(
          '$baseApi/area-search?service_city_id=$_stateId&q=$queryParam');
      print("API Link: $apilink");

      var response = await http.get(apilink);
      var decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (decodedResponse.containsKey("service_areas") &&
            decodedResponse["service_areas"].containsKey("data")) {
          var citiesData = decodedResponse["service_areas"]["data"] as List;

          if (citiesData.isEmpty) {
            print("No cities data returned from API");
            _myCity = [];
            _isLoading = false;
            notifyListeners();
            return false;
          }

          List<Datum> newCity =
              citiesData.map((e) => Datum.fromJson(e)).toList();

          // **Search reset karke naye data ko set karna hai**
          _myCity = newCity;
          _statePageNo = 1; // Reset pagination
          _totalPages = 1; // Search ke liye pagination reset
          _totalItems = newCity.length;

          print("Search Result: ${_myCity.length} states found");

          _isLoading = false;
          notifyListeners();
          return true;
        } else {
          print("Error: API response format incorrect");
          _isLoading = false;
          notifyListeners();
          return false;
        }
      } else {
        OthersHelper()
            .showToast(decodedResponse["message"].toString(), cc.errorColor);
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e, stackTrace) {
      print("Exception: $e");
      print("StackTrace: $stackTrace");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void resetAll() {
    // Reset State selection
    _stateId = null;
    _stateName = "Select State";

    // Reset City selection
    _cityId = null;
    _cityName = "Select Area";

    // Reset Search Query
    _searchQuery = "";

    // Reset Pagination
    _statePageNo = 1;
    _cityPageNo = 1;
    _totalPages = 1;
    _totalItems = 0;

    // Clear Lists
    _myState.clear();
    _myCity.clear();

    // Notify Listeners to Update UI
    notifyListeners();
    print("✅ All data reset successfully");
  }
}
