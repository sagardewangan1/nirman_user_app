import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/model/navigationModel.dart';
import 'package:qixer/service/addServiceProvider/addServicerProvider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/home_services/category_service.dart';
import 'package:qixer/service/jobs_service/recent_jobs_service.dart';
import 'package:qixer/service/vendorDashboardService/vendorDashboardService.dart';
import 'package:qixer/view/VenderDashBoard/VenderDashBoardView.dart';
import 'package:qixer/view/VenderDashBoard/allVendorServiceList/components/myServiceCard.dart';
import 'package:qixer/view/addService/addServiceView.dart';
import 'package:qixer/view/chooseCategory/chooseCategorView.dart';
import 'package:qixer/view/tabs/settings/settings_helper.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/custom_input%20copy.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qixer/generated/app_localizations.dart';

class AllVendroServiceList extends StatefulWidget {
  const AllVendroServiceList({super.key});

  @override
  State<AllVendroServiceList> createState() => _AllVendroServiceListState();
}

class _AllVendroServiceListState extends State<AllVendroServiceList> {
  ConstantColors cc = ConstantColors();
  final TextEditingController _searchController = TextEditingController();

  firstLoad() async {
    final vendorServiceController =
        Provider.of<VendorDashboardService>(context, listen: false);
    if (mounted) {
      await vendorServiceController.getMyServiceLists();
      debugPrint(
          "areas===> ${vendorServiceController.myServiceListDataModel.myServices?.map((service) => service.serviceArea?.map((area) => area.id).toList()).toList()}");
    }
  }

