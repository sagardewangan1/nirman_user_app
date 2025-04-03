import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/contactFeatures.dart';
import 'package:qixer/helper/extension/int_extension.dart';
import 'package:qixer/helper/extension/string_extension.dart';
import 'package:qixer/helper/extension/widget_extension.dart';
import 'package:qixer/model/dropdown_models/area_dropdown_model.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/cityAndAreaController/cityAndAreaController.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/filter_services_service.dart';
import 'package:qixer/service/home_services/category_service.dart';
import 'package:qixer/view/home/home.dart';
import 'package:qixer/view/search/components/filter_icon_button.dart';
import 'package:qixer/view/search/components/location_sheet.dart';
import 'package:qixer/view/search/service_filter_model.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/custom_future_widget.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';

import '../../../service/service_details_service.dart';
import '../../home/components/service_card.dart';
import '../../services/service_details_page.dart';
import '../../utils/constant_colors.dart';
import 'category_sheet.dart';
import 'filter_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final sfm = ServiceFilterViewModel.instance;
    ConstantColors cc = ConstantColors();
    // TextEditingController searchController = TextEditingController();
    return Stack(
      children: [
        Consumer<AppStringService>(
          builder: (context, asProvider, child) => Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: cc.white),
                  child: TextFormField(
                    controller: sfm.searchTextController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.search,
                    ),
                    onChanged: (text) {
                      sfm.timer?.cancel();
                      sfm.timer = Timer(const Duration(milliseconds: 500), () {
                        Provider.of<FilterServicesService>(context,
                                listen: false)
                            .setSearchText(text);
                      });
                    },
                  )).hp20,
              12.toHeight,
              Card(
                surfaceTintColor: cc.black9,
                color: cc.black9,
                child: Row(
                  children: [
                    // FilterIconButton(
                    //   onPressed: () {
                    //     sfm.setNFilters(context);
                    //     showModalBottomSheet(
                    //       context: context,
                    //       builder: (context) {
                    //         return const FilterSheet();
                    //       },
                    //     );
                    //   },
                    //   icon: "filter",
                    //   subtitle: AppLocalizations.of(context)!.filter,
                    // ),
                    FilterIconButton(
                        subtitle: AppLocalizations.of(context)!.category,
                        onPressed: () {
                          sfm.setCFilters(context);
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return const CategorySheet();
                            },
                          );
                        },
                        icon: "category"),
                    FilterIconButton(
                        subtitle: "Location",
                        icon: "location",
                        onPressed: () {
                          // sfm.setLFilters(context);
                          showModalBottomSheet(
                            backgroundColor: Colors.white,
                            isScrollControlled: true,
                            enableDrag: true,
                            context: context,
                            builder: (contextSheet) {
                              return SizedBox(
                                height: 270,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Consumer<CityAndAreaController>(
                                    builder:
                                        (context, cityAndAreaProvider, child) =>
                                            Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Gap(15),
                                        CommonHelper().labelCommon2(
                                            AppLocalizations.of(context)!
                                                .chooseState),
                                        Gap(8),
                                        InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              backgroundColor: Colors.white,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            20)),
                                              ),
                                              builder: (context) {
                                                return const StateBottomSheetCard();
                                              },
                                            );
                                          },
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                  width: 1, color: cc.black5),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    textAlign: TextAlign.left,
                                                    cityAndAreaProvider
                                                        .stateName
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: cc.black6,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons
                                                        .keyboard_arrow_down_sharp,
                                                    size: 22,
                                                    color: cc.black6,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Gap(15),
                                        CommonHelper().labelCommon2(
                                            AppLocalizations.of(context)!
                                                .chooseArea),
                                        Gap(8),
                                        InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              backgroundColor: Colors.white,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            20)),
                                              ),
                                              builder: (context) {
                                                return const CityBottomSheetCard();
                                              },
                                            );
                                          },
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                  width: 1, color: cc.black5),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    textAlign: TextAlign.left,
                                                    cityAndAreaProvider
                                                            .cityName ??
                                                        AppLocalizations.of(
                                                                context)!
                                                            .chooseCity,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: cc.black6,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons
                                                        .keyboard_arrow_down_sharp,
                                                    size: 22,
                                                    color: cc.black6,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Gap(15),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  context
                                                      .read<
                                                          CityAndAreaController>()
                                                      .resetAll();
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: cc.black5),
                                                      color: cc.white),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 3.0),
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      AppLocalizations.of(
                                                              context)!
                                                          .clearFilter,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: cc.black5),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Gap(10),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  // Provider.of<CategoryService>(
                                                  //         context,
                                                  //         listen: false)
                                                  //     .fetchCategory(
                                                  //         location_id: context
                                                  //                 .read<
                                                  //                     CityAndAreaController>()
                                                  //                 .cityId
                                                  //                 ?.toString() ??
                                                  //             '');

                                                  Provider.of<FilterServicesService>(
                                                          context,
                                                          listen: false)
                                                      .setAreaID(context
                                                              .read<
                                                                  CityAndAreaController>()
                                                              .cityId
                                                              ?.toString() ??
                                                          '');

                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      color: cc.primaryColor),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 3.0),
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      AppLocalizations.of(
                                                              context)!
                                                          .applyFilter,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: cc.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                    FilterIconButton(
                      subtitle: AppLocalizations.of(context)!.reset,
                      onPressed: () {
                        Provider.of<FilterServicesService>(context,
                                listen: false)
                            .resetFilters();
                        context.read<CityAndAreaController>().resetAll();
                        sfm.searchTextController.text = "";
                        // context
                        //     .read<FilterServicesService>()
                        //     .serviceMap
                        //     .clear();
                      },
                      icon: "refresh",
                    ),
                  ],
                ),
              ).hp15,
              Consumer<FilterServicesService>(
                  builder: (context, provider, child) {
                return CustomFutureWidget(
                  shimmer: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 15),
                      child: OthersHelper().showLoading(cc.primaryColor)),
                  isLoading: provider.searchLoading,
                  child: Expanded(
                    child: provider.serviceMap.isEmpty ?? true
                        ? Container(
                            alignment: Alignment.center,
                            height: screenHeight - 140,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/nodata.png",
                                  fit: BoxFit.contain,
                                ),
                                Gap(10),
                                Text(AppLocalizations.of(context)!.searchHere),
                              ],
                            ),
                          )
                        : ListView.separated(
                            padding: EdgeInsets.zero,
                            separatorBuilder: (context, index) => 0.toHeight,
                            itemBuilder: (context, i) {
                              var serviceAreaList =
                                  provider.serviceMap[i]["serviceArea"];
                              var areas = (serviceAreaList != null &&
                                      serviceAreaList.isNotEmpty)
                                  ? serviceAreaList.join(", ")
                                  : ""; // Default message when empty
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: Column(
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
                                            .fetchServiceDetails(provider
                                                .serviceMap[i]['serviceId']);
                                      },
                                      child: ServiceCard(
                                        cc: cc,
                                        imageLink: provider.serviceMap[i]
                                                ['businessImage'] ??
                                            placeHolderUrl,
                                        rating: twoDouble(
                                            provider.serviceMap[i]['rating']),
                                        title: provider.serviceMap[i]['title'],
                                        sellerName: provider.serviceMap[i]
                                            ['businessName'],
                                        price: provider.serviceMap[i]['price'],
                                        buttonText:
                                            AppLocalizations.of(context)!
                                                .enquiryNow,
                                        width: double.infinity,
                                        marginRight: 5.0,
                                        pressed: () {
                                          //     'service id is ${provider.recentServiceMap[i]['serviceId']}');
                                          provider.saveOrUnsave(
                                              provider.serviceMap[i]
                                                  ['serviceId'],
                                              provider.serviceMap[i]['title']
                                                  .toString(),
                                              provider.serviceMap[i]
                                                      ['businessImage']
                                                  .toString(),
                                              provider.serviceMap[i]['price']
                                                  .toString(),
                                              provider.serviceMap[i]
                                                      ['sellerName']
                                                  .toString(),
                                              twoDouble(provider.serviceMap[i]
                                                  ['rating']),
                                              i,
                                              context,
                                              provider.serviceMap[i]
                                                  ['sellerId'],
                                              provider.serviceMap[i]
                                                          ['experience']
                                                      .toString() ??
                                                  '');
                                        },
                                        isSaved: provider.serviceMap[i]
                                                    ['isSaved'] ==
                                                true
                                            ? true
                                            : false,
                                        serviceId: provider.serviceMap[i]
                                            ['serviceId'],
                                        sellerId: provider.serviceMap[i]
                                            ['sellerId'],
                                        cardFrom: 'Home',
                                        address:
                                            areas.toString().capitalizeWords,
                                        // experience: "8 year",
                                        experience: provider.serviceMap[i]
                                                    ['experience'] ==
                                                null
                                            ? ''
                                            : (RegExp(r'^\d+$').hasMatch(
                                                    provider.serviceMap[i]
                                                            ['experience']
                                                        .toString())
                                                ? "${provider.serviceMap[i]['experience']} year"
                                                : "${provider.serviceMap[i]['experience']}"),

                                        status: provider.serviceMap[i]['status']
                                            .toString(),
                                        onTapCall: () {
                                          ContactFeatures().launchCalling(
                                              context,
                                              provider.serviceMap[i]
                                                  ['callNumber']);
                                          print(
                                              "on Tap Call ====> ${provider.serviceMap[i]['callNumber']}");
                                        },
                                        onTapWhatsapp: () {
                                          ContactFeatures().launchWhatsapp(
                                              context,
                                              provider.serviceMap[i]
                                                  ['callNumber'],
                                              "Hello, I am interested in your service *${provider.serviceMap[i]['title']}*.");
                                          print(
                                              "on Tap Whatsapp ====> ${provider.serviceMap[i]['callNumber']}");
                                        },
                                      ),
                                    ),
                                    // if (i < provider.serviceMap.length - 1)
                                    //   Divider(
                                    //     thickness: 1,
                                    //     height: 2,
                                    //     color: cc.black6,
                                    //   )
                                  ],
                                ),
                              );
                            },
                            itemCount: provider.serviceMap.length),
                  ),
                );
              }),
            ],
          ),
        ),

        // const LocationSheet(),
      ],
    );
  }
}
