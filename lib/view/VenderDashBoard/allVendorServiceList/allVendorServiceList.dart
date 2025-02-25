import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/model/navigationModel.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/vendorDashboardService/vendorDashboardService.dart';
import 'package:qixer/view/VenderDashBoard/VenderDashBoardView.dart';
import 'package:qixer/view/VenderDashBoard/allVendorServiceList/components/myServiceCard.dart';
import 'package:qixer/view/addService/addServiceView.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllVendroServiceList extends StatefulWidget {
  const AllVendroServiceList({super.key});

  @override
  State<AllVendroServiceList> createState() => _AllVendroServiceListState();
}

class _AllVendroServiceListState extends State<AllVendroServiceList> {
  ConstantColors cc = ConstantColors();

  // final List<Map<String, dynamic>> sampleServices = [
  //   {
  //     "featureImage": "https://via.placeholder.com/150",
  //     "serviceName": "Plumbing Services",
  //     "category": "Home Repair",
  //     "subCategory": "Plumbing",
  //     "createdDate": "2025-01-20",
  //     "isActive": true,
  //   },
  //   {
  //     "featureImage": "https://via.placeholder.com/150",
  //     "serviceName": "Electrical Maintenance",
  //     "category": "Home Repair",
  //     "subCategory": "Electrical",
  //     "createdDate": "2025-01-18",
  //     "isActive": false,
  //   },
  //   {
  //     "featureImage": "https://via.placeholder.com/150",
  //     "serviceName": "Carpentry Work",
  //     "category": "Furniture",
  //     "subCategory": "Woodwork",
  //     "createdDate": "2025-01-15",
  //     "isActive": true,
  //   },
  //   {
  //     "featureImage": "https://via.placeholder.com/150",
  //     "serviceName": "Cleaning Services",
  //     "category": "Home Services",
  //     "subCategory": "Cleaning",
  //     "createdDate": "2025-01-12",
  //     "isActive": true,
  //   },
  //   {
  //     "featureImage": "https://via.placeholder.com/150",
  //     "serviceName": "Pest Control",
  //     "category": "Home Services",
  //     "subCategory": "Pest Control",
  //     "createdDate": "2025-01-10",
  //     "isActive": false,
  //   },
  // ];

  firstLoad() async {
    final vendorServiceController =
        Provider.of<VendorDashboardService>(context, listen: false);
    if (mounted) {
      await vendorServiceController.getMyServiceLists();
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
        return Scaffold(
            appBar: CommonHelper().appbarCommon(
              "My Services",
              context,
              () => Navigator.pop(context),
            ),
            body: Consumer<VendorDashboardService>(
              builder: (context, vendorProvider, child) {
                return Stack(
                  children: [
                    vendorProvider.myServiceListDataModel.myServices?.length !=
                            0
                        ? ListView.builder(
                            itemCount: vendorProvider
                                .myServiceListDataModel.myServices?.length,
                            itemBuilder: (context, index) {
                              final service = vendorProvider
                                  .myServiceListDataModel.myServices?[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 5.0),
                                child: MyServiceCard(
                                  featureImage: service?.image?.imgUrl ??
                                      "https://i.postimg.cc/zDRKCz4J/dd.jpg",
                                  serviceName: service?.title ?? '',
                                  category:
                                      service?.category?.name.toString() ?? '',
                                  subCategory:
                                      service?.subcategory?.name.toString() ??
                                          '',
                                  createdDate: DateTime.now().toString(),
                                  isActive: service?.status == 0 ? false : true,
                                  onEdit: () async {
                                    final pref =
                                        await SharedPreferences.getInstance();
                                    if (mounted) {
                                      context.toPage(
                                        AddServiceView(
                                          navigationModel: NavigationModel(
                                            pageName: "Update Service",
                                            navFrom: "Dashboard",
                                            roleType: "Vendor",
                                            isLoggedIn: pref.getBool(
                                                "shashaktnirman_is_logged_in"),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  onDelete: () {
                                    // print("Delete ${service.serviceName}");
                                  },
                                  onToggleActive: () {
                                    // print("${service.isActive ? 'Deactivate' : 'Activate'} ${service.serviceName}");
                                  },
                                ),
                              );
                            },
                          )
                        : Offstage(),
                    vendorProvider.isLoading
                        ? Center(
                            child: OthersHelper().showLoading(cc.primaryColor))
                        : Offstage(),
                  ],
                );
              },
            ));
      },
    );
  }
}
