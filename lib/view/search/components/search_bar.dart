import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/int_extension.dart';
import 'package:qixer/helper/extension/widget_extension.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/filter_services_service.dart';
import 'package:qixer/view/search/components/filter_icon_button.dart';
import 'package:qixer/view/search/components/location_sheet.dart';
import 'package:qixer/view/search/service_filter_model.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/custom_future_widget.dart';
import 'package:qixer/view/utils/others_helper.dart';

import '../../../service/service_details_service.dart';
import '../../home/components/service_card.dart';
import '../../services/service_details_page.dart';
import '../../utils/constant_colors.dart';
import 'category_sheet.dart';
import 'filter_sheet.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final sfm = ServiceFilterViewModel.instance;
    ConstantColors cc = ConstantColors();
    TextEditingController searchController = TextEditingController();
    return Stack(
      children: [
        Consumer<AppStringService>(
          builder: (context, asProvider, child) => Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                TextFormField(
                  controller: sfm.searchTextController,
                  decoration: const InputDecoration(
                    hintText: 'Search',
                  ),
                  onChanged: (text) {
                    sfm.timer?.cancel();
                    sfm.timer = Timer(const Duration(seconds: 1), () {
                      Provider.of<FilterServicesService>(context, listen: false)
                          .setSearchText(text);
                    });
                  },
                ).hp20,
                12.toHeight,
                Card(
                  surfaceTintColor: cc.black9,
                  color: cc.black9,
                  child: Row(
                    children: [
                      FilterIconButton(
                        onPressed: () {
                          sfm.setNFilters(context);
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return const FilterSheet();
                            },
                          );
                        },
                        icon: "filter",
                        subtitle: "Filter",
                      ),
                      FilterIconButton(
                          subtitle: "Location",
                          icon: "location",
                          onPressed: () {
                            sfm.setLFilters(context);
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return const LocationSheet();
                              },
                            );
                          }),
                      FilterIconButton(
                          subtitle: "Category",
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
                        subtitle: "Reset",
                        onPressed: () {
                          Provider.of<FilterServicesService>(context,
                                  listen: false)
                              .resetFilters();
                          sfm.searchTextController.text = "";
                        },
                        icon: "refresh",
                      ),
                    ],
                  ),
                ).hp20,
                //Country state
                // Row(
                //   children: [
                //     Expanded(
                //       flex: 1,
                //       child: CountryDropdown(
                //         textWidth: MediaQuery.of(context).size.width / 3.6,
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 10,
                //     ),
                //     Expanded(
                //         flex: 1,
                //         child: StateDropdown(
                //           textWidth: MediaQuery.of(context).size.width / 3.6,
                //         ))
                //   ],
                // ),

                // //Area, online/offline
                // sizedBoxCustom(15),
                // const Row(
                //   children: [
                //     // const Expanded(
                //     //   child: AreaDropdown(),
                //     // ),
                //     // const SizedBox(
                //     //   width: 10,
                //     // ),
                //     Expanded(child: OnlineOfflineDropdown())
                //   ],
                // ),

                //Services
                Consumer<FilterServicesService>(
                    builder: (context, provider, child) {
                  return CustomFutureWidget(
                    shimmer: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: OthersHelper().showLoading(cc.primaryColor)),
                    isLoading: provider.searchLoading,
                    child: Expanded(
                      child: provider
                                  .serviceSearchModel.mainServices?.isEmpty ??
                              true
                          ? CommonHelper()
                              .nothingfound(context, "No results found")
                          : ListView.separated(
                              padding: const EdgeInsets.all(20),
                              itemBuilder: (context, i) {
                                return InkWell(
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
                                    Provider.of<ServiceDetailsService>(context,
                                            listen: false)
                                        .fetchServiceDetails(provider
                                            .serviceMap[i]['serviceId']);
                                  },
                                  child: ServiceCard(
                                    cc: cc,
                                    imageLink: provider.serviceMap[i]
                                            ['image'] ??
                                        placeHolderUrl,
                                    rating: twoDouble(
                                        provider.serviceMap[i]['rating']),
                                    title: provider.serviceMap[i]['title'],
                                    sellerName: provider.serviceMap[i]
                                        ['sellerName'],
                                    price: provider.serviceMap[i]['price'],
                                    buttonText: 'Book Now',
                                    width: double.infinity,
                                    marginRight: 0.0,
                                    pressed: () {
                                      provider.saveOrUnsave(
                                          provider.serviceMap[i]['serviceId'],
                                          provider.serviceMap[i]['title'],
                                          provider.serviceMap[i]['image'],
                                          provider.serviceMap[i]['price']
                                              .round(),
                                          provider.serviceMap[i]['sellerName'],
                                          twoDouble(
                                              provider.serviceMap[i]['rating']),
                                          i,
                                          context,
                                          provider.serviceMap[i]['sellerId']);
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
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => 16.toHeight,
                              itemCount: provider.serviceMap.length),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),

        // const LocationSheet(),
      ],
    );
  }
}
