import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/responsive.dart';

import '../../service/app_string_service.dart';

String siteLink = "https://color.sagardev.in";

String get baseApi => '$siteLink/api/v1';

String placeHolderUrl = 'https://i.postimg.cc/rpsKNndW/New-Project.png';
String userPlaceHolderUrl =
    'https://i.postimg.cc/ZYQp5Xv1/blank-profile-picture-gb26b7fbdf-1280.png';
String appVersion = 'v1.0';
String mapApiKey = '';

//only needed for apple sign-in setup
String clientSecret = '';

class OthersHelper with ChangeNotifier {
  ConstantColors cc = ConstantColors();
  int deliveryCharge = 60;

  showLoading(Color color) {
    return SpinKitThreeBounce(
      color: color,
      size: 16.0,
    );
  }

  showError(BuildContext context, {String msg = "Something went wrong"}) {
    return Container(
        height: MediaQuery.of(context).size.height - 180,
        alignment: Alignment.center,
        child: Text(lnProvider.getString(msg)));
  }

  void showToast(String msg, Color? color) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: lnProvider.getString(msg),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  // snackbar
  showSnackBar(BuildContext context, String msg, color) {
    var snackBar = SnackBar(
      content: Text(lnProvider.getString(msg)),
      backgroundColor: color,
      duration: const Duration(milliseconds: 2000),
    );

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void toastShort(String msg, Color color) {
    Fluttertoast.showToast(
        msg: lnProvider.getString(msg),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  commonRefreshFooter(BuildContext context) {
    final asProvider = Provider.of<AppStringService>(context, listen: false);
    return CustomFooter(
      builder: (context, mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = const Text("");
        } else if (mode == LoadStatus.loading) {
          body = OthersHelper().showLoading(cc.greyFour);
        } else if (mode == LoadStatus.failed) {
          body = Text(asProvider.getString("Load Failed"),
              style: TextStyle(color: cc.greyFour));
        } else if (mode == LoadStatus.canLoading) {
          body = Text(asProvider.getString("Release to load more"),
              style: TextStyle(color: cc.greyFour));
        } else {
          body = Text(asProvider.getString("No more Data"),
              style: TextStyle(color: cc.greyFour));
        }
        return SizedBox(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }
}

extension PriceConverter on String {
  num get tryToParse {
    RegExp numberPattern = RegExp(r'\d+(\.\d+)?');

    // Replace all matches with an empty string
    String originalCurrency = replaceAll(",", "").replaceAll(numberPattern, '');
    return num.tryParse(replaceAll(originalCurrency, "")
            .replaceAll(",", "")
            .replaceAll(rtlProvider.currency, "")) ??
        0;
  }
}
