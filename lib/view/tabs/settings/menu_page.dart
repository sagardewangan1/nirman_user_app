import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/permissions_service.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/view/jobs/job_request_page.dart';
import 'package:qixer/view/jobs/my_jobs_page.dart';
import 'package:qixer/view/report/my_reports_list_page.dart';
import 'package:qixer/view/tabs/settings/components/chat_icon.dart';
import 'package:qixer/view/tabs/settings/components/menu_name_image_section.dart';
import 'package:qixer/view/tabs/settings/components/menu_personal_info_section.dart';
import 'package:qixer/view/tabs/settings/password/change_password_page.dart';
import 'package:qixer/view/tabs/settings/profile_edit.dart';
import 'package:qixer/view/tabs/settings/settings_helper.dart';
import 'package:qixer/view/tabs/settings/supports/my_tickets_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/wallet/wallet_page.dart';

import '../../auth/delete_account_page.dart';
import '../../utils/login_or_register.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    return Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<ProfileService>(builder: (context, ps, child) {
          return ps.profileDetails == null || ps.profileDetails is String
              ? const LoginOrRegister()
              : SafeArea(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        physics: physicsCommon,
                        child: Consumer<PermissionsService>(
                          builder: (context, pProvider, child) =>
                              Consumer<AppStringService>(
                            builder: (context, asProvider, child) =>
                                Consumer<ProfileService>(
                              builder: (context, profileProvider, child) =>
                                  profileProvider.profileDetails != null
                                      ? profileProvider.profileDetails !=
                                              'error'
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                //
                                                const MenuNameImageSection(),

                                                // Personal information ==========>
                                                const MenuPersonalInfoSection(),

                                                SettingsHelper()
                                                    .borderBold(35, 8),

                                                //Other settings options ========>
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: Column(children: [
                                                    SettingsHelper().settingOption(
                                                        'assets/svg/menu_job.svg',
                                                        asProvider.getString(
                                                            "My jobs"), () {
                                                      if (!pProvider
                                                          .jobPermission) {
                                                        OthersHelper().showToast(
                                                            'You don\'t have permission to access this feature',
                                                            Colors.black);
                                                        return;
                                                      }

                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute<void>(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              const MyJobsPage(),
                                                        ),
                                                      );
                                                    }),
                                                    //============>
                                                    CommonHelper()
                                                        .dividerCommon(),
                                                    SettingsHelper().settingOption(
                                                        'assets/svg/menu_job_list.svg',
                                                        asProvider.getString(
                                                            "Job requests"),
                                                        () {
                                                      if (!pProvider
                                                          .jobPermission) {
                                                        OthersHelper().showToast(
                                                            'You don\'t have permission to access this feature',
                                                            Colors.black);
                                                        return;
                                                      }
                                                      //=====>
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute<void>(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              const JobRequestPage(),
                                                        ),
                                                      );
                                                    }),

                                                    //===========>
                                                    CommonHelper()
                                                        .dividerCommon(),
                                                    SettingsHelper().settingOption(
                                                        'assets/svg/menu_ticket.svg',
                                                        asProvider.getString(
                                                            "Support Ticket"),
                                                        () {
                                                      //=====>
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute<void>(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              const MyTicketsPage(),
                                                        ),
                                                      );
                                                    }),

                                                    CommonHelper()
                                                        .dividerCommon(),
                                                    SettingsHelper().settingOption(
                                                        'assets/svg/menu_wallet.svg',
                                                        asProvider.getString(
                                                            "Wallet"), () {
                                                      if (!pProvider
                                                          .walletPermission) {
                                                        OthersHelper().showToast(
                                                            'You don\'t have permission to access this feature',
                                                            Colors.black);
                                                        return;
                                                      }
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute<void>(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              const WalletPage(),
                                                        ),
                                                      );
                                                    }),

                                                    CommonHelper()
                                                        .dividerCommon(),
                                                    SettingsHelper().settingOption(
                                                        'assets/svg/menu_report.svg',
                                                        asProvider.getString(
                                                            "My report list"),
                                                        () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute<void>(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              const MyReportListPage(),
                                                        ),
                                                      );
                                                    }),

                                                    CommonHelper()
                                                        .dividerCommon(),
                                                    SettingsHelper().settingOption(
                                                        'assets/svg/profile-edit.svg',
                                                        asProvider.getString(
                                                            "Edit Profile"),
                                                        () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute<void>(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              const ProfileEditPage(),
                                                        ),
                                                      );
                                                    }),
                                                    CommonHelper()
                                                        .dividerCommon(),
                                                    SettingsHelper().settingOption(
                                                        'assets/svg/lock-circle.svg',
                                                        asProvider.getString(
                                                            "Change Password"),
                                                        () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute<void>(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              const ChangePasswordPage(),
                                                        ),
                                                      );
                                                    }),
                                                  ]),
                                                ),

                                                // logout
                                                SettingsHelper()
                                                    .borderBold(12, 5),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: Column(children: [
                                                    SettingsHelper().settingOption(
                                                        'assets/svg/menu_delete_account.svg',
                                                        asProvider.getString(
                                                            "Delete Account"),
                                                        () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute<void>(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              DeleteAccountPage(),
                                                        ),
                                                      );
                                                    }),
                                                  ]),
                                                ),
                                                CommonHelper().dividerCommon(),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: Column(children: [
                                                    SettingsHelper().settingOption(
                                                        'assets/svg/logout-circle.svg',
                                                        asProvider.getString(
                                                            "Logout"), () {
                                                      SettingsHelper()
                                                          .logoutPopup(context);
                                                    }),
                                                    sizedBox20()
                                                  ]),
                                                )
                                              ],
                                            )
                                          : OthersHelper().showError(context)
                                      : Container(
                                          alignment: Alignment.center,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              150,
                                          child: OthersHelper()
                                              .showLoading(cc.primaryColor),
                                        ),
                            ),
                          ),
                        ),
                      ),

                      //chat icon ========>
                      const ChatIcon(),
                    ],
                  ),
                );
        }));
  }
}
