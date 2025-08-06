import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/model/navigationModel.dart';
import 'package:qixer/service/filter_services_service.dart';
import 'package:qixer/view/home/components/service_card.dart';
import 'package:qixer/view/services/service_details_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../helper/contactFeatures.dart';
import '../../service/common_service.dart';
import '../../service/service_details_service.dart';

class ServiceByLocation extends StatefulWidget {
  final NavigationModel? navigationModel;
  const ServiceByLocation({super.key, this.navigationModel});

  @override
  State<ServiceByLocation> createState() => _ServiceByLocationState();
}

class _ServiceByLocationState extends State<ServiceByLocation> {
  ConstantColors cc = ConstantColors();

  firstLoad() async {
    final filterServiceController =
        Provider.of<FilterServicesService>(context, listen: false);
    if (mounted) {
      filterServiceController.fetchServices();
    }
  }

  @override
  void initState() {
    firstLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterServicesService>(
      builder: (context, fsProvider, child) {
        return SafeArea(
          child: Scaffold(
            appBar: CommonHelper().appbarCommon(
                "Service Location : ${widget.navigationModel?.pageName.toString() ?? ''}",
                context,
                () => Navigator.pop(context)),
            body: fsProvider.searchLoading
                ? OthersHelper().showLoading(cc.primaryColor)
                : fsProvider.serviceMap.length != 0
                    ? ListView.builder(
                        itemCount: fsProvider.serviceMap.length,
                        itemBuilder: (context, index) {
                          final service = fsProvider.serviceMap[index];
                          var serviceAreaList =
                              fsProvider.serviceMap[index]["serviceArea"];
                          var areas = (serviceAreaList != null &&
                                  serviceAreaList.isNotEmpty)
                              ? serviceAreaList.join(", ")
                              : "NA"; // Default message when empty
                          print("area==> $areas");
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
                                    Provider.of<ServiceDetailsService>(context,
                                            listen: false)
                                        .fetchServiceDetails(fsProvider
                                            .serviceMap[index]['serviceId']);
                                  },
                                  child: ServiceCard(
                                    cc: cc,
                                    imageLink: fsProvider.serviceMap[index]
                                            ['businessImage'] ??
                                        placeHolderUrl,
                                    rating: twoDouble(
                                        fsProvider.serviceMap[index]['rating']),
                                    title: fsProvider.serviceMap[index]
                                        ['title'],
                                    sellerName: fsProvider.serviceMap[index]
                                        ['businessName'],
                                    price: fsProvider.serviceMap[index]
                                        ['price'],
                                    buttonText: 'Enquiry Now',
                                    width: double.infinity,
                                    marginRight: 5.0,
                                    pressed: () {
                                      fsProvider.saveOrUnsave(
                                        fsProvider.serviceMap[index]
                                            ['serviceId'],
                                        fsProvider.serviceMap[index]['title'],
                                        fsProvider.serviceMap[index]['image'],
                                        fsProvider.serviceMap[index]['price']
                                            .round(),
                                        fsProvider.serviceMap[index]
                                            ['businessName'],
                                        twoDouble(fsProvider.serviceMap[index]
                                            ['rating']),
                                        index,
                                        context,
                                        fsProvider.serviceMap[index]
                                            ['sellerId'],
                                        fsProvider.serviceMap[index]
                                            ['experience'],
                                      );
                                    },
                                    isSaved: fsProvider.serviceMap[index]
                                                ['isSaved'] ==
                                            true
                                        ? true
                                        : false,
                                    serviceId: fsProvider.serviceMap[index]
                                        ['serviceId'],
                                    sellerId: fsProvider.serviceMap[index]
                                        ['sellerId'],
                                    cardFrom: 'Home',
                                    address: areas,
                                    experience: fsProvider.serviceMap[index]
                                                ['experience'] ==
                                            null
                                        ? ''
                                        : (RegExp(r'^\d+$').hasMatch(fsProvider
                                                .serviceMap[index]['experience']
                                                .toString())
                                            ? "${fsProvider.serviceMap[index]['experience']} year"
                                            : "${fsProvider.serviceMap[index]['experience']}"),
                                    status: fsProvider.serviceMap[index]
                                            ['status']
                                        .toString(),
                                    onTapCall: () {
                                      ContactFeatures().launchCalling(
                                          context,
                                          fsProvider.serviceMap[index]
                                              ['callNumber']);
                                      print(
                                          "on Tap Call ====> ${fsProvider.serviceMap[index]['callNumber']}");
                                    },
                                    onTapWhatsapp: () {
                                      ContactFeatures().launchWhatsapp(
                                          context,
                                          fsProvider.serviceMap[index]
                                              ['callNumber'],
                                          "${AppLocalizations.of(context)!.whatsappContactMsg} *${fsProvider.serviceMap[index]['title']}*.");
                                      print(
                                          "on Tap Whatsapp ====> ${fsProvider.serviceMap[index]['callNumber']}");
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
                      )
                    : Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          "No Service Availiable Here",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
          ),
        );
      },
    );
  }
}
