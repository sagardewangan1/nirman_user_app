import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/SharedPreferencesHelper.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/service/cityAndAreaController/cityAndAreaController.dart';
import 'package:qixer/service/home_services/landingPageService.dart';
import 'package:qixer/service/jobs_service/recent_jobs_service.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/view/selectionRole/selectionRoleView.dart';
import 'package:qixer/view/tabs/settings/profile_edit.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/generated/app_localizations.dart';

import '../../utils/login_or_register.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.cc,
    this.onTapLocation,
    required this.isLoggedIn,
    this.userType,
    this.totalUnreadLeads,
    this.userNotificationCount,
  });

  final ConstantColors cc;
  final bool isLoggedIn;
  final VoidCallback? onTapLocation;
  final String? userType;
  final String? totalUnreadLeads;
  final String? userNotificationCount;

  @override
  Widget build(BuildContext context) {
    print(
        "totalUnreadLeads===>   $totalUnreadLeads and runtype==> ${totalUnreadLeads.runtimeType}");
    return Consumer<ProfileService>(
      builder: (context, profileProvider, child) {
        return isLoggedIn
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonHelper().homeAppBarLogo(appIconUrl, 38, 38),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ONE NATION ONE CLICK",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      Consumer<CityAndAreaController>(
                        builder: (context, providerRecentJob, child) {
                          return GestureDetector(
                            onTap: onTapLocation,
                            child: Text(
                              "${providerRecentJob.cityName ?? AppLocalizations.of(context)!.selectArea} >",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(color: cc.primaryColor),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  Spacer(),
                  //profile image
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const ProfileEditPage(),
                        ),
                      );
                    },
                    child: profileProvider.profileImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CommonHelper().profileImage(
                                profileProvider.profileImage, 38, 38),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/avatar.png',
                              height: 38,
                              width: 38,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  userType == "0" && userType != null
                      ? InkWell(
                          onTap: () => userType == '0'
                              ? context
                                  .read<LandingPageService>()
                                  .setTabIndex(1)
                              : context
                                  .read<LandingPageService>()
                                  .setTabIndex(1),
                          child: CircleAvatar(
                              radius: 21,
                              backgroundColor: cc.black8,
                              child: Badge(
                                label: (totalUnreadLeads != null &&
                                        totalUnreadLeads != '0' &&
                                        totalUnreadLeads?.toLowerCase() !=
                                            'null')
                                    ? Text(
                                        totalUnreadLeads!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 8,
                                        ),
                                      )
                                    : null,
                                child: Icon(
                                  Icons.notifications,
                                  color: cc.black5,
                                ),
                              )),
                        )
                      : Offstage(),

                  // CircleAvatar(
                  //         radius: 21,
                  //         backgroundColor: cc.black8,
                  //         child: Badge(
                  //           label: userNotificationCount == '0'
                  //               ? Text(
                  //                   userNotificationCount.toString(),
                  //                   style: TextStyle(
                  //                       fontWeight: FontWeight.w400,
                  //                       fontSize: 8),
                  //                 )
                  //               : null,
                  //           child: Icon(
                  //             Icons.notifications,
                  //             color: cc.black5,
                  //           ),
                  //         )),
                  // Row(
                  //   children: [
                  //     Icon(
                  //       Icons.notifications,
                  //       color: cc.black4,
                  //     ),
                  //     sizedBoxCustom(10),
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 10, right: 10),
                  //       child: ClipOval(
                  //         child: CachedNetworkImage(
                  //           height: 25,
                  //           width: 25,
                  //           imageUrl: userPlaceHolderUrl,
                  //           errorWidget: (context, url, error) =>
                  //               Image.network(
                  //                   height: 40,
                  //                   width: 40,
                  //                   userPlaceHolderUrl),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // )
                ],
              )
            : const GuestAppBar();
      },
    );
  }
}

class GuestAppBar extends StatelessWidget {
  const GuestAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // width: double.infinity,
      // padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonHelper().homeAppBarLogo(appIconUrl, 40, 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ONE NATION ONE CLICK",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              // Text(
              //   "Raipur >",
              //   style: Theme.of(context)
              //       .textTheme
              //       .labelSmall!
              //       .copyWith(color: cc.primaryColor),
              // ),
            ],
          ),
          Spacer(),
          //profile image
          // InkWell(
          //   onTap: () {
          //     SharedPreferencesHelper.clearData();
          //     context.toPage(SelectionRoleView(hasBackButton: false));
          //   },
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(100),
          //     child: CommonHelper().profileImage(appIconUrl, 38, 38),
          //   ),
          // ),
        ],
      ),
    );
  }
}
