import 'package:flutter/material.dart';
import 'package:qixer/helper/extension/context_extension.dart';

import '../auth/login/login.dart';
import '../utils/custom_button.dart';
import 'common_helper.dart';

class LoginOrRegister extends StatelessWidget {
  const LoginOrRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height - 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/avatar.png',
              height: context.height / 6,
              // width: 48,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CommonHelper().titleCommon(
                  "You'll have to login/register to edit or see your profile info.",
                  fontsize: 16,
                  textAlign: TextAlign.center)),
          const SizedBox(height: 20),
          CustomButton(
              btText: 'Sign-In/Sign-Up',
              onPressed: () {
                context.toPage(const LoginPage(hasBackButton: true));
              },
              isLoading: false,
              width: context.width / 2)
        ],
      ),
    );
  }
}
