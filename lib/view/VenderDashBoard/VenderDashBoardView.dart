import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/helper/extension/string_extension.dart';
import 'package:qixer/model/navigationModel.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/service/vendorDashboardService/vendorDashboardService.dart';
import 'package:qixer/view/VenderDashBoard/AddRequestForPoster.dart';
import 'package:qixer/view/VenderDashBoard/allVendorServiceList/allVendorServiceList.dart';
import 'package:qixer/view/VenderDashBoard/subscriptionModule.dart';
import 'package:qixer/view/chooseCategory/chooseCategorView.dart';
import 'package:qixer/view/home/landing_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qixer/generated/app_localizations.dart';

class VendorDashBoardVies extends StatefulWidget {
  final NavigationModel? navigationModel;
  const VendorDashBoardVies({super.key, this.navigationModel});

  @override
  State<VendorDashBoardVies> createState() => _VendorDashBoardViesState();
}

class _VendorDashBoardViesState extends State<VendorDashBoardVies> {
  ConstantColors cc = ConstantColors();

  @override
  void initState() {
    firstLoad();
    super.initState();
  }

  String? userType;

  Future<void> firstLoad() async {
    final pref = await SharedPreferences.getInstance();
    userType = pref.getString('shashaktnirmanusertype') ?? '';

    final profileController =
        Provider.of<ProfileService>(context, listen: false);
    final vendorController =
        Provider.of<VendorDashboardService>(context, listen: false);
    final results = await Future.wait([
      profileController.getProfileDetails(
        isFromProfileupdatePage: true,
        context: context,
      ),
      vendorController.getSubscriptions(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // 🔹 Make background transparent
        statusBarIconBrightness: Brightness.light, // or Brightness.light
      ),
    );
    Size size = MediaQuery.of(context).size;
    final vendorDashboardController =
        Provider.of<VendorDashboardService>(context);
    return Consumer<AppStringService>(
      builder: (context, value, child) {
        return Consumer<ProfileService>(
          builder: (context, profileController, child) {
            return WillPopScope(
              onWillPop: () async {
                if (widget.navigationModel?.navFrom == "Direct") {
                  context.toPage(LandingPage());
                } else {
                  Navigator.of(context).pop(true);
                }
                return true;
              },
              child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: CommonHelper().appbarCommon(
                    AppLocalizations.of(context)!.vendorDashboard,
                    context,
                    () {
                      if (widget.navigationModel?.navFrom == "Direct") {
                        context.toPage(LandingPage());
                      } else {
                        Navigator.of(context).pop(true);
                      }
                    },
                    //     actions: [
                    //   Padding(
                    //       padding: const EdgeInsets.only(right: 8.0),
                    //       child: Badge(
                    //         label: Text(
                    //           "5",
                    //           style: TextStyle(
                    //               fontWeight: FontWeight.w400, fontSize: 8),
                    //         ),
                    //         child: Icon(
                    //           Icons.notifications_outlined,
                    //           size: 22,
                    //         ),
                    //       )),
                    // ]
                  ),
                  body: SafeArea(
                    child: ListView(
                      children: [
                        // Consumer<ProfileService>(builder: (context, profileProvider, child) {
                        //   return Container(
                        //     decoration: BoxDecoration(
                        //       color: cc.primaryColor.withOpacity(0.2),
                        //     ),
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: Row(
                        //         children: [
                        //           CircleAvatar(
                        //             backgroundColor: Colors.black,
                        //             radius: 19,
                        //             child: ClipOval(
                        //               child: CommonHelper().profileImage(
                        //                   "https://static.vecteezy.com/system/resources/previews/000/590/446/non_2x/tick-logo-design-is-on-the-stage-for-your-business-or-brand-vector.jpg",
                        //                   35,
                        //                   35),
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             width: 10,
                        //           ),
                        //           Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: [
                        //               Text(
                        //                 "Surya Ferm",
                        //                 style: TextStyle(
                        //                     fontSize: 16,
                        //                     fontWeight: FontWeight.w500),
                        //               ),
                        //               Text(
                        //                 "7869308928",
                        //                 style: TextStyle(
                        //                     fontSize: 13,
                        //                     fontWeight: FontWeight.w400),
                        //               ),
                        //             ],
                        //           ),
                        //           // Spacer(),
                        //           // Icon(Icons.arrow_forward_ios),
                        //         ],
                        //       ),
                        //     ),
                        //   );
                        // },),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CommonHelper().profileImage(
                                profileController.businessProfile ?? '',
                                150,
                                150),
                            Gap(15),
                            Text(
                              profileController
                                      .profileDetails?.userDetails?.businessName
                                      .toString()
                                      .capitalizeWords ??
                                  "N/A",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     buildCustomCard(
                              //       size: size,
                              //       gradientColors: [
                              //         Colors.teal.shade300,
                              //         Colors.cyan.shade400
                              //       ],
                              //       icon: Icons.miscellaneous_services,
                              //       iconColor: Colors.teal.shade300,
                              //       iconBgColor: Colors.white,
                              //       title: "50",
                              //       subtitle: "Total Services",
                              //     ),
                              //     buildCustomCard(
                              //       size: size,
                              //       gradientColors: [
                              //         Colors.red.shade200,
                              //         Colors.red.shade400
                              //       ],
                              //       icon: Icons.leaderboard,
                              //       iconColor: Colors.red.shade400,
                              //       iconBgColor: cc.white,
                              //       title: "50",
                              //       subtitle: "Leads Generated",
                              //       onTap: () => context.toPage(LeadsView()),
                              //     ),
                              //   ],
                              // ),
                              // SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  buildCustomCard(
                                    onTap: () =>
                                        context.toPage(AllVendroServiceList()),
                                    size: size,
                                    gradientColors: [
                                      Color(0xffFF6B2C),
                                      Color(0xffffa500)
                                    ],
                                    icon: Icons.miscellaneous_services,
                                    iconColor: Color(0xffffa500),
                                    iconBgColor: cc.white,
                                    title: AppLocalizations.of(context)!
                                        .myServices,
                                  ),
                                  buildCustomCard(
                                    onTap: () =>
                                        context.toPage(SubscriptionModule()),
                                    size: size,
                                    gradientColors: [
                                      Color(0xffFF6B2C),
                                      Color(0xffffa500)
                                    ],
                                    icon: Icons.subscriptions,
                                    iconColor: Color(0xffffa500),
                                    iconBgColor: cc.white,
                                    title: AppLocalizations.of(context)!
                                        .subscriptions,
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  buildCustomCard(
                                    onTap: () {
                                      context.toPage(
                                        ChooseCategoryView(
                                            navigationModel: NavigationModel(
                                          navFrom: "Dashboard",
                                          roleType: "Vendor",
                                          pageName:
                                              AppLocalizations.of(context)!
                                                  .addService,
                                        )),
                                      );
                                    },
                                    size: size,
                                    gradientColors: [
                                      Color(0xffFF6B2C),
                                      Color(0xffffa500)
                                    ],
                                    icon: Icons.category,
                                    iconColor: Color(0xffffa500),
                                    iconBgColor: cc.white,
                                    title: AppLocalizations.of(context)!
                                        .addService,
                                  ),
                                  buildCustomCard(
                                    onTap: () {
                                      context.toPage(AddRequestForPosterAdd());
                                    },
                                    size: size,
                                    gradientColors: [
                                      Color(0xffFF6B2C),
                                      Color(0xffffa500)
                                    ],
                                    icon: Icons.signpost_rounded,
                                    iconColor: Color(0xffffa500),
                                    iconBgColor: cc.white,
                                    title:
                                        AppLocalizations.of(context)!.promotion,
                                  ),
                                  // buildCustomCard(
                                  //   onTap: () async {
                                  //     final pref =
                                  //         await SharedPreferences.getInstance();
                                  //     context.toPage(AddServiceView(
                                  //       navigationModel: NavigationModel(
                                  //         isLoggedIn: pref.getBool(
                                  //             "shashaktnirman_is_logged_in"),
                                  //         navFrom: "Dashboard",
                                  //         roleType: "Vendor",
                                  //         pageName: AppLocalizations.of(context)!
                                  //             .addService,
                                  //       ),
                                  //     ));
                                  //   },
                                  //   size: size,
                                  //   gradientColors: [
                                  //     Color(0xffFF6B2C),
                                  //     Color(0xffffa500)
                                  //   ],
                                  //   icon: Icons.miscellaneous_services,
                                  //   iconColor: Color(0xffffa500),
                                  //   iconBgColor: cc.white,
                                  //   title:
                                  //       AppLocalizations.of(context)!.addService,
                                  // ),
                                ],
                              ),
                              SizedBox(height: 15),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     buildCustomCard(
                              //       onTap: () {
                              //         context.toPage(AddRequestForPosterAdd());
                              //       },
                              //       size: size,
                              //       gradientColors: [
                              //         Color(0xffFF6B2C),
                              //         Color(0xffffa500)
                              //       ],
                              //       icon: Icons.signpost_rounded,
                              //       iconColor: Color(0xffffa500),
                              //       iconBgColor: cc.white,
                              //       title:
                              //           AppLocalizations.of(context)!.promotion,
                              //     ),
                              //   ],
                              // ),

                              // SizedBox(height: 15),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     buildCustomCard(
                              //       onTap: () {
                              //         context.toPage(CreateSchedule());
                              //       },
                              //       size: size,
                              //       gradientColors: [
                              //         Colors.purple.shade200,
                              //         Colors.pink.shade400
                              //       ],
                              //       icon: Icons.schedule,
                              //       iconColor: Colors.pink.shade400,
                              //       iconBgColor: cc.white,
                              //       title: "Create Opening Schedule",
                              //     ),
                              //     buildCustomCard(
                              //       onTap: () => context.toPage(HelpSupport()),
                              //       size: size,
                              //       gradientColors: [
                              //         Colors.tealAccent.shade200,
                              //         Colors.teal.shade400
                              //       ],
                              //       icon: Icons.support,
                              //       iconColor: Colors.teal.shade400,
                              //       iconBgColor: cc.white,
                              //       title: "Help & Support",
                              //     ),
                              //   ],
                              // ),
                              vendorDashboardController.isLoading
                                  ? Padding(
                                      padding: EdgeInsets.only(top: 50),
                                      child: OthersHelper()
                                          .showLoading(cc.primaryColor),
                                    )
                                  : vendorDashboardController.isSubscribed ==
                                          true
                                      ? Offstage()
                                      : InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SubscriptionModule(
                                                    navFrom: "Dashboard",
                                                  ),
                                                ));
                                          },
                                          child: SizedBox(
                                              height: 150,
                                              width: double.infinity,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      "https://sashaktnirmaan.com/assets/subscription.gif",
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                  fit: BoxFit.cover,
                                                ),
                                              )),
                                        )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            );
          },
        );
      },
    );
  }

  // Helper Method
  Widget buildCustomCard({
    required Size size,
    required List<Color> gradientColors,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size.height * 0.15,
        width: size.height * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: iconBgColor,
              child: Icon(icon, color: iconColor),
            ),
            SizedBox(height: 8),
            Text(
              textAlign: TextAlign.center,
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: cc.white,
              ),
            ),
            if (subtitle != null) ...[
              SizedBox(height: 4),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
