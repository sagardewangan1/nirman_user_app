import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/SharedPreferencesHelper.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/service/addServiceProvider/addServicerProvider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/auth_services/delete_account_service.dart';
import 'package:qixer/service/auth_services/logout_service.dart';
import 'package:qixer/view/intro/splash.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/custom_input.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../service/auth_services/facebook_login_service.dart';
import '../../../service/auth_services/google_sign_service.dart';
import '../../home/homepage_helper.dart';

class SettingsHelper {
  ConstantColors cc = ConstantColors();
  borderBold(double marginTop, double marginBottom) {
    return Container(
      margin: EdgeInsets.only(top: marginTop, bottom: marginBottom),
      child: Divider(
        height: 0,
        thickness: 3,
        color: cc.borderColor,
      ),
    );
  }

  List<SettingsGridCard> cardContent = [
    SettingsGridCard('assets/svg/pending-circle.svg', 'Pending orders'),
    SettingsGridCard('assets/svg/active-circle.svg', 'Active orders'),
    SettingsGridCard('assets/svg/completed-circle.svg', 'Completed orders'),
    SettingsGridCard('assets/svg/receipt-circle.svg', 'Total orders'),
  ];

  settingOption(String icon, String title, VoidCallback pressed) {
    return ListTile(
      onTap: pressed,
      leading: SvgPicture.asset(
        icon,
        height: 35,
      ),
      title: Text(
        title,
        style: TextStyle(color: cc.greyFour, fontSize: 14),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 17,
      ),
    );
  }

  logoutPopup(BuildContext context) {
    return Alert(
        context: context,
        style: AlertStyle(
            alertElevation: 0,
            overlayColor: Colors.black.withOpacity(.6),
            alertPadding: const EdgeInsets.all(25),
            isButtonVisible: false,
            alertBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            titleStyle: const TextStyle(),
            animationType: AnimationType.grow,
            animationDuration: const Duration(milliseconds: 500)),
        content: Container(
          margin: const EdgeInsets.only(top: 22),
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.01),
                  spreadRadius: -2,
                  blurRadius: 13,
                  offset: const Offset(0, 13)),
            ],
          ),
          child: Consumer<AppStringService>(
            builder: (context, asProvider, child) => Column(
              children: [
                Text(
                  '${asProvider.getString('Are you sure?')}',
                  style: TextStyle(color: cc.greyPrimary, fontSize: 17),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Expanded(
                        child: CommonHelper().borderButtonOrange(
                            asProvider.getString('Cancel'), () {
                      Navigator.pop(context);
                    })),
                    const SizedBox(
                      width: 16,
                    ),
                    Consumer<LogoutService>(
                      builder: (context, provider, child) => Expanded(
                          child: CommonHelper().buttonOrange(
                              asProvider.getString('Logout'), () {
                        if (provider.isloading == false) {
                          provider.logout(context);
                          SharedPreferencesHelper.clearData();
                          //if logged in by google then logout from it
                          GoogleSignInService().logOutFromGoogleLogin();
                          //if logged in by facebook then logout from it
                          FacebookLoginService().logoutFromFacebook();
                          HomepageHelper.tabIndex.value =
                              0; // ✅ Ensure it starts from Home
                        }
                      },
                              isloading:
                                  provider.isloading == false ? false : true)),
                    ),
                  ],
                )
              ],
            ),
          ),
        )).show();
  }

  Future<bool> deleteServicePopup(BuildContext context, String? serviceId) {
    Completer<bool> completer = Completer<bool>();

    Alert(
      context: context,
      style: AlertStyle(
        alertElevation: 0,
        overlayColor: Colors.black.withOpacity(.6),
        alertPadding: const EdgeInsets.all(25),
        isButtonVisible: false,
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        titleStyle: const TextStyle(),
        animationType: AnimationType.grow,
        animationDuration: const Duration(milliseconds: 500),
      ),
      content: Container(
        margin: const EdgeInsets.only(top: 22),
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.01),
              spreadRadius: -2,
              blurRadius: 13,
              offset: const Offset(0, 13),
            ),
          ],
        ),
        child: Consumer<AppStringService>(
          builder: (context, asProvider, child) => Column(
            children: [
              Icon(
                Icons.warning_amber,
                color: cc.warningColor,
                size: 34,
              ),
              Text(
                '${asProvider.getString('Are you sure? Do you want to permanently delete your service?')}',
                style: TextStyle(color: cc.greyPrimary, fontSize: 17),
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: CommonHelper().borderButtonOrange("Cancel", () {
                      Navigator.pop(context);
                      completer.complete(false); // Return false on cancel
                    }),
                  ),
                  const SizedBox(width: 16),
                  Consumer<AddServiceController>(
                    builder: (context, provider, child) => Expanded(
                      child: CommonHelper().buttonOrange(
                        "Delete",
                        () {
                          if (!provider.isLoading2) {
                            provider.deleteService(serviceId: serviceId).then(
                              (value) {
                                Navigator.pop(context);
                                completer
                                    .complete(value); // Return true if deleted
                              },
                            );
                          }
                        },
                        isloading: provider.isLoading2,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ).show();

    return completer.future;
  }

  deleteAccountPopup(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    return Alert(
        context: context,
        style: AlertStyle(
            alertElevation: 0,
            overlayColor: Colors.black.withOpacity(.6),
            alertPadding: const EdgeInsets.all(25),
            isButtonVisible: false,
            alertBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            titleStyle: const TextStyle(),
            animationType: AnimationType.grow,
            animationDuration: const Duration(milliseconds: 500)),
        content: Container(
          margin: const EdgeInsets.only(top: 22),
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.01),
                  spreadRadius: -2,
                  blurRadius: 13,
                  offset: const Offset(0, 13)),
            ],
          ),
          child: Consumer<AppStringService>(
            builder: (context, asProvider, child) => Column(
              children: [
                Text(
                  '${asProvider.getString('Are you sure?')}',
                  style: TextStyle(color: cc.greyPrimary, fontSize: 17),
                ),
                const SizedBox(height: 25),
                CustomInput(
                    controller: passwordController,
                    hintText: asProvider.getString("Enter password")),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                        child: CommonHelper().borderButtonOrange(
                            asProvider.getString('Cancel'), () {
                      Navigator.pop(context);
                    })),
                    const SizedBox(
                      width: 16,
                    ),
                    Consumer<DeleteAccountService>(
                      builder: (context, provider, child) => Expanded(
                          child: CommonHelper().buttonOrange(
                              asProvider.getString('Delete'), () {
                        if (provider.isloading == false) {
                          // provider.deleteAccount(
                          //     context, _passwordController.text);
                          //if logged in by google then logout from it
                          GoogleSignInService().logOutFromGoogleLogin();

                          //if logged in by facebook then logout from it
                          FacebookLoginService().logoutFromFacebook();
                        }
                      },
                              isloading:
                                  provider.isloading == false ? false : true,
                              bgColor: cc.warningColor)),
                    ),
                  ],
                )
              ],
            ),
          ),
        )).show();
  }
}

class SettingsGridCard {
  String iconLink;
  String text;

  SettingsGridCard(this.iconLink, this.text);
}
