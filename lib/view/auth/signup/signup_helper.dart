import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qixer/helper/extension/context_extension.dart';

import 'package:qixer/view/auth/login/login.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/responsive.dart';

class SignupHelper {
  ConstantColors cc = ConstantColors();
  haveAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            text: lnProvider.getString('Have an account?') + '  ',
            style: const TextStyle(color: Color(0xff646464), fontSize: 14),
            children: <TextSpan>[
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                  text: lnProvider.getString('Sign in'),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: cc.primaryColor,
                  )),
            ],
          ),
        ),
      ],
    );
  }

  //
  phoneFieldDecoration() {
    return InputDecoration(
        // labelText: lnProvider.getString('Phone Number'),
        // hintTextDirection: TextDirection.rtl,
        labelStyle: TextStyle(color: cc.greyFour, fontSize: 14),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ConstantColors().greyFive),
            borderRadius: BorderRadius.circular(9)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ConstantColors().primaryColor)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ConstantColors().warningColor)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ConstantColors().primaryColor)),
        hintText: lnProvider.getString('Enter phone number'),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 18));
  }
}
