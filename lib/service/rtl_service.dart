import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_string_service.dart';

class RtlService with ChangeNotifier {
  /// RTL support
  String direction = 'ltr';
  String? langId;
  String langSlug = 'en_US';

  String currency = '\$';
  String currencyDirection = 'left';
  String currencyCode = 'USD';

  bool alreadyCurrencyLoaded = false;
  bool alreadyRtlLoaded = false;

  fetchCurrency() async {
    if (alreadyCurrencyLoaded == false) {
      var response = await http.get(Uri.parse('$baseApi/currency'));
      if (response.statusCode == 201) {
        debugPrint(response.body.toString());
        currency = jsonDecode(response.body)['currency']['symbol'];
        currencyDirection =
            jsonDecode(response.body)['currency']['position'] ?? 'left';
        currencyCode = jsonDecode(response.body)['currency']['code'] ?? "USD";
        alreadyCurrencyLoaded == true;
        notifyListeners();
      } else {
        debugPrint(response.body.toString());
      }
    } else {
      //already loaded from server. no need to load again
    }
  }

  fetchDirection(BuildContext context) async {
    if (alreadyRtlLoaded == false) {
      var response = await http.get(Uri.parse('$baseApi/language'));
      debugPrint(response.body.toString());
      if (response.statusCode == 201) {
        direction = jsonDecode(response.body)['language']['direction'];
        final srf = await SharedPreferences.getInstance();
        langId = jsonDecode(response.body)['language']['id'].toString();
        langSlug = jsonDecode(response.body)['language']['slug'].toString();
        var now = DateTime.now();

        if (!srf.containsKey('langId')) {
          srf.setString('langId', langId!);
          srf.setString('update_date', now.toIso8601String());
          await Provider.of<AppStringService>(context, listen: false)
              .fetchTranslatedStrings(context);
        } else if (srf.getString('langId') != langId) {
          srf.setString('update_date', now.toIso8601String());
          srf.setString('langId', langId!);
          await Provider.of<AppStringService>(context, listen: false)
              .fetchTranslatedStrings(context);
        } else if (now
                .difference(DateTime.parse(
                    srf.getString('update_date') ?? now.toIso8601String()))
                .inMinutes >
            7200) {
          srf.setString('update_date', now.toIso8601String());
          await Provider.of<AppStringService>(context, listen: false)
              .fetchTranslatedStrings(context);
        } else {
          await Provider.of<AppStringService>(context, listen: false)
              .fetchTranslatedStrings(context, doNotLoad: false);
        }

        alreadyRtlLoaded == true;
        notifyListeners();
      } else {
        debugPrint(response.body.toString());
      }
    } else {
      //already loaded from server. no need to load again
    }
  }
}
