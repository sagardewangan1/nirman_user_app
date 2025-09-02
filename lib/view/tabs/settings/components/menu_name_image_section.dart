import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/helper/extension/string_extension.dart';
import 'package:qixer/service/auth_services/change_pass_service.dart';
import 'package:qixer/service/languageController/languageController.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/view/VenderDashBoard/VenderDashBoardView.dart';
import 'package:qixer/view/tabs/settings/components/settings_page_grid.dart';
import 'package:qixer/view/tabs/settings/profile_edit.dart';
import 'package:qixer/view/tabs/settings/settings_helper.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/generated/app_localizations.dart';
import '../../../../model/navigationModel.dart';
import '../../leads/leadsView.dart';

class MenuNameImageSection extends StatelessWidget {
  final String userType;
  final String navfrom;
  const MenuNameImageSection(
      {super.key, required this.userType, required this.navfrom});

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Consumer<ProfileService>(
      builder: (context, profileProvider, child) => Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: screenPadding),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //profile image, name ,desc
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  //Profile image section =======>
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const ProfileEditPage(),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        profileProvider.profileImage != null
                            ? CommonHelper().profileImage(
                                profileProvider.profileImage, 62, 62)
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/avatar.png',
                                  height: 62,
                                  width: 62,
                                  fit: BoxFit.cover,
                                ),
                              ),

                        const SizedBox(
                          height: 12,
                        ),

                        //user name
                        CommonHelper().titleCommon(profileProvider
                                .profileDetails.userDetails.name
                                .toString()
                                .capitalize ??
                            ''),
                        const SizedBox(
                          height: 5,
                        ),
                        //phone
                        CommonHelper().paragraphCommon(
                            profileProvider.profileDetails.userDetails.phone ??
                                '',
                            textAlign: TextAlign.center),

                        profileProvider.profileDetails.userDetails.about != null
                            ? CommonHelper().paragraphCommon(
                                profileProvider
                                    .profileDetails.userDetails.about,
                                textAlign: TextAlign.center)
                            : Container(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  userType == '0' && navfrom != "vendor"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () =>
                                  context.toPage(VendorDashBoardVies()),
                              child: Container(
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: cc.borderColor),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    // mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.dashboard),
                                      Gap(5),
                                      Text(
                                        AppLocalizations.of(context)!.dashboard,
                                        style: TextStyle(
                                          color: cc.greyParagraph,
                                          height: 1.4,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => context.toPage(
                                LeadsView(
                                  navigationModel:
                                      NavigationModel(navFrom: "Direct"),
                                ),
                              ),
                              child: Container(
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: cc.borderColor),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.leaderboard),
                                      Gap(5),
                                      Text(
                                        AppLocalizations.of(context)!.myLeads,
                                        style: TextStyle(
                                          color: cc.greyParagraph,
                                          height: 1.4,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Offstage(),
                  SizedBox(
                    height: 10,
                  ),
                  Consumer<LanguageController>(
                    builder: (context, langController, child) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () async => await langController
                                  .changeLanguage(Locale("en")),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                      color: langController.languageTitle ==
                                              "English"
                                          ? cc.primaryColor
                                          : cc.black5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    "English",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: InkWell(
                              onTap: () async => await langController
                                  .changeLanguage(Locale("hi")),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                      color: langController.languageTitle ==
                                              "हिंदी"
                                          ? cc.primaryColor
                                          : cc.black5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    "हिंदी",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),

              //
            ]),
          ),
          SettingsHelper().borderBold(15, 10),
        ],
      ),
    );
  }
}
