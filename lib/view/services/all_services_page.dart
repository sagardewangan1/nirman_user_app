import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qixer/helper/contactFeatures.dart';
import 'package:qixer/service/all_services_service.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/service_details_service.dart';
import 'package:qixer/view/services/components/service_filter_dropdowns.dart';
import 'package:qixer/view/services/service_details_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';

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
    Provider.of<AllServicesService>(context, listen: false)
        .fetchCategories(context);
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonHelper().appbarCommon('All Services', context, () {
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
                  .fetchServiceByFilter(context);
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result =
              await Provider.of<AllServicesService>(context, listen: false)
                  .fetchServiceByFilter(context);
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
                  const SizedBox(height: 14),

                  /// **Dropdown Filters**
                  const ServiceFilterDropdowns(),

                  /// **Service List**
                  !provider.isLoading
                      ? provider.serviceMap.isEmpty
                          ? Center(
                              child: Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: Text(
                                  "No result found",
                                  style: TextStyle(color: cc.greyPrimary),
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 35),
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: provider.serviceMap.length,
                                itemBuilder: (context, i) {
                                  final service = provider.serviceMap[i];
                                  var serviceAreaList =
                                      provider.serviceMap[i]["serviceArea"];
                                  var areas = (serviceAreaList != null &&
                                          serviceAreaList.isNotEmpty)
                                      ? serviceAreaList.join(", ")
                                      : "NA"; // Default message when empty

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
                                          imageLink: service['image'] ??
                                              placeHolderUrl,
                                          rating: twoDouble(service['rating']),
                                          title: service['title'],
                                          sellerName: service['sellerName'],
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
                                          cardFrom: 'Home',
                                          address: areas,
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
                                          status: provider.serviceMap[i]
                                                  ['status']
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
                                                "Hello Sir,How can i help you ?");
                                            print(
                                                "on Tap Whatsapp ====> ${provider.serviceMap[i]['callNumber']}");
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 25),
                                    ],
                                  );
                                },
                              ),
                            )
                      : Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 60),
                          child: OthersHelper().showLoading(cc.primaryColor),
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
