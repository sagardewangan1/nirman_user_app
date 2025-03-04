import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qixer/helper/contactFeatures.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/service_details_service.dart';
import 'package:qixer/service/serviceby_category_service.dart';
import 'package:qixer/view/services/service_details_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';

import '../home/components/service_card.dart';

class ServiceCategoryPage extends StatelessWidget {
  ServiceCategoryPage(
      {super.key,
      this.categoryName = '',
      required this.categoryId,
      this.subCatId});

  final String categoryName;
  final dynamic categoryId;
  final dynamic subCatId;

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    final sbcProvider =
        Provider.of<ServiceByCategoryService>(context, listen: false);
    debugPrint("page auto loading");
    ConstantColors cc = ConstantColors();

    return Scaffold(
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
          final result = await sbcProvider.fetchServiceBySubCateId(
              context, categoryId, subCatId);
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result = await sbcProvider.fetchServiceBySubCateId(
              context, categoryId, subCatId);
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
        child: WillPopScope(
          onWillPop: () {
            sbcProvider.setEverythingToDefault();
            return Future.value(true);
          },
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Consumer<ServiceByCategoryService>(
                builder: (context, provider, child) => Column(
                  children: [
                    /// **Service List**
                    !provider.hasError
                        ? provider.serviceMap.isNotEmpty
                            ? ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: provider.serviceMap.length,
                                itemBuilder: (context, i) {
                                  final service = provider.serviceMap[i];

                                  /// Extract service area names
                                  List<String> serviceAreas =
                                      (service["serviceArea"] != null &&
                                              service["serviceArea"].isNotEmpty)
                                          ? (service["serviceArea"]
                                                  as List<dynamic>)
                                              .map((area) => area.toString())
                                              .toList()
                                          : ["NA"];

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
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ServiceCard(
                                            cc: cc,
                                            imageLink: service['image'] ??
                                                placeHolderUrl,
                                            rating:
                                                twoDouble(service['rating']),
                                            title: service['title'],
                                            sellerName: service['name'],
                                            price: service['price'],
                                            buttonText: 'Book Now',
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
                                                service['experience'],
                                              );
                                            },
                                            isSaved: service['isSaved'] == true,
                                            serviceId: service['serviceId'],
                                            sellerId: service['sellerId'],
                                            address: serviceAreas.join(', '),
                                            experience: service['experience'] ==
                                                    null
                                                ? ''
                                                : (RegExp(r'^\d+$').hasMatch(
                                                        service['experience']
                                                            .toString())
                                                    ? "${service['experience']} year"
                                                    : "${service['experience']}"),
                                            status:
                                                service['status'].toString(),
                                            cardFrom: "Home",
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
                                                  "Hello Sir,How can i help you ?");
                                              print(
                                                  "on Tap Whatsapp ====> ${provider.serviceMap[i]['callNumber']}");
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              )
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
                          ),
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
