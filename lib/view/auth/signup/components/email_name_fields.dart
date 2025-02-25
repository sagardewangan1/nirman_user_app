import 'package:flutter/cupertino.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/auth_services/signup_service.dart';
import 'package:qixer/service/rtl_service.dart';
import 'package:qixer/view/auth/signup/signup_helper.dart';
import 'package:qixer/view/utils/custom_input.dart';
import 'package:qixer/view/utils/responsive.dart';

import '../../../utils/common_helper.dart';

class EmailNameFields extends StatelessWidget {
  const EmailNameFields({
    super.key,
    this.fullNameController,
    this.userNameController,
    this.mobileController,
    this.emailController,
    this.type,
  });

  final fullNameController;
  final userNameController;
  final mobileController;
  final emailController;
  final String? type;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStringService>(
      builder: (context, asProvider, child) {
        return Consumer<SignupService>(
          builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonHelper().titleCommon("Fill Your General Details"),
                const SizedBox(
                  height: 18,
                ),
                //Name ============>
                CommonHelper().labelCommon("Full name"),

                CustomInput(
                  controller: fullNameController,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return lnProvider
                          .getString('Please enter your full name');
                    }
                    return null;
                  },
                  hintText: lnProvider.getString("Enter your full name"),
                  icon: 'assets/icons/user.png',
                  textInputAction: TextInputAction.next,
                ),
                // SizedBox(
                //   height: type != "Vendor" ? 18 : 0,
                // ),

                //User name ============>
                // type != "Vendor"
                //     ? CommonHelper().labelCommon("Username")
                //     : Offstage(),
                //
                // type != "Vendor"
                //     ? CustomInput(
                //         controller: userNameController,
                //         validation: (value) {
                //           if (value == null || value.isEmpty) {
                //             return lnProvider
                //                 .getString('Please enter your username');
                //           }
                //           return null;
                //         },
                //         hintText: lnProvider.getString("Enter your username"),
                //         icon: 'assets/icons/user.png',
                //         textInputAction: TextInputAction.next,
                //       )
                //     : Offstage(),
                const SizedBox(
                  height: 18,
                ),

                //Email ============>
                CommonHelper().labelCommon(lnProvider.getString("Email")),

                CustomInput(
                  controller: emailController,
                  hintText: lnProvider.getString("Enter your email"),
                  icon: 'assets/icons/email-grey.png',
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(
                  height: 18,
                ),

                //Phonehh  ============>
                type == "Vendor"
                    ? CommonHelper().labelCommon(lnProvider.getString("Phone"))
                    : Offstage(),

                type == "Vendor"
                    ? Consumer<RtlService>(
                        builder: (context, rtlP, child) => IntlPhoneField(
                          controller: mobileController,
                          decoration: SignupHelper().phoneFieldDecoration(),
                          searchText: asProvider.getString("Search country"),
                          initialCountryCode: provider.countryCode,
                          disableLengthCheck: true,
                          textAlign: rtlP.direction == 'ltr'
                              ? TextAlign.left
                              : TextAlign.right,
                          onChanged: (phone) {
                            provider.setCountryCode(phone.countryISOCode);

                            provider.setPhone(phone.completeNumber);
                          },
                        ),
                      )
                    : Offstage(),

                const SizedBox(
                  height: 18,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
