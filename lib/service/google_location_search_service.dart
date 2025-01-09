import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qixer/model/google_place_details_model.dart';
import 'package:qixer/model/google_places_model.dart';

import '../view/utils/others_helper.dart';

class GoogleLocationSearch with ChangeNotifier {
  List<Prediction> locations = [];
  bool isLoading = false;
  Prediction? geoLoc;

  setIsLoading(value) {
    if (value == isLoading) {
      return;
    }
    isLoading = value;
    notifyListeners();
  }

  resetLocations() {
    locations = [];
  }

  fetchLocations({location, region}) async {
    try {
      locations = [];
      setIsLoading(true);
      debugPrint(
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$location&language=en&region=$region&key=$mapApiKey"
              .toString());
      var headers = {'Accept': 'application/json'};
      var request = http.Request(
          'GET',
          Uri.parse(
              'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$location&language=en&region=$region&key=$mapApiKey'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      var responseString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        GooglePlacesModel responseData =
            googlePlacesModelFromJson(responseString);
        locations = responseData.predictions ?? [];
      } else {}
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setIsLoading(false);
    }
  }

  fetchGEOLocations({lat, lng}) async {
    try {
      locations = [];
      setIsLoading(true);
      debugPrint(
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat, $lng&key=$mapApiKey'
              .toString());
      var headers = {'Accept': 'application/json'};
      var request = http.Request(
          'GET',
          Uri.parse(
              'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat, $lng&key=$mapApiKey'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      var responseString = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        var responseData = jsonDecode(responseString);
        debugPrint(responseData.toString());
        bool breakLoop = false;
        var postCode;
        var city;
        for (var i = 0; i < responseData['results'].length; i++) {
          var element = responseData["results"][i];
          element["address_components"].forEach((e) {
            if (e["types"].contains("postal_code")) {
              breakLoop = true;
              postCode = e["long_name"];
            }
            if (e["types"].contains("sublocality")) {
              breakLoop = true;
              city = e["long_name"];
            }
          });
          if (breakLoop) break;
        }
        geoLoc = Prediction(
          description: responseData["results"]?[0]?['formatted_address'],
          postCode: postCode,
          city: city,
          lat: lat,
          lng: lng,
        );
      } else {}
    } finally {
      setIsLoading(false);
    }
  }

  Future<GooglePlaceDetailsModel?> fetchPlaceDetails(id) async {
    try {
      debugPrint("fetching place details $id".toString());
      locations = [];
      var headers = {'Accept': 'application/json'};
      setIsLoading(true);
      var response = await http.get(
        Uri.parse(
            'https://maps.googleapis.com/maps/api/place/details/json?place_id=$id&key=$mapApiKey'),
        headers: headers,
      );

      // request.headers.addAll(headers);

      // http.StreamedResponse response = await request.send();
      // final resBody = await response.stream.bytesToString();
      // debugPrint(response.body.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        GooglePlaceDetailsModel responseData =
            GooglePlaceDetailsModel.fromJson(jsonDecode(response.body));
        setIsLoading(false);
        debugPrint(responseData.toString());
        return responseData;
      } else {}
    } finally {
      setIsLoading(false);
    }
    error(e) {
      debugPrint(e.toString());
    }

    return null;
  }
}
