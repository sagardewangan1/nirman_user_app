import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/contactFeatures.dart';
import 'package:qixer/helper/extension/string_extension.dart';
import 'package:qixer/service/all_services_service.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/home_services/recent_services_service.dart';
import 'package:qixer/service/service_details_service.dart';
import 'package:qixer/view/home/components/section_title.dart';
import 'package:qixer/view/home/components/service_card.dart';
import 'package:qixer/view/services/all_services_page.dart';
import 'package:qixer/view/services/service_details_page.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';

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
              ? provider.recentServiceMap[0] != 'error'
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
                              title: asProvider.getString('Featured Services'),
                              pressed: () {
                                //when user clicks on recent see all. set sort by dropdown to latest
                                allServiceProvider
                                    .setSortbyValue('Latest Service');
                                allServiceProvider
                                    .setSelectedSortbyId('latest_service');
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
                          height: 200,
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
                                  : "NA"; // Default message when empty

                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                const ServiceDetailsPage(),
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
                                                ['image'] ??
                                            placeHolderUrl,
                                        rating: twoDouble(provider
                                            .recentServiceMap[i]['rating']),
                                        title: provider.recentServiceMap[i]
                                            ['title'],
                                        sellerName: provider.recentServiceMap[i]
                                            ['sellerName'],
                                        price: provider.recentServiceMap[i]
                                            ['price'],
                                        buttonText: 'Enquiry Now',
                                        width:
                                            MediaQuery.of(context).size.width -
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
                                              twoDouble(
                                                  provider.recentServiceMap[i]
                                                      ['rating']),
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
                                        address: areas.toString().capitalize,
                                        experience: provider.recentServiceMap[i]
                                                    ['experience'] ==
                                                null
                                            ? ''
                                            : (RegExp(r'^\d+$').hasMatch(
                                                    provider.recentServiceMap[i]
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
                                              "Hello Sir,How can i help you ?");
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
                  : Offstage()
              : Container()
          : Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 35),
              child: Text(
                  asProvider.getString('No service available in your area')),
            ),
    );
  }
}
