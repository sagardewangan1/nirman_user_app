import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/service_details_service.dart';
import 'package:qixer/service/serviceby_category_service.dart';
import 'package:qixer/view/services/service_details_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/custom_dropdown.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';

import '../home/components/service_card.dart';

class ServiceCategoryPage extends StatelessWidget {
  ServiceCategoryPage(
      {super.key, this.categoryName = '', required this.categoryId});

  final String categoryName;
  final dynamic categoryId;

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    final sbcProvider =
        Provider.of<ServiceByCategoryService>(context, listen: false);
    debugPrint("page auto loading".toString());
    ConstantColors cc = ConstantColors();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonHelper().appbarCommon(categoryName, context, () {
        sbcProvider.setEverythingToDefault();

        Navigator.pop(context);
      }),
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        enablePullDown:
            context.watch<ServiceByCategoryService>().currentPage > 1
                ? false
                : true,
        onRefresh: () async {
          final result =
              await sbcProvider.fetchCategoryService(context, categoryId);
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result =
              await sbcProvider.fetchCategoryService(context, categoryId);
          if (result) {
            debugPrint('loadcomplete ran');
            //loadcomplete function loads the data again
            refreshController.loadComplete();
          } else {
            debugPrint('no more data');
            refreshController.loadNoData();

            Future.delayed(const Duration(seconds: 1), () {
              //it will reset footer no data state to idle and will let us load again
              refreshController.resetNoData();
            });
          }
        },
        footer: OthersHelper().commonRefreshFooter(context),
        child: WillPopScope(
          onWillPop: () {
            sbcProvider.setEverythingToDefault();
            return Future.value(true);
          },
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Consumer<ServiceByCategoryService>(
                builder: (context, provider, child) => Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    CustomDropdown(
                      lnProvider.getString('Select Subcategory'),
                      provider.subCatList.map((e) => e.name).toList(),
                      (newValue) {
                        provider.selectSubCategory(
                            context, categoryId, newValue);
                      },
                      value: provider.selectedSubCat?.name,
                    ),
                    provider.hasError != true
                        ? provider.serviceMap.isNotEmpty
                            ? Column(children: [
                                // Service List ===============>

                                const SizedBox(
                                  height: 15,
                                ),
                                for (int i = 0;
                                    i < provider.serviceMap.length;
                                    i++)
                                  Column(
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
                                                  ['image'] ??
                                              placeHolderUrl,
                                          rating: twoDouble(
                                              provider.serviceMap[i]['rating']),
                                          title: provider.serviceMap[i]
                                              ['title'],
                                          sellerName: provider.serviceMap[i]
                                              ['sellerName'],
                                          price: provider.serviceMap[i]
                                              ['price'],
                                          buttonText: 'Book Now',
                                          width: double.infinity,
                                          marginRight: 0.0,
                                          pressed: () {
                                            provider.saveOrUnsave(
                                                provider.serviceMap[i]
                                                    ['serviceId'],
                                                provider.serviceMap[i]['title'],
                                                provider.serviceMap[i]['image'],
                                                provider.serviceMap[i]['price']
                                                    .round(),
                                                provider.serviceMap[i]
                                                    ['sellerName'],
                                                twoDouble(provider.serviceMap[i]
                                                    ['rating']),
                                                i,
                                                context,
                                                provider.serviceMap[i]
                                                    ['sellerId']);
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
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                    ],
                                  )
                              ])
                            : Container(
                                alignment: Alignment.center,
                                height: screenHeight - 140,
                                child:
                                    OthersHelper().showLoading(cc.primaryColor),
                              )
                        : Container(
                            alignment: Alignment.center,
                            height: screenHeight - 140,
                            child: Text(
                                lnProvider.getString("No service available")),
                          )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
