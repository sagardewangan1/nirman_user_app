import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/responsive.dart';

import '../../service/app_string_service.dart';

String siteLink = "https://sashaktnirmaan.com"; // Production
// String siteLink = "http://192.168.1.13/focus/qixer-v2.7.0"; // Developement

String get baseApi => '$siteLink/api/v1';
String rupeeSymbol = '\u20B9';

String placeHolderUrl = 'https://i.postimg.cc/mZNNdXd2/icon.png';
// String placeHolderUrl =
//     'https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-website-design-mobile-app-no-photo-available_87543-11093.jpg';
String appLogoIcon = 'https://i.postimg.cc/mZNNdXd2/icon.png';
String appIconUrl = 'https://i.postimg.cc/mZNNdXd2/icon.png';
String placeHolderUrl2 =
    'https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-website-design-mobile-app-no-photo-available_87543-11093.jpg';
String loadMoreGif = 'https://i.postimg.cc/FsTXxr5r/target-4755-128.gif';
String userPlaceHolderUrl =
    'https://i.postimg.cc/ZYQp5Xv1/blank-profile-picture-gb26b7fbdf-1280.png';
String appVersion = 'v1.0';
String mapApiKey = '';

//only needed for apple sign-in setup
String clientSecret = '';

class OthersHelper with ChangeNotifier {
  Future<void> showCompactSuccessDialog2(BuildContext buildContext,
      {String image = "assets/icons/like.gif",
      String messageType = 'Success!',
      String messageTitle = 'Message Title!',
      String message = 'Message!',
      VoidCallback? onTap}) {
    return showDialog(
      context: buildContext,
      builder: (context) {
        return Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
            child: AlertDialog(
              backgroundColor: cc.white,
              insetPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    image,
                    // messageType == "Error"
                    //     ? "assets/icons/error.gif"
                    //     : "assets/icons/like.gif",
                    height: 65,
                    width: 65,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    messageTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: onTap,
                    child: Container(
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: messageType == "Error"
                              ? Colors.red
                              : Colors.green,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          textAlign: TextAlign.center,
                          "OK",
                          style: TextStyle(color: cc.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

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

enum EnquiryType {
  support,
  product,
  feedback,
  general,
  urgent,
  high,
  medium,
  low
}

extension EnquiryTypeExtension on EnquiryType {
  String get name {
    switch (this) {
      case EnquiryType.support:
        return "Support";
      case EnquiryType.product:
        return "Product Inquiry";
      case EnquiryType.feedback:
        return "Feedback";
      case EnquiryType.general:
        return "General Query";
      case EnquiryType.urgent:
        return "Urgent";
      case EnquiryType.high:
        return "High Priority";
      case EnquiryType.medium:
        return "Medium Priority";
      case EnquiryType.low:
        return "Low Priority";
      default:
        return "";
    }
  }
}

printLargeResponse(String responseBody) {
  const int chunkSize = 1000; // Ek bar me sirf 1000 characters print honge
  for (int i = 0; i < responseBody.length; i += chunkSize) {
    print(responseBody.substring(
        i,
        i + chunkSize > responseBody.length
            ? responseBody.length
            : i + chunkSize));
  }
}
