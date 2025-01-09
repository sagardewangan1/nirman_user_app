import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:qixer/service/common_service.dart';
import 'package:qixer/view/utils/others_helper.dart';

class PermissionsService with ChangeNotifier {
  bool jobPermission = true;
  bool subsPermission = true;
  bool chatPermission = true;
  bool walletPermission = true;

  fetchUserPermissions(BuildContext context) async {
    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    var connection = await checkConnection();
    if (!connection) return;

    var response = await http.get(Uri.parse('$baseApi/module-permission'),
        headers: header);

    final decodedData = jsonDecode(response.body);

    if (response.statusCode == 201) {
      jobPermission = decodedData['permissions']['JobPost'];
      subsPermission = decodedData['permissions']['Subscription'];
      chatPermission = decodedData['permissions']['LiveChat'];
      walletPermission = decodedData['permissions']['Wallet'];
      notifyListeners();
    }
  }
}
