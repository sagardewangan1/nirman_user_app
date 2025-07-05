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
import 'package:qixer/view/services/service_details_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../service/common_service.dart';
import '../../service/service_details_service.dart';
import '../home/components/service_card.dart';
import '../search/service_filter_model.dart';
import '../utils/constant_colors.dart';
import '../utils/others_helper.dart';
import '../utils/responsive.dart';

class AllServicePage extends StatefulWidget {
  const AllServicePage({super.key});

  @override
  State<AllServicePage> createState() => _AllServicePageState();
}

class _AllServicePageState extends State<AllServicePage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<AllServicesService>(context, listen: false).resetFilters();
      await Provider.of<AllServicesService>(context, listen: false)
          .fetchAllService(context);
    });
  }

  Future<void> _onRefresh() async {
    // Reset filters and fetch fresh data
    Provider.of<AllServicesService>(context, listen: false).resetFilters();
    final success =
        await Provider.of<AllServicesService>(context, listen: false)
            .fetchAllService(context, isRefresh: true);

    if (success) {
      _refreshController.refreshCompleted();
    } else {
      _refreshController.refreshFailed();
      // You could show a snackbar with error message here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to refresh data')),
      );
    }
  }

  Future<void> _onLoading() async {
    final success =
        await Provider.of<AllServicesService>(context, listen: false)
            .fetchAllService(context, isRefresh: false);

    if (success) {
      _refreshController.loadComplete();
    } else {
      _refreshController.loadFailed();
      // Optionally show a snackbar with an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No more data here')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final allServiceController =
        Provider.of<AllServicesService>(context, listen: false);
    ConstantColors cc = ConstantColors();
    final sfm = ServiceFilterViewModel.instance;
    return Scaffold(
      appBar: CommonHelper()
          .appbarCommon(AppLocalizations.of(context)!.allServices, context, () {
        Navigator.pop(context);
      }),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        enablePullDown: true,
        enablePullUp: true,
        header: ClassicHeader(
          completeText: 'Refresh completed',
          refreshingText: 'Refreshing...',
          idleText: 'Pull down to refresh',
          releaseText: 'Release to refresh',
        ),
        onLoading: _onLoading,
        footer: ClassicFooter(
          loadingText: 'Loading more...',
          noDataText: 'No more data',
          idleText: 'Pull up to load more',
          canLoadingText: 'Release to load more',
        ),
        child: allServiceController.isLoading
            ? Center(
                child: OthersHelper().showLoading(cc.primaryColor),
              )
            : SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Consumer<AllServicesService>(
                    builder: (context, provider, child) => Column(
                      children: [
                        12.toHeight,
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: cc.white,
                            ),
                            child: TextFormField(
                              controller: sfm.searchTextController,
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)!.search,
                              ),
                              onChanged: (text) {
                                sfm.timer?.cancel();
                                sfm.timer =
                                    Timer(const Duration(seconds: 1), () {
                                  final provider =
                                      Provider.of<AllServicesService>(context,
                                          listen: false);
                                  provider.setSearch(context, text);
                                  provider.fetchAllService(context,
                                      isRefresh:
                                          true); // 🔹 Search ke sath API call
                                });
                              },
                            )).hp20,
                        12.toHeight,
                        !provider.isLoading
                            ? provider.serviceMap.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: provider.serviceMap.length,
                                      itemBuilder: (context, i) {
                                        final service = provider.serviceMap[i];
                                        var serviceAreaList =
                                            service["serviceArea"];
                                        var areas = (serviceAreaList != null &&
                                                serviceAreaList.isNotEmpty)
                                            ? serviceAreaList.join(", ")
                                            : ""; // Default message when empty
                                        return Column(
                                          children: [
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute<void>(
                                                    builder: (BuildContext
                                                            context) =>
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
                                                imageLink:
                                                    service['businessImage'] ??
                                                        placeHolderUrl,
                                                rating: twoDouble(
                                                    service['rating']),
                                                title: service['title'],
                                                sellerName:
                                                    service['sellerName'],
                                                price: service['price'],
                                                buttonText: AppLocalizations.of(
                                                        context)!
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
                                                    twoDouble(
                                                        service['rating']),
                                                    i,
                                                    context,
                                                    service['sellerId'],
                                                    service['experience'] ?? '',
                                                  );
                                                },
                                                isSaved:
                                                    service['isSaved'] == true,
                                                serviceId: service['serviceId'],
                                                sellerId: service['sellerId'],
                                                cardFrom: 'Home',
                                                address: areas
                                                    .toString()
                                                    .capitalizeWords,
                                                experience: service[
                                                            'experience'] ==
                                                        null
                                                    ? ''
                                                    : (RegExp(r'^\d+$')
                                                            .hasMatch(service[
                                                                    'experience']
                                                                .toString())
                                                        ? "${service['experience']} year"
                                                        : "${service['experience']}"),
                                                status: service['status']
                                                    .toString(),
                                                onTapCall: () {
                                                  ContactFeatures()
                                                      .launchCalling(
                                                          context,
                                                          service[
                                                              'callNumber']);
                                                },
                                                onTapWhatsapp: () {
                                                  ContactFeatures().launchWhatsapp(
                                                      context,
                                                      service['callNumber'],
                                                      "${AppLocalizations.of(context)!.whatsappContactMsg} *${service['title']}*.");
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
