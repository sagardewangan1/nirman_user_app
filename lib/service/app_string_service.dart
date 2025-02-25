import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qixer/service/common_service.dart';
import 'package:qixer/view/utils/app_strings.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStringService with ChangeNotifier {
  bool isloading = false;

  Map tStrings = {};

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  fetchTranslatedStrings(BuildContext context, {bool doNotLoad = false}) async {
    //if already loaded. no need to load again

    var connection = await checkConnection();
    if (connection) {
      //internet connection is on
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('shashaktnirmantoken');
      if (doNotLoad) {
        final strings = prefs.getString('translated_string');
        tStrings = jsonDecode(strings ?? 'null');
        return;
      }
      setLoadingTrue();

      var data = jsonEncode({
        "strings": jsonEncode(appStrings),
      });

      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        // "Accept": "application/json",
        "Content-Type": "application/json",
        // "Authorization": "Bearer $token",
      };

      log(jsonEncode(appStrings).toString());
      var response = await http.post(Uri.parse('$baseApi/translate-string'),
          headers: header, body: data);

      try {
        if (response.statusCode == 201) {
          debugPrint(response.body.toString());
          tStrings = jsonDecode(response.body)['strings'];
          prefs.setString('translated_string', jsonEncode(tStrings));
          notifyListeners();
        } else {}
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  getString(String staticString) {
    try {
      if (tStrings.containsKey(staticString)) {
        return tStrings[staticString];
      } else {
        return staticString;
      }
    } catch (e) {
      debugPrint(e.toString());
      return staticString;
    }
  }
}
