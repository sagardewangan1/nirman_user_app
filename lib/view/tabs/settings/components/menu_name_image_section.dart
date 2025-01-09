import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/view/tabs/settings/components/settings_page_grid.dart';
import 'package:qixer/view/tabs/settings/profile_edit.dart';
import 'package:qixer/view/tabs/settings/settings_helper.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_styles.dart';

class MenuNameImageSection extends StatelessWidget {
  const MenuNameImageSection({super.key});

  @override
  Widget build(BuildContext context) {
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
                        CommonHelper().titleCommon(
                            profileProvider.profileDetails.userDetails.name ??
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

                  //Grid cards
                  const SettingsPageGrid(),
                ],
              ),

              //
            ]),
          ),
          SettingsHelper().borderBold(30, 20),
        ],
      ),
    );
  }
}
