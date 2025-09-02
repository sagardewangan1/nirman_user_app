import 'package:flutter/material.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/view/selectionRole/selectionRoleView.dart';

import '../utils/custom_button.dart';
import 'common_helper.dart';
import 'package:qixer/generated/app_localizations.dart';

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
              'assets/images/logoutpage.png',
              height: context.height / 4,
              // width: 48,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 50),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CommonHelper().titleCommon(
                  AppLocalizations.of(context)!.logoutScreenText,
                  fontsize: 16,
                  textAlign: TextAlign.center)),
          const SizedBox(height: 50),
          CustomButton(
              btText: AppLocalizations.of(context)!.continueText,
              onPressed: () {
                context.toPage(const SelectionRoleView(
                  hasBackButton: true,
                ));
              },
              isLoading: false,
              width: context.width / 2)
        ],
      ),
    );
  }
}
