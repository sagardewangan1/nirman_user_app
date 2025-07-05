import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/helper/SharedPreferencesHelper.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/view/selectionRole/selectionRoleView.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogoutService with ChangeNotifier {
  bool isloading = false;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  logout(BuildContext context) async {
    var connection = await checkConnection();
    if (connection) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('shashaktnirmantoken');

      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        // "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      setLoadingTrue();
      var response = await http.post(
        Uri.parse('$baseApi/user/logout'),
        headers: header,
      );
      if (response.statusCode == 201) {
        notifyListeners();
        SharedPreferencesHelper.clearData();

        try {} catch (e) {}

        // clear profile data =====>
        Provider.of<ProfileService>(context, listen: false)
            .setEverythingToDefault();
        clear();
        setLoadingFalse();
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => const SelectionRoleView(
              hasBackButton: false,
            ),
          ),
          (route) => false,
        );
      } else {
        debugPrint(response.body.toString());
        OthersHelper().showToast(
            AppLocalizations.of(context)!.somethingWentWrong, Colors.black);
        setLoadingFalse();
      }
    }
  }

  //clear saved email, pass and token
  clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
