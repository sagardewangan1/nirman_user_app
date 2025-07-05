import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/contactFeatures.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/model/navigationModel.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/permissions_service.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/view/auth/signup/pages/tac_pp.dart';
import 'package:qixer/view/tabs/settings/Support/supportView.dart';
import 'package:qixer/view/tabs/settings/Support/supportViewModel.dart';
import 'package:qixer/view/tabs/settings/businessProfileEdit.dart';
import 'package:qixer/view/tabs/settings/components/menu_name_image_section.dart';
import 'package:qixer/view/tabs/settings/components/menu_personal_info_section.dart';
import 'package:qixer/view/tabs/settings/profile_edit.dart';
import 'package:qixer/view/tabs/settings/settings_helper.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../auth/delete_account_page.dart';
import '../../home/homepage_helper.dart';
import '../../utils/login_or_register.dart';
import 'appSettings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String? userType;
  bool isLoggedIn = false;

  @override
  void initState() {
    firstLoad();
    super.initState();
  }

  firstLoad() async {
    final profileController =
        Provider.of<ProfileService>(context, listen: false);
    await profileController.getProfileDetails(context: context);
    await profileController.getLoggedIn();
    final pref = await SharedPreferences.getInstance();
    userType = pref.getString("shashaktnirmanusertype");
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    return Scaffold(
        body: Consumer<ProfileService>(builder: (context, ps, child) {
      return ps.isloading
          ? OthersHelper().showLoading(cc.primaryColor)
          : ps.isLoggedIn == false
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
                                                MenuNameImageSection(
                                                  userType: userType.toString(),
                                                  navfrom: "menu tab",
                                                ),

                                                // Personal information ==========>
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0),
                                                  child:
                                                      const MenuPersonalInfoSection(),
                                                ),

                                                SettingsHelper()
                                                    .borderBold(25, 8),

                                                //Other settings options ========>
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: cc.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    child: Column(children: [
                                                      // SettingsHelper().settingOption(
                                                      //     'assets/svg/menu_job.svg',
                                                      //     asProvider.getString(
                                                      //         "My jobs"), () {
                                                      //   if (!pProvider
                                                      //       .jobPermission) {
                                                      //     OthersHelper().showToast(
                                                      //         'You don\'t have permission to access this feature',
                                                      //         Colors.black);
                                                      //     return;
                                                      //   }
                                                      //
                                                      //   Navigator.push(
                                                      //     context,
                                                      //     MaterialPageRoute<void>(
                                                      //       builder: (BuildContext
                                                      //               context) =>
                                                      //           const MyJobsPage(),
                                                      //     ),
                                                      //   );
                                                      // }),
                                                      // //============>
                                                      // CommonHelper()
                                                      //     .dividerCommon(),
                                                      // SettingsHelper().settingOption(
                                                      //     'assets/svg/menu_job_list.svg',
                                                      //     asProvider.getString(
                                                      //         "Job requests"), () {
                                                      //   if (!pProvider
                                                      //       .jobPermission) {
                                                      //     OthersHelper().showToast(
                                                      //         'You don\'t have permission to access this feature',
                                                      //         Colors.black);
                                                      //     return;
                                                      //   }
                                                      //   //=====>
                                                      //   Navigator.push(
                                                      //     context,
                                                      //     MaterialPageRoute<void>(
                                                      //       builder: (BuildContext
                                                      //               context) =>
                                                      //           const JobRequestPage(),
                                                      //     ),
                                                      //   );
                                                      // }),

                                                      //===========>
                                                      // CommonHelper()
                                                      //     .dividerCommon(),
                                                      // SettingsHelper().settingOption(
                                                      //     'assets/svg/menu_ticket.svg',
                                                      //     asProvider.getString(
                                                      //         "Support Ticket"),
                                                      //     () {
                                                      //   //=====>
                                                      //   Navigator.push(
                                                      //     context,
                                                      //     MaterialPageRoute<void>(
                                                      //       builder: (BuildContext
                                                      //               context) =>
                                                      //           const MyTicketsPage(),
                                                      //     ),
                                                      //   );
                                                      // }),
                                                      //
                                                      // CommonHelper()
                                                      //     .dividerCommon(),
                                                      // SettingsHelper().settingOption(
                                                      //     'assets/svg/menu_wallet.svg',
                                                      //     asProvider.getString(
                                                      //         "Wallet"), () {
                                                      //   if (!pProvider
                                                      //       .walletPermission) {
                                                      //     OthersHelper().showToast(
                                                      //         'You don\'t have permission to access this feature',
                                                      //         Colors.black);
                                                      //     return;
                                                      //   }
                                                      //   Navigator.push(
                                                      //     context,
                                                      //     MaterialPageRoute<void>(
                                                      //       builder: (BuildContext
                                                      //               context) =>
                                                      //           const WalletPage(),
                                                      //     ),
                                                      //   );
                                                      // }),

                                                      SettingsHelper().settingOption(
                                                          'assets/svg/profile-edit.svg',
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .editProfile, () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute<
                                                              void>(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                const ProfileEditPage(),
                                                          ),
                                                        );
                                                      }, context),
                                                      CommonHelper()
                                                          .dividerCommon(),
                                                      // Edit Business Profile
                                                      userType == '0'
                                                          ? SettingsHelper().settingOption(
                                                              'assets/svg/profile-edit.svg',
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .editBusinessProfile,
                                                              () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute<
                                                                    void>(
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      BusinessProfileEdit(
                                                                    navigationModel:
                                                                        NavigationModel(
                                                                            pageName:
                                                                                "Update Profile"),
                                                                  ),
                                                                ),
                                                              );
                                                            }, context)
                                                          : Offstage(),
                                                      CommonHelper()
                                                          .dividerCommon(),
                                                      // Setting App
                                                      // SettingsHelper().settingOption(
                                                      //     'assets/svg/setting_icon.svg',
                                                      //     AppLocalizations.of(
                                                      //             context)!
                                                      //         .appSetting, () {
                                                      //   Navigator.push(
                                                      //     context,
                                                      //     MaterialPageRoute<
                                                      //         void>(
                                                      //       builder: (BuildContext
                                                      //               context) =>
                                                      //           const AppSettings(),
                                                      //     ),
                                                      //   );
                                                      // }, context),
                                                      //
                                                      // CommonHelper()
                                                      //     .dividerCommon(),
                                                      SettingsHelper().settingOption(
                                                          'assets/icons/phone.png',
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .contactUs, () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SupportView(),
                                                            ));
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                      }, context),
                                                      CommonHelper()
                                                          .dividerCommon(),
                                                      SettingsHelper().settingOption(
                                                          'assets/svg/menu_job_list.svg',
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .privacyPolicy,
                                                          () {
                                                        context
                                                            .toPage(const TacPP(
                                                          route:
                                                              "/privacy-policy",
                                                        ));
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                      }, context),
                                                      CommonHelper()
                                                          .dividerCommon(),
                                                      SettingsHelper().settingOption(
                                                          'assets/svg/tasks.svg',
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .termsAndCondition,
                                                          () {
                                                        context
                                                            .toPage(const TacPP(
                                                          route:
                                                              "/terms-and-condition",
                                                        ));
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                      }, context),
                                                      // share
                                                      CommonHelper()
                                                          .dividerCommon(),
                                                      SettingsHelper().settingOption(
                                                          'assets/svg/share_icon.svg',
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .shareNow, () {
                                                        Share.share(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .shareText);
                                                      }, context),
                                                    ]),
                                                  ),
                                                ),

                                                // logout
                                                SettingsHelper()
                                                    .borderBold(12, 5),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: cc.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    child: Column(children: [
                                                      SettingsHelper().settingOption(
                                                          'assets/svg/menu_delete_account.svg',
                                                          asProvider.getString(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .deleteAccount),
                                                          () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute<
                                                              void>(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                DeleteAccountPage(),
                                                          ),
                                                        );
                                                      }, context),
                                                    ]),
                                                  ),
                                                ),
                                                CommonHelper().dividerCommon(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: cc.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    child: Column(children: [
                                                      SettingsHelper().settingOption(
                                                          'assets/svg/logout-circle.svg',
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .logout, () {
                                                        SettingsHelper()
                                                            .logoutPopup(
                                                                context);
                                                      }, context),
                                                    ]),
                                                  ),
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
                      // const ChatIcon(),
                    ],
                  ),
                );
    }));
  }
}
