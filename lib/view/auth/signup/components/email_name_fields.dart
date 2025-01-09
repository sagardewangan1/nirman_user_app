import 'package:flutter/cupertino.dart';
import 'package:qixer/view/utils/custom_input.dart';
import 'package:qixer/view/utils/responsive.dart';

import '../../../utils/common_helper.dart';

class EmailNameFields extends StatelessWidget {
  const EmailNameFields(
      {super.key,
      this.fullNameController,
      this.userNameController,
      this.emailController});

  final fullNameController;
  final userNameController;
  final emailController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Name ============>
        CommonHelper().labelCommon("Full name"),

        CustomInput(
          controller: fullNameController,
          validation: (value) {
            if (value == null || value.isEmpty) {
              return lnProvider.getString('Please enter your full name');
            }
            return null;
          },
          hintText: lnProvider.getString("Enter your full name"),
          icon: 'assets/icons/user.png',
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(
          height: 18,
        ),

        //User name ============>
        CommonHelper().labelCommon("Username"),

        CustomInput(
          controller: userNameController,
          validation: (value) {
            if (value == null || value.isEmpty) {
              return lnProvider.getString('Please enter your username');
            }
            return null;
          },
          hintText: lnProvider.getString("Enter your username"),
          icon: 'assets/icons/user.png',
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(
          height: 18,
        ),

        //Email ============>
        CommonHelper().labelCommon(lnProvider.getString("Email")),

        CustomInput(
          controller: emailController,
          validation: (value) {
            if (value == null || value.isEmpty) {
              return lnProvider.getString('Please enter your email');
            }
            return null;
          },
          hintText: lnProvider.getString("Enter your email"),
          icon: 'assets/icons/email-grey.png',
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }
}
