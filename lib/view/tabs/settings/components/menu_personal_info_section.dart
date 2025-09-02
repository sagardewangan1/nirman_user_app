import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/view/booking/booking_helper.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/generated/app_localizations.dart';

class MenuPersonalInfoSection extends StatelessWidget {
  const MenuPersonalInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStringService>(
      builder: (context, asProvider, child) => Consumer<ProfileService>(
          builder: (context, profileProvider, child) => Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0)),
                padding: EdgeInsets.symmetric(
                    horizontal: screenPadding, vertical: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonHelper().titleCommon(
                        AppLocalizations.of(context)!.personalInformations,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      BookingHelper().bRow(
                          'null',
                          AppLocalizations.of(context)!.email,
                          profileProvider.profileDetails.userDetails.email ??
                              ''),
                      profileProvider.profileDetails.userDetails.businessName ==
                              null
                          ? Offstage()
                          : BookingHelper().bRow(
                              'null',
                              AppLocalizations.of(context)!.businessName,
                              profileProvider.profileDetails.userDetails
                                      .businessName ??
                                  ''),
                      profileProvider
                                  .profileDetails.userDetails.businessEmail ==
                              null
                          ? Offstage()
                          : BookingHelper().bRow(
                              'null',
                              AppLocalizations.of(context)!.businessEmail,
                              profileProvider.profileDetails.userDetails
                                      .businessEmail ??
                                  ''),
                      profileProvider.profileDetails.userDetails
                                  .businessFullAddress ==
                              null
                          ? Offstage()
                          : BookingHelper().bRow(
                              'null',
                              AppLocalizations.of(context)!.businessFullAddress,
                              profileProvider.profileDetails.userDetails
                                      .businessFullAddress ??
                                  '',
                            ),

                      profileProvider.profileDetails.userDetails
                                  .businessGstNumber ==
                              null
                          ? Offstage()
                          : BookingHelper().bRow(
                              'null',
                              AppLocalizations.of(context)!.businessGstNumber,
                              profileProvider.profileDetails.userDetails
                                      .businessGstNumber ??
                                  '',
                            ),

                      profileProvider.profileDetails.userDetails.city == null
                          ? Offstage()
                          : BookingHelper().bRow(
                              'null',
                              AppLocalizations.of(context)!.state,
                              profileProvider.profileDetails.userDetails.city
                                      .serviceCity ??
                                  '',
                            ),
                      profileProvider.profileDetails.userDetails.area == null
                          ? Offstage()
                          : BookingHelper().bRow(
                              'null',
                              AppLocalizations.of(context)!.city,
                              profileProvider.profileDetails.userDetails.area
                                      .serviceArea ??
                                  '',
                            ),
                      profileProvider.profileDetails.userDetails.country == null
                          ? Offstage()
                          : BookingHelper().bRow(
                              'null',
                              AppLocalizations.of(context)!.country,
                              profileProvider.profileDetails.userDetails.country
                                      .country ??
                                  '',
                            ),
                      // BookingHelper().bRow(
                      //     'null',
                      //     asProvider.getString("Post Code"),
                      //     profileProvider.profileDetails.userDetails.postCode ??
                      //         ''),
                      profileProvider.profileDetails.userDetails.address == null
                          ? Offstage()
                          : BookingHelper().bRow(
                              'null',
                              AppLocalizations.of(context)!.address,
                              profileProvider
                                      .profileDetails.userDetails.address ??
                                  '',
                              lastBorder: false),
                    ]),
              )),
    );
  }
}
