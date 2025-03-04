import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/SharedPreferencesHelper.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/service/jobs_service/recent_jobs_service.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/view/selectionRole/selectionRoleView.dart';
import 'package:qixer/view/tabs/settings/profile_edit.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.cc,
    this.onTapLocation,
  });

  final ConstantColors cc;
  final VoidCallback? onTapLocation;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileService>(
      builder: (context, profileProvider, child) =>
          profileProvider.profileDetails != null
              ? profileProvider.profileDetails != 'error'
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
                            Consumer<RecentJobsService>(
                              builder: (context, providerRecentJob, child) {
                                return GestureDetector(
                                  onTap: onTapLocation,
                                  child: Text(
                                    "${providerRecentJob.cityName ?? "Select Location"} >",
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
                        CircleAvatar(
                          radius: 21,
                          backgroundColor: cc.black8,
                          child: Icon(
                            Icons.notifications,
                            color: cc.black5,
                          ),
                        ),
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
                  : const GuestAppBar()
              : const GuestAppBar(),
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
