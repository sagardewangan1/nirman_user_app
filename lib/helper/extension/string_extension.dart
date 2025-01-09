import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../view/utils/constant_colors.dart';
import '../../view/utils/responsive.dart';

extension SvgPathExtension on String {
  Widget get toSVG => SvgPicture.asset('assets/svg/$this.svg');
}

extension SvgSizedExtension on String {
  Widget toSVGSized(double height, {color}) => SvgPicture.asset(
        'assets/svg/$this.svg',
        height: height,
        color: color,
      );
}

extension ImageAssetExtension on String {
  Widget toAImage({color, fit}) => Image.asset(
        'assets/images/$this.png',
        fit: fit,
      );
}

extension AssetImageExtension on String {
  ImageProvider get toAsset => AssetImage(
        'assets/images/$this.png',
      );
}

extension StringExtension on String {
  String get capitalize {
    if (isEmpty) return "";
    final laterPart = substring(1);
    return "${this[0].toUpperCase()}${laterPart.toLowerCase()}";
  }
}

extension CurrencyDynamicExtension on String {
  String get cur {
    if (isEmpty) return "";
    String symbol = rtlProvider.currency;
    return rtlProvider.currencyDirection != "left"
        ? "$this$symbol"
        : "$symbol$this";
  }
}

extension TranslateExtension on String {
  // String translate(BuildContext context) {
  //   return context.asProvider.getString(this);
  // }

  String tr() {
    return lnProvider.getString(this);
  }
}

extension EmailValidateExtension on String {
  bool get validateEmail {
    final emailReg = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailReg.hasMatch(this);
  }
}

extension ShowToastExtension on String {
  showToast({bc, tc}) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: lnProvider.getString(this),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: bc ?? cc.black3,
        textColor: tc ?? cc.white,
        fontSize: 16.0);
  }
}

extension CapitalizeWordsExtension on String {
  String get capitalizeWords {
    if (isEmpty) {
      return '';
    }

    List<String> words = split(' ');
    List<String> capitalizedWords = [];

    for (String word in words) {
      if (word.isNotEmpty) {
        String capitalized = word[0].toUpperCase() + word.substring(1);
        capitalizedWords.add(capitalized);
      }
    }

    return capitalizedWords.join(' ');
  }
}

extension PasswordValidatorExtension on String {
  String? get validPass {
    String? value;
    if (length < 8) {
      value = 'Password should be at least 8 characters long'.tr();
    } else if (!RegExp(r'[A-Z]').hasMatch(this)) {
      value = 'Password should contain at least 1 uppercase letter'.tr();
    } else if (!RegExp(r'[a-z]').hasMatch(this)) {
      value = 'Password should contain at least 1 lowercase letter'.tr();
    } else if (!RegExp(r'\d').hasMatch(this)) {
      value = 'Password should contain at least 1 digit'.tr();
    } else if (!RegExp(r'[@$!%*?&]').hasMatch(this)) {
      value = 'Password should contain at least 1 special character'.tr();
    }
    debugPrint(value.toString());
    return value;
  }
}

extension PriceConverter on String {
  num get tryToParse {
    RegExp numberPattern = RegExp(r'^-?\d+(\.\d+)?');

    // Replace all matches with an empty string
    return num.tryParse(
            replaceAll(",", "").replaceAll(rtlProvider.currency, "")) ??
        0;
  }
}
