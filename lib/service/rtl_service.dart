import 'dart:async';
import 'dart:convert';
import 'dart:io';

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

  Future<void> fetchCurrency() async {
    if (!alreadyCurrencyLoaded) {
      try {
        debugPrint("📡 Fetching Currency...");

        var response = await http
            .get(Uri.parse('$baseApi/currency'))
            .timeout(const Duration(seconds: 20)); // ✅ Timeout added

        if (response.statusCode == 200 || response.statusCode == 201) {
          var responseData = jsonDecode(response.body);

          debugPrint("✅ API Response: ${response.body}");

          currency =
              responseData['currency']['symbol'] ?? '₹'; // ✅ Default Value
          currencyDirection = responseData['currency']['position'] ?? 'right';
          currencyCode = responseData['currency']['code'] ?? "INR";

          alreadyCurrencyLoaded = true;
          notifyListeners();
        } else {
          debugPrint("⚠️ API Error: ${response.statusCode} - ${response.body}");
        }
      } on SocketException {
        debugPrint("❌ Network Error: Please check your internet connection.");
      } on http.ClientException {
        debugPrint(
            "❌ ClientException: Server closed connection before full response.");
      } on TimeoutException {
        debugPrint("⏳ Timeout Error: API is taking too long to respond.");
      } catch (e) {
        debugPrint("❌ Unexpected Error in fetchCurrency: $e");
      }
    } else {
      debugPrint("✅ Currency already loaded, skipping fetch.");
    }
  }

  Future<void> fetchDirection(BuildContext context) async {
    if (!alreadyRtlLoaded) {
      try {
        var response = await http
            .get(Uri.parse('$baseApi/language'))
            .timeout(const Duration(seconds: 10)); // ✅ Timeout Added

        debugPrint(response.body.toString());

        if (response.statusCode == 200 || response.statusCode == 201) {
          var responseData = jsonDecode(response.body);
          direction = responseData['language']['direction'];
          langId = responseData['language']['id'].toString();
          langSlug = responseData['language']['slug'].toString();
          final srf = await SharedPreferences.getInstance();
          var now = DateTime.now();

          // ✅ Lang ID First Time Save Karo
          if (!srf.containsKey('langId')) {
            srf.setString('langId', langId!);
            srf.setString('update_date', now.toIso8601String());
            await Provider.of<AppStringService>(context, listen: false)
                .fetchTranslatedStrings(context);
          }
          // ✅ Agar Lang Change Hui To Update Karo
          else if (srf.getString('langId') != langId) {
            srf.setString('langId', langId!);
            srf.setString('update_date', now.toIso8601String());
            await Provider.of<AppStringService>(context, listen: false)
                .fetchTranslatedStrings(context);
          }
          // ✅ Agar 5 Din Se Zyada Ho Gaya, To Refresh Karo (7200 Min = 5 Days)
          else if (now
                  .difference(DateTime.parse(
                      srf.getString('update_date') ?? now.toIso8601String()))
                  .inMinutes >
              7200) {
            srf.setString('update_date', now.toIso8601String());
            await Provider.of<AppStringService>(context, listen: false)
                .fetchTranslatedStrings(context);
          }
          // ✅ Nahi to Normal Call
          else {
            await Provider.of<AppStringService>(context, listen: false)
                .fetchTranslatedStrings(context, doNotLoad: false);
          }

          alreadyRtlLoaded = true; // ✅ Corrected Assignment
          notifyListeners();
        } else {
          debugPrint("⚠️ API Error: ${response.statusCode}");
        }
      } catch (e) {
        debugPrint("❌ Exception in fetchDirection: $e");
      }
    } else {
      debugPrint("✅ Already loaded, skipping fetchDirection()");
    }
  }
}
