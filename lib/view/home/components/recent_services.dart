import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/contactFeatures.dart';
import 'package:qixer/helper/extension/string_extension.dart';
import 'package:qixer/service/all_services_service.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/home_services/recent_services_service.dart';
import 'package:qixer/service/service_details_service.dart';
import 'package:qixer/service/vendorDashboardService/vendorDashboardService.dart';
import 'package:qixer/view/home/components/section_title.dart';
import 'package:qixer/view/home/components/service_card.dart';
import 'package:qixer/view/services/all_services_page.dart';
import 'package:qixer/view/services/service_details_page.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qixer/view/utils/responsive.dart';

class RecentServices extends StatelessWidget {
  const RecentServices({
    super.key,
    required this.cc,
    required this.asProvider,
  });
  final ConstantColors cc;
  final asProvider;

  @override
  Widget build(BuildContext context) {
    return Consumer<RecentServicesService>(
        builder: (context, provider, child) => provider.hasService != false
            ? provider.recentServiceMap.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Consumer<AllServicesService>(
                        builder: (context, allServiceProvider, child) {
                          return CategoryTitle2(
                            cc: cc,
                            title:
                                AppLocalizations.of(context)!.featuredService,
                            pressed: () {
                              // //when user clicks on recent see all. set sort by dropdown to latest
                              // allServiceProvider
                              //     .setSortbyValue('Latest Service');
                              // allServiceProvider
                              //     .setSelectedSortbyId('latest_service');
                              allServiceProvider.setEverythingToDefault();
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const AllServicePage(),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 190,
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          clipBehavior: Clip.none,
                          itemCount: provider.recentServiceMap.length,
                          itemBuilder: (context, i) {
                            var serviceAreaList =
                                provider.recentServiceMap[i]["serviceArea"];
                            var areas = (serviceAreaList != null &&
                                    serviceAreaList.isNotEmpty)
                                ? serviceAreaList.join(", ")
                                : ""; // Default message when empty

                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      // context
                                      //     .read<VendorDashboardService>()
                                      //     .sendNotification(context,
                                      //         sellerId: "4",
                                      //         msg: provider.recentServiceMap[i]
                                      //                 ['title']
                                      //             .toString());
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              ServiceDetailsPage(),
                                        ),
                                      );
                                      Provider.of<ServiceDetailsService>(
                                              context,
                                              listen: false)
                                          .fetchServiceDetails(
                                              provider.recentServiceMap[i]
                                                  ['serviceId']);
                                    },
                                    child: ServiceCard2(
                                      cc: cc,
                                      imageLink: provider.recentServiceMap[i]
                                              ['businessImage'] ??
                                          placeHolderUrl,
                                      rating: twoDouble(provider
                                          .recentServiceMap[i]['rating']),
                                      title: provider.recentServiceMap[i]
                                          ['title'],
                                      sellerName: provider.recentServiceMap[i]
                                          ['businessName'],
                                      price: provider.recentServiceMap[i]
                                          ['price'],
                                      buttonText: AppLocalizations.of(context)!
                                          .enquiryNow,
                                      width: MediaQuery.of(context).size.width -
                                          85,
                                      marginRight: 5.0,
                                      pressed: () {
                                        //     'service id is ${provider.recentServiceMap[i]['serviceId']}');
                                        provider.saveOrUnsave(
                                            provider.recentServiceMap[i]
                                                ['serviceId'],
                                            provider.recentServiceMap[i]
                                                ['title'],
                                            provider.recentServiceMap[i]
                                                ['image'],
                                            provider.recentServiceMap[i]
                                                ['price'],
                                            provider.recentServiceMap[i]
                                                ['sellerName'],
                                            twoDouble(provider
                                                .recentServiceMap[i]['rating']),
                                            i,
                                            context,
                                            provider.recentServiceMap[i]
                                                ['sellerId'],
                                            provider.recentServiceMap[i]
                                                ['experience']);
                                      },
                                      isSaved: provider.recentServiceMap[i]
                                                  ['isSaved'] ==
                                              true
                                          ? true
                                          : false,
                                      serviceId: provider.recentServiceMap[i]
                                          ['serviceId'],
                                      sellerId: provider.recentServiceMap[i]
                                          ['sellerId'],
                                      cardFrom: 'Home',
                                      // address.
                                      address: areas.toString().capitalizeWords,
                                      experience: provider.recentServiceMap[i]
                                                  ['experience'] ==
                                              null
                                          ? ''
                                          : (RegExp(r'^\d+$').hasMatch(provider
                                                  .recentServiceMap[i]
                                                      ['experience']
                                                  .toString())
                                              ? "${provider.recentServiceMap[i]['experience']} year"
                                              : "${provider.recentServiceMap[i]['experience']}"),
                                      status: provider.recentServiceMap[i]
                                              ['status']
                                          .toString(),
                                      onTapCall: () {
                                        ContactFeatures().launchCalling(
                                            context,
                                            provider.recentServiceMap[i]
                                                ['callNumber']);
                                        print(
                                            "on Tap Call ====> ${provider.recentServiceMap[i]['callNumber']}");
                                      },
                                      onTapWhatsapp: () {
                                        ContactFeatures().launchWhatsapp(
                                            context,
                                            provider.recentServiceMap[i]
                                                ['callNumber'],
                                            "${AppLocalizations.of(context)!.whatsappContactMsg} *${provider.recentServiceMap[i]['title']}*.");
                                        print(
                                            "on Tap Whatsapp ====> ${provider.recentServiceMap[i]['callNumber']}");
                                      },
                                    ),
                                  ),
                                  // if (i <
                                  //     provider.recentServiceMap.length - 1)
                                  //   VerticalDivider(
                                  //     endIndent: 20,
                                  //     width: 1,
                                  //     thickness: 1,
                                  //     color: cc.black6,
                                  //   ),
                                ],
                              ),
                            );
                          },
                          // children: [
                          //   for (int i = 0;
                          //       i < provider.recentServiceMap.length;
                          //       i++)
                          //
                          // ],
                        ),
                      ),
                    ],
                  )
                : Container()
            : Container());
  }
}
