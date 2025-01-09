import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/view/tabs/settings/profile_edit.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/responsive.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.cc,
  });

  final ConstantColors cc;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileService>(
      builder: (context, profileProvider, child) =>
          profileProvider.profileDetails != null
              ? profileProvider.profileDetails != 'error'
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const ProfileEditPage(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${lnProvider.getString('Welcome')}!',
                                style: TextStyle(
                                  color: cc.greyParagraph,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                profileProvider
                                        .profileDetails.userDetails.name ??
                                    '',
                                style: TextStyle(
                                  color: cc.greyFour,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )),

                          //profile image
                          profileProvider.profileImage != null
                              ? CommonHelper().profileImage(
                                  profileProvider.profileImage, 52, 52)
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    'assets/images/avatar.png',
                                    height: 52,
                                    width: 52,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ],
                      ),
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
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonHelper().titleCommon("Hello! 👋", color: cc.black3),
          CommonHelper().titleCommon("Welcome to Qixer", color: cc.black3),
        ],
      ),
    );
  }
}
