import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qixer/helper/contactFeatures.dart';
import 'package:qixer/helper/extension/int_extension.dart';
import 'package:qixer/helper/extension/string_extension.dart';
import 'package:qixer/helper/extension/widget_extension.dart';
import 'package:qixer/service/all_services_service.dart';
import 'package:qixer/service/cityAndAreaController/cityAndAreaController.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/filter_services_service.dart';
import 'package:qixer/service/service_details_service.dart';
import 'package:qixer/view/home/home.dart';
import 'package:qixer/view/search/components/category_sheet.dart';
import 'package:qixer/view/search/components/filter_icon_button.dart';
import 'package:qixer/view/search/components/filter_sheet.dart';
import 'package:qixer/view/search/service_filter_model.dart';
import 'package:qixer/view/services/components/service_filter_dropdowns.dart';
import 'package:qixer/view/services/service_details_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../home/components/service_card.dart';

class AllServicePage extends StatefulWidget {
  const AllServicePage({super.key});

  @override
  State<AllServicePage> createState() => _AllServicePageState();
}

class _AllServicePageState extends State<AllServicePage> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<AllServicesService>(context, listen: false).resetFilters();
      await Provider.of<AllServicesService>(context, listen: false)
          .fetchAllService(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    final sfm = ServiceFilterViewModel.instance;
    return Scaffold(
      appBar: CommonHelper()
          .appbarCommon(AppLocalizations.of(context)!.allServices, context, () {
        Navigator.pop(context);
      }),
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        enablePullDown:
            context.watch<AllServicesService>().currentPage > 1 ? false : true,
        onRefresh: () async {
          final result =
              await Provider.of<AllServicesService>(context, listen: false)
                  .fetchAllService(context, isRefresh: true);
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result =
              await Provider.of<AllServicesService>(context, listen: false)
                  .fetchAllService(context);
          if (result) {
            debugPrint('loadcomplete ran');
            refreshController.loadComplete();
          } else {
            debugPrint('no more data');
            refreshController.loadNoData();
            Future.delayed(const Duration(seconds: 1), () {
              refreshController.resetNoData();
            });
          }
        },
        footer: OthersHelper().commonRefreshFooter(context),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Consumer<AllServicesService>(
              builder: (context, provider, child) => Column(
                children: [
                  12.toHeight,
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
                          sfm.timer = Timer(const Duration(seconds: 1), () {
                            final provider = Provider.of<AllServicesService>(
                                context,
                                listen: false);
                            provider.setSearch(context, text);
                            provider.fetchAllService(context,
                                isRefresh: true); // 🔹 Search ke sath API call
                          });
                        },
                      )).hp20,
                  12.toHeight,
                  // Card(
                  //   surfaceTintColor: cc.black9,
                  //   color: cc.black9,
                  //   child: Row(
                  //     children: [
                  //       FilterIconButton(
                  //         onPressed: () {
                  //           sfm.setNFilters(context);
                  //           showModalBottomSheet(
                  //             context: context,
                  //             builder: (context) {
                  //               return const FilterSheet();
                  //             },
                  //           );
                  //         },
                  //         icon: "filter",
                  //         subtitle: AppLocalizations.of(context)!.filter,
                  //       ),
                  //       FilterIconButton(
                  //           subtitle: "Location",
                  //           icon: "location",
                  //           onPressed: () {
                  //             // sfm.setLFilters(context);
                  //             showModalBottomSheet(
                  //               backgroundColor: Colors.white,
                  //               isScrollControlled: true,
                  //               enableDrag: true,
                  //               context: context,
                  //               builder: (contextSheet) {
                  //                 return SizedBox(
                  //                   height: 270,
                  //                   child: Padding(
                  //                     padding: const EdgeInsets.all(8.0),
                  //                     child: Consumer<CityAndAreaController>(
                  //                       builder: (context, cityAndAreaProvider,
                  //                               child) =>
                  //                           Column(
                  //                         crossAxisAlignment:
                  //                             CrossAxisAlignment.start,
                  //                         children: [
                  //                           Gap(15),
                  //                           CommonHelper().labelCommon2(
                  //                               AppLocalizations.of(context)!
                  //                                   .chooseState),
                  //                           Gap(8),
                  //                           InkWell(
                  //                             onTap: () {
                  //                               showModalBottomSheet(
                  //                                 context: context,
                  //                                 isScrollControlled: true,
                  //                                 backgroundColor: Colors.white,
                  //                                 shape:
                  //                                     const RoundedRectangleBorder(
                  //                                   borderRadius:
                  //                                       BorderRadius.vertical(
                  //                                           top:
                  //                                               Radius.circular(
                  //                                                   20)),
                  //                                 ),
                  //                                 builder: (context) {
                  //                                   return const StateBottomSheetCard();
                  //                                 },
                  //                               );
                  //                             },
                  //                             child: Container(
                  //                               alignment: Alignment.centerLeft,
                  //                               decoration: BoxDecoration(
                  //                                 borderRadius:
                  //                                     BorderRadius.circular(
                  //                                         5.0),
                  //                                 border: Border.all(
                  //                                     width: 1,
                  //                                     color: cc.black5),
                  //                               ),
                  //                               child: Padding(
                  //                                 padding:
                  //                                     const EdgeInsets.all(8.0),
                  //                                 child: Row(
                  //                                   crossAxisAlignment:
                  //                                       CrossAxisAlignment
                  //                                           .center,
                  //                                   mainAxisAlignment:
                  //                                       MainAxisAlignment
                  //                                           .spaceBetween,
                  //                                   children: [
                  //                                     Text(
                  //                                       textAlign:
                  //                                           TextAlign.left,
                  //                                       cityAndAreaProvider
                  //                                           .stateName
                  //                                           .toString(),
                  //                                       style: TextStyle(
                  //                                         fontSize: 14,
                  //                                         color: cc.black6,
                  //                                         fontWeight:
                  //                                             FontWeight.w500,
                  //                                       ),
                  //                                     ),
                  //                                     Icon(
                  //                                       Icons
                  //                                           .keyboard_arrow_down_sharp,
                  //                                       size: 22,
                  //                                       color: cc.black6,
                  //                                     ),
                  //                                   ],
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                           ),
                  //                           Gap(15),
                  //                           CommonHelper().labelCommon2(
                  //                               AppLocalizations.of(context)!
                  //                                   .chooseArea),
                  //                           Gap(8),
                  //                           InkWell(
                  //                             onTap: () {
                  //                               showModalBottomSheet(
                  //                                 context: context,
                  //                                 isScrollControlled: true,
                  //                                 backgroundColor: Colors.white,
                  //                                 shape:
                  //                                     const RoundedRectangleBorder(
                  //                                   borderRadius:
                  //                                       BorderRadius.vertical(
                  //                                           top:
                  //                                               Radius.circular(
                  //                                                   20)),
                  //                                 ),
                  //                                 builder: (context) {
                  //                                   return const CityBottomSheetCard();
                  //                                 },
                  //                               );
                  //                             },
                  //                             child: Container(
                  //                               alignment: Alignment.centerLeft,
                  //                               decoration: BoxDecoration(
                  //                                 borderRadius:
                  //                                     BorderRadius.circular(
                  //                                         5.0),
                  //                                 border: Border.all(
                  //                                     width: 1,
                  //                                     color: cc.black5),
                  //                               ),
                  //                               child: Padding(
                  //                                 padding:
                  //                                     const EdgeInsets.all(8.0),
                  //                                 child: Row(
                  //                                   crossAxisAlignment:
                  //                                       CrossAxisAlignment
                  //                                           .center,
                  //                                   mainAxisAlignment:
                  //                                       MainAxisAlignment
                  //                                           .spaceBetween,
                  //                                   children: [
                  //                                     Text(
                  //                                       textAlign:
                  //                                           TextAlign.left,
                  //                                       cityAndAreaProvider
                  //                                               .cityName ??
                  //                                           AppLocalizations.of(
                  //                                                   context)!
                  //                                               .chooseCity,
                  //                                       style: TextStyle(
                  //                                         fontSize: 14,
                  //                                         color: cc.black6,
                  //                                         fontWeight:
                  //                                             FontWeight.w500,
                  //                                       ),
                  //                                     ),
                  //                                     Icon(
                  //                                       Icons
                  //                                           .keyboard_arrow_down_sharp,
                  //                                       size: 22,
                  //                                       color: cc.black6,
                  //                                     ),
                  //                                   ],
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                           ),
                  //                           Gap(15),
                  //                           Row(
                  //                             mainAxisAlignment:
                  //                                 MainAxisAlignment
                  //                                     .spaceBetween,
                  //                             children: [
                  //                               Expanded(
                  //                                 child: InkWell(
                  //                                   onTap: () {
                  //                                     context
                  //                                         .read<
                  //                                             CityAndAreaController>()
                  //                                         .resetAll();
                  //                                     Navigator.pop(context);
                  //                                   },
                  //                                   child: Container(
                  //                                     alignment:
                  //                                         Alignment.center,
                  //                                     decoration: BoxDecoration(
                  //                                         borderRadius:
                  //                                             BorderRadius
                  //                                                 .circular(
                  //                                                     8.0),
                  //                                         border: Border.all(
                  //                                             width: 1,
                  //                                             color: cc.black5),
                  //                                         color: cc.white),
                  //                                     child: Padding(
                  //                                       padding:
                  //                                           const EdgeInsets
                  //                                               .symmetric(
                  //                                               vertical: 8.0,
                  //                                               horizontal:
                  //                                                   3.0),
                  //                                       child: Text(
                  //                                         textAlign:
                  //                                             TextAlign.center,
                  //                                         AppLocalizations.of(
                  //                                                 context)!
                  //                                             .clearFilter,
                  //                                         style: TextStyle(
                  //                                             fontWeight:
                  //                                                 FontWeight
                  //                                                     .w500,
                  //                                             color: cc.black5),
                  //                                       ),
                  //                                     ),
                  //                                   ),
                  //                                 ),
                  //                               ),
                  //                               Gap(10),
                  //                               Expanded(
                  //                                 child: InkWell(
                  //                                   onTap: () {
                  //                                     // Provider.of<CategoryService>(
                  //                                     //         context,
                  //                                     //         listen: false)
                  //                                     //     .fetchCategory(
                  //                                     //         location_id: context
                  //                                     //                 .read<
                  //                                     //                     CityAndAreaController>()
                  //                                     //                 .cityId
                  //                                     //                 ?.toString() ??
                  //                                     //             '');
                  //                                     Provider.of<FilterServicesService>(
                  //                                             context,
                  //                                             listen: false)
                  //                                         .setAreaID(context
                  //                                                 .read<
                  //                                                     CityAndAreaController>()
                  //                                                 .cityId
                  //                                                 ?.toString() ??
                  //                                             '');
                  //
                  //                                     Navigator.pop(context);
                  //                                   },
                  //                                   child: Container(
                  //                                     alignment:
                  //                                         Alignment.center,
                  //                                     decoration: BoxDecoration(
                  //                                         borderRadius:
                  //                                             BorderRadius
                  //                                                 .circular(
                  //                                                     8.0),
                  //                                         color:
                  //                                             cc.primaryColor),
                  //                                     child: Padding(
                  //                                       padding:
                  //                                           const EdgeInsets
                  //                                               .symmetric(
                  //                                               vertical: 8.0,
                  //                                               horizontal:
                  //                                                   3.0),
                  //                                       child: Text(
                  //                                         textAlign:
                  //                                             TextAlign.center,
                  //                                         AppLocalizations.of(
                  //                                                 context)!
                  //                                             .applyFilter,
                  //                                         style: TextStyle(
                  //                                             fontWeight:
                  //                                                 FontWeight
                  //                                                     .w500,
                  //                                             color: cc.white),
                  //                                       ),
                  //                                     ),
                  //                                   ),
                  //                                 ),
                  //                               ),
                  //                             ],
                  //                           )
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 );
                  //               },
                  //             );
                  //           }),
                  //       FilterIconButton(
                  //           subtitle: AppLocalizations.of(context)!.category,
                  //           onPressed: () {
                  //             sfm.setCFilters(context);
                  //             showModalBottomSheet(
                  //               context: context,
                  //               builder: (context) {
                  //                 return const CategorySheet();
                  //               },
                  //             );
                  //           },
                  //           icon: "category"),
                  //       FilterIconButton(
                  //         subtitle: AppLocalizations.of(context)!.reset,
                  //         onPressed: () {
                  //           Provider.of<FilterServicesService>(context,
                  //                   listen: false)
                  //               .resetFilters();
                  //           sfm.searchTextController.text = "";
                  //         },
                  //         icon: "refresh",
                  //       ),
                  //     ],
                  //   ),
                  // ).hp15,

                  // Card(
                  //   surfaceTintColor: cc.black9,
                  //   color: cc.black9,
                  //   child: Row(
                  //     children: [
                  //       FilterIconButton(
                  //         onPressed: () {
                  //           sfm.setNFilters(context);
                  //           showModalBottomSheet(
                  //             context: context,
                  //             builder: (context) {
                  //               return const FilterSheet();
                  //             },
                  //           );
                  //         },
                  //         icon: "filter",
                  //         subtitle: AppLocalizations.of(context)!.filter,
                  //       ),
                  //       // FilterIconButton(
                  //       //     subtitle: "Location",
                  //       //     icon: "location",
                  //       //     onPressed: () {
                  //       //       sfm.setLFilters(context);
                  //       //       showModalBottomSheet(
                  //       //         context: context,
                  //       //         builder: (context) {
                  //       //           return const LocationSheet();
                  //       //         },
                  //       //       );
                  //       //     }),
                  //       FilterIconButton(
                  //           subtitle: AppLocalizations.of(context)!.category,
                  //           onPressed: () {
                  //             sfm.setCFilters(context);
                  //             showModalBottomSheet(
                  //               context: context,
                  //               builder: (context) {
                  //                 return const CategorySheet();
                  //               },
                  //             );
                  //           },
                  //           icon: "category"),
                  //       FilterIconButton(
                  //         subtitle: AppLocalizations.of(context)!.reset,
                  //         onPressed: () {
                  //           Provider.of<FilterServicesService>(context,
                  //                   listen: false)
                  //               .resetFilters();
                  //           sfm.searchTextController.text = "";
                  //         },
                  //         icon: "refresh",
                  //       ),
                  //     ],
                  //   ),
                  // ).hp15,
                  // const SizedBox(height: 14),

                  /// **Dropdown Filters**
                  // const ServiceFilterDropdowns(),

                  /// **Service List**
                  !provider.isLoading
                      ? provider.serviceMap.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: provider.serviceMap.length,
                                itemBuilder: (context, i) {
                                  final service = provider.serviceMap[i];
                                  var serviceAreaList = service["serviceArea"];
                                  var areas = (serviceAreaList != null &&
                                          serviceAreaList.isNotEmpty)
                                      ? serviceAreaList.join(", ")
                                      : ""; // Default message when empty
                                  // debugPrint("areas=====> $areas");
                                  return Column(
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
                                                  service['serviceId']);
                                        },
                                        child: ServiceCard(
                                          cc: cc,
                                          imageLink: service['businessImage'] ??
                                              placeHolderUrl,
                                          rating: twoDouble(service['rating']),
                                          title: service['title'],
                                          sellerName: service['sellerName'],
                                          price: service['price'],
                                          buttonText:
                                              AppLocalizations.of(context)!
                                                  .enquiryNow,
                                          width: double.infinity,
                                          marginRight: 0.0,
                                          pressed: () {
                                            provider.saveOrUnsave(
                                              service['serviceId'],
                                              service['title'],
                                              service['image'],
                                              service['price'].round(),
                                              service['sellerName'],
                                              twoDouble(service['rating']),
                                              i,
                                              context,
                                              service['sellerId'],
                                              service['experience'] ?? '',
                                            );
                                          },
                                          isSaved: service['isSaved'] == true,
                                          serviceId: service['serviceId'],
                                          sellerId: service['sellerId'],
                                          cardFrom: 'Home',
                                          address:
                                              areas.toString().capitalizeWords,
                                          experience: service['experience'] ==
                                                  null
                                              ? ''
                                              : (RegExp(r'^\d+$').hasMatch(
                                                      service['experience']
                                                          .toString())
                                                  ? "${service['experience']} year"
                                                  : "${service['experience']}"),
                                          status: service['status'].toString(),
                                          onTapCall: () {
                                            ContactFeatures().launchCalling(
                                                context, service['callNumber']);
                                            print(
                                                "on Tap Call ====> ${service['callNumber']}");
                                          },
                                          onTapWhatsapp: () {
                                            ContactFeatures().launchWhatsapp(
                                                context,
                                                service['callNumber'],
                                                "${AppLocalizations.of(context)!.whatsappContactMsg} *${service['title']}*.");
                                            print(
                                                "on Tap Whatsapp ====> ${service['callNumber']}");
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  );
                                },
                              ),
                            )
                          : Container(
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
                                  Text(AppLocalizations.of(context)!
                                      .noServiceProviderInYourArea),
                                ],
                              ),
                            )
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 60),
                            child: CircularProgressIndicator(
                              color: cc.primaryColor,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
