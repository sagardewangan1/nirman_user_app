import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:qixer/model/MyLeadsDataModel.dart';
import 'package:qixer/model/MyServiceListDataModel.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/getImageController.dart';
import 'package:qixer/service/profile_service.dart';

import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VendorDashboardService extends ChangeNotifier {
  MyServiceListDataModel _myServiceListDataModel = MyServiceListDataModel();
  MyServiceListDataModel get myServiceListDataModel => _myServiceListDataModel;

  MyLeadsDataModel _myLeadsDataModel = MyLeadsDataModel();
  MyLeadsDataModel get myLeadsDataModel => _myLeadsDataModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> getMyServiceLists() async {
    _isLoading = true;
    // notifyListeners();
    var connection = await checkConnection();
    if (!connection) {
      return false;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');
    if (token == null) {
      print("❌ Token not found. User not authenticated.");
      _isLoading = false;
      return false;
    }
    try {
      String url = "$baseApi/seller/service/my-services";
      var headers = {
        // "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
      var response = await http.get(Uri.parse(url), headers: headers);
      print("🔗 Request URL: $url");
      print("📩 Request Headers: $headers");
      print("📡 Response Status Code: ${response.statusCode}");
      print("📜 Response Body: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        _myServiceListDataModel =
            MyServiceListDataModel.fromJson(jsonDecode(response.body));
        print("📜 service list data : ${_myServiceListDataModel.myServices?.map(
          (e) => e.seller?.businessImage?.imgUrl,
        )}");
        _isLoading = false;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e, stackTrace) {
      print("Exceptions=====> $e");
      print("🔍 Stack Trace: $stackTrace");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> getMyLeads() async {
    _isLoading = true;
    // notifyListeners();
    var connection = await checkConnection();
    if (!connection) {
      return false;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');
    if (token == null) {
      print("❌ Token not found. User not authenticated.");
      _isLoading = false;
      return false;
    }
    try {
      String url = "$baseApi/seller/leads/list";
      var headers = {
        // "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
      var response = await http.get(Uri.parse(url), headers: headers);
      print("🔗 Request URL: $url");
      print("📩 Request Headers: $headers");
      print("📡 Response Status Code: ${response.statusCode}");
      print("📜 Response Body: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        _myLeadsDataModel =
            MyLeadsDataModel.fromJson(jsonDecode(response.body));
        print(
            "📜 service list data : ${_myServiceListDataModel.myServices?.length}");
        _isLoading = false;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e, stackTrace) {
      print("Exceptions=====> $e");
      print("🔍 Stack Trace: $stackTrace");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  List<Map<String, dynamic>> _subscriptionList = [];
  List<Map<String, dynamic>> get subscriptionList => _subscriptionList;

  List<Map<String, dynamic>> _bannerInfo = [];
  List<Map<String, dynamic>> get bannerInfo => _bannerInfo;

  Future<bool> getSubscriptions({String type = ''}) async {
    _isLoading = true;
    var connection = await checkConnection();
    if (!connection) {
      _isLoading = false;
      notifyListeners();
      return false;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');
    if (token == null) {
      print("❌ Token not found. User not authenticated.");
      _isLoading = false;
      notifyListeners();
      return false;
    }

    try {
      String url = "$baseApi/seller/service/subcription-list?type=$type";
      var headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      var response = await http.get(Uri.parse(url), headers: headers);

      // print("🔗 Request URL: $url");
      // print("📩 Request Headers: $headers");
      // print("📡 Response Status Code: ${response.statusCode}");
      // printLargeResponse("📜 Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = jsonDecode(response.body);

        if (responseData.containsKey('subscription_info') &&
            responseData['subscription_info'] is List) {
          _subscriptionList.clear(); // Clear old data

          // Parse each subscription entry
          for (var item in responseData['subscription_info']) {
            _subscriptionList.add({
              "id": item["id"],
              "title": item["title"],
              "type": item["type"],
              "price": item["price"],
              "connect": item["connect"],
              "service": item["service"],
              "job": item["job"],
              "status": item["status"],
              "image": item["image"],
              "desc": item["desc"] ?? "",
              "typeText": item["typeText"] ?? "",
              "created_at": item["created_at"],
              "updated_at": item["updated_at"],
              "seller": (item["seller"] != null &&
                      item["seller"] is List &&
                      item["seller"].isNotEmpty)
                  ? item["seller"]
                  : [], // If seller is empty, assign null
            });
          }

          // // Ensure _bannerInfo is cleared before adding new data
          // _bannerInfo.clear();
          // if (responseData["banner_info"] != null &&
          //     responseData["banner_info"] is List &&
          //     responseData["banner_info"].isNotEmpty) {
          //   _bannerInfo
          //       .addAll(responseData["banner_info"]); // Store the entire list
          //
          //   debugPrint("✅ Banner Info Updated: $_bannerInfo");
          // } else {
          //   debugPrint("🚨 No Banner Info Found");
          // }

          // print("📜 Parsed Subscription List: ${_subscriptionList}");
          notifyListeners();
          return true;
        } else {
          // print("⚠️ 'subscription_info' key is missing or not a list.");
        }
      } else {
        // print("❌ API Error: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      // print("❌ Exception: $e");
      // print("🔍 Stack Trace: $stackTrace");
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    return false;
  }

  Future<bool> buySubscriptions(var data) async {
    _isLoading = true;
    notifyListeners();
    var connection = await checkConnection();
    if (!connection) {
      _isLoading = false;
      notifyListeners();
      return false;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');
    if (token == null) {
      print("❌ Token not found. User not authenticated.");
      return false;
    }

    try {
      String url = "$baseApi/seller/buy-subscription";
      var headers = {
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
      };

      var response = await http.post(Uri.parse(url),
          body: jsonEncode(data), headers: headers);

      print("🔗 Request URL: $url");
      print("📩 Request Headers: $headers");
      print("📩 Request Body: ${jsonEncode(data)}");
      print("📡 Response Status Code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("📡 Response Status Code: ${response.statusCode}");
        print("📜 Response Body: ${response.body}");
        return true;
      } else {
        return false;
      }
    } catch (e, stackTrace) {
      print("🔍 Stack Trace: $stackTrace");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> checkSubscribe({int index = 0}) async {
    try {
      var connection = await checkConnection();
      if (!connection) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      getSubscriptions();
      final pref = await SharedPreferences.getInstance();
      String userId = pref.getString('shashaktnirmanUserId') ?? '';

      if (userId.isEmpty) {
        print("❌ User ID not found in SharedPreferences.");
        return false;
      }

      List<dynamic> sellerList = _subscriptionList[index]["seller"] ?? [];

      bool isSubscribed =
          sellerList.any((seller) => seller["seller_id"].toString() == userId);
      print("isSubscribed ====> $isSubscribed");
      return isSubscribed;
    } catch (e, stackTrace) {
      print("❌ Exception in checkSubscribe: $e");
      return false;
    }
  }

  bool _isLoading3 = false;
  bool get isLoading3 => _isLoading3;

  Future<bool> uploadBanner(String? subscriptionId, BuildContext context,
      {String? imagePath}) async {
    _isLoading3 = true;
    notifyListeners();
    var connection = await checkConnection();
    if (!connection) {
      return false;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');
    if (token == null) {
      print("❌ Token not found. User not authenticated.");
      return false;
    }

    String url = '$baseApi/seller/advertisement/upload-poster';
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll({
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });
      request.fields.addAll({
        "subscription_id": subscriptionId.toString(),
      });
      if (imagePath != null && imagePath.isNotEmpty) {
        File file = File(imagePath);
        if (await file.exists()) {
          request.files.add(
            await http.MultipartFile.fromPath('file', file.path),
          );
        } else {
          print("⚠️ Image file not found at path: $imagePath");
        }
      }
      print("➡️ Request URL: $url");
      print("➡️ Request Headers: ${request.headers}");
      print("➡️ Request Fields: ${request.fields}");
      print(
          "➡️ Request Files: ${request.files.map((f) => f.filename).toList()}");
      print("➡️ Request File: ${request.files.map((f) => f.field).toList()}");

      http.StreamedResponse response =
          await request.send().timeout(const Duration(seconds: 10));
      String responseBody = await response.stream.bytesToString();
      print("➡️ Response Status Code: ${response.statusCode}");
      print("➡️ Response Body: $responseBody");

      if (response.statusCode == 200 || response.statusCode == 201) {
        OthersHelper().showToast(
            "Banner upload successfully", ConstantColors().successColor);
        Provider.of<GetImageController>(context, listen: false)
            .removeBannerImages();
        _isLoading3 = false;
        return true;
      } else {
        var decodedResponse = jsonDecode(responseBody);
        if (decodedResponse.containsKey('errors')) {
        } else {
          OthersHelper().showToast(decodedResponse['message'], Colors.black);
        }
        return false;
      }
    } on SocketException {
      _isLoading3 = false;
      print("❌ No internet connection.");
      return false;
    } catch (e) {
      _isLoading3 = false;
      print('❌ Exception: $e');
      return false;
    } finally {
      _isLoading3 = false;
      notifyListeners();
    }
  }

  //
  sendNotification(BuildContext context, {required sellerId, required msg}) {
    //Send notification to seller
    var username = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .name ??
        '';
  }
}