  @override
  void initState() {
    firstLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<AppStringService>(
      builder: (context, asProvider, child) {
        return PopScope(
          canPop: true,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) {
              context.read<RecentJobsService>().selectedCityIds.clear();
              // No need to call Navigator.pop(context) here since the pop has already occurred
            } else {
              // Handle the case where the pop was not successful, if necessary
            }
          },
          child: Scaffold(
              appBar: CommonHelper().appbarCommon(
                AppLocalizations.of(context)!.myServices,
                context,
                () {
                  context.read<RecentJobsService>().selectedCityIds.clear();
                  Navigator.pop(context);
                },
              ),
              body: SafeArea(
                child: Consumer<VendorDashboardService>(
                  builder: (context, vendorProvider, child) {
                    return vendorProvider.isLoading
                        ? Center(
                            child: OthersHelper().showLoading(cc.primaryColor))
                        : vendorProvider.myServiceListDataModel.myServices
                                    ?.length !=
                                0
                            ? ListView.builder(
                                itemCount: vendorProvider
                                    .myServiceListDataModel.myServices?.length,
                                itemBuilder: (context, index) {
                                  final service = vendorProvider
                                      .myServiceListDataModel
                                      .myServices?[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 5.0),
                                    child: MyServiceCard(
                                      featureImage: service
                                              ?.seller?.businessImage?.imgUrl ??
                                          placeHolderUrl,
                                      serviceName: service?.title ?? '',
                                      category:
                                          service?.category?.name.toString() ??
                                              '',
                                      subCategory: service?.subcategory?.name
                                              .toString() ??
                                          '',
                                      createdDate: DateTime.now().toString(),
                                      isActive:
                                          service?.status == 0 ? false : true,
                                      onEdit: () async {
                                        final pref = await SharedPreferences
                                            .getInstance();
                                        if (mounted) {
                                          editServiceBottomSheet(
                                              context, _searchController,
                                              serviceId:
                                                  service?.id.toString());
                                        }
                                      },
                                      onDelete: () {
                                        SettingsHelper()
                                            .deleteServicePopup(
                                                context, service?.id.toString())
                                            .then(
                                          (value) {
                                            if (value) {
                                              firstLoad();
                                            }
                                          },
                                        );
                                      },
                                      onToggleActive: () {
                                        // print("${service.isActive ? 'Deactivate' : 'Activate'} ${service.serviceName}");
                                      },
                                    ),
                                  );
                                },
                              )
                            : Container(
                                alignment: Alignment.center,
                                height: screenHeight - 140,
                                child: Image.asset(
                                  "assets/images/nodata.png",
                                  fit: BoxFit.contain,
                                ),
                              );
                  },
                ),
              )),
        );
      },
    );
  }

  Future<dynamic> editServiceBottomSheet(
      BuildContext context, TextEditingController searchController,
      {String? serviceId}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows full-screen draggable behavior
      backgroundColor: Colors.transparent, // Matches Instagram style
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.2,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  // Drag handle for better UX
                  Container(
                    width: 40,
                    height: 5,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomInput(
                      controller: searchController,
                      color: cc.white,
                      hintText: AppLocalizations.of(context)!.searchCity,
                      onChanged: (p0) {
                        context.read<RecentJobsService>().filterCities(p0);
                      },
                      iconSuffix: "assets/icons/closeIcon.png",
                      onTapSuffix: () {
                        searchController.clear();
                        context.read<RecentJobsService>().filterCities('');
                      },
                    ),
                  ),
                  Expanded(
                    child: AreSelectBottomSheet(
                      context: context,
                      cc: cc,
                      scrollController: scrollController,
                      serviceId: int.parse(serviceId.toString()),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: CommonHelper().buttonOrange(
                      paddingVerticle: 15,
                      AppLocalizations.of(context)!.updateService,
                      () {
                        var body = {
                          'service_id': serviceId.toString(),
                          'service_area_id':
                              "[${context.read<RecentJobsService>().selectedCityIds.map((e) => '"$e"').join(",")}]"
                        };
                        context
                            .read<CategoryService>()
                            .updateServiceByCategory(
                              context,
                              body,
                            )
                            .then(
                          (value) {
                            if (value == true) {
                              firstLoad();
                              Navigator.pop(context);
                            } else {
                              OthersHelper().toastShort(
                                  AppLocalizations.of(context)!
                                      .failedUpdateService,
                                  cc.errorColor);
                            }
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class AreSelectBottomSheet extends StatefulWidget {
  final BuildContext context;
  final ConstantColors cc;
  final ScrollController scrollController;
  final int? serviceId;
  const AreSelectBottomSheet(
      {super.key,
      required this.context,
      required this.cc,
      required this.scrollController,
      this.serviceId});

  @override
  State<AreSelectBottomSheet> createState() => _AreSelectBottomSheetState();
}

class _AreSelectBottomSheetState extends State<AreSelectBottomSheet> {
  void autoSelectServiceAreas(int serviceId) {
    final vendorDashboardService = context.read<VendorDashboardService>();

    // Get services that match the given serviceId
    final filteredServices = vendorDashboardService
        .myServiceListDataModel.myServices
        ?.where((service) => service.id == serviceId)
        .toList();

    final selectedServiceAreaIds = filteredServices
            ?.expand((service) =>
                service.serviceArea ?? []) // Extract serviceArea list
            .map((area) => area.id) // Extract only the IDs
            .toSet() ??
        {};

    debugPrint("🔥 Service ID: $serviceId");
    debugPrint("✅ Selected Service Area IDs: $selectedServiceAreaIds");

    if (selectedServiceAreaIds.isNotEmpty) {
      final recentJobService = context.read<RecentJobsService>();
      recentJobService.selectedCityIds.clear(); // 🔥 Yeh line fix karega!
      for (var id in selectedServiceAreaIds) {
        debugPrint("🔹 Adding City ID: $id"); // ✅ Debugging line
        recentJobService.addCitySelection(id);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      autoSelectServiceAreas(widget.serviceId ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final recentJobService = Provider.of<RecentJobsService>(context);
    return ListView.builder(
      controller: widget.scrollController,
      itemCount: recentJobService.filteredCities.length,
      itemBuilder: (context, index) {
        final cities = recentJobService.filteredCities[index];
        return InkWell(
          onTap: () {
            recentJobService.toggleCitySelection(cities.id!);
          },
          child: Row(
            children: [
              Checkbox(
                value: recentJobService.isCitySelected(cities.id!),
                onChanged: (value) {
                  recentJobService.toggleCitySelection(cities.id!);
                },
              ),
              Gap(10),
              Text("${cities.serviceArea}")
            ],
          ),
        );
      },
    );
  }
}
