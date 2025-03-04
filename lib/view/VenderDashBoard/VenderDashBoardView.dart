import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/model/navigationModel.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/view/VenderDashBoard/AddRequestForPoster.dart';
import 'package:qixer/view/VenderDashBoard/allVendorServiceList/allVendorServiceList.dart';
import 'package:qixer/view/VenderDashBoard/createSchedule.dart';
import 'package:qixer/view/VenderDashBoard/helpSupport.dart';
import 'package:qixer/view/VenderDashBoard/subscriptionModule.dart';
import 'package:qixer/view/addService/addServiceView.dart';
import 'package:qixer/view/chooseCategory/chooseCategorView.dart';
import 'package:qixer/view/home/landing_page.dart';
import 'package:qixer/view/tabs/leads/leadsView.dart';
import 'package:qixer/view/tabs/settings/components/menu_name_image_section.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  String? businessName;
  String? businessNumber;
  String? userType;

  firstLoad() async {
    final pref = await SharedPreferences.getInstance();
    print("Business Info =====> $businessName and $businessNumber");
    ///////////////////////////////////////////////////////////////
    final profileController =
        Provider.of<ProfileService>(context, listen: false);
    await profileController.getProfileDetails();
    userType = pref.getString("shashaktnirmanusertype");
    print("userType =====> $userType ${userType.runtimeType}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                    'Vendor Dashboard',
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
                  body: ListView(
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
                      MenuNameImageSection(
                        userType: userType.toString(),
                        navfrom: "vendor",
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  title: "My Service",
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
                                  title: "Subscriptions",
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildCustomCard(
                                  onTap: () {
                                    context.toPage(
                                      ChooseCategoryView(
                                          navigationModel: NavigationModel(
                                        navFrom: "Dashboard",
                                        roleType: "Vendor",
                                        pageName: "Choose Category",
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
                                  title: "Select Category",
                                ),
                                buildCustomCard(
                                  onTap: () async {
                                    final pref =
                                        await SharedPreferences.getInstance();
                                    context.toPage(AddServiceView(
                                      navigationModel: NavigationModel(
                                        isLoggedIn: pref.getBool(
                                            "shashaktnirman_is_logged_in"),
                                        navFrom: "Dashboard",
                                        roleType: "Vendor",
                                        pageName: "Add Service",
                                      ),
                                    ));
                                  },
                                  size: size,
                                  gradientColors: [
                                    Color(0xffFF6B2C),
                                    Color(0xffffa500)
                                  ],
                                  icon: Icons.miscellaneous_services,
                                  iconColor: Color(0xffffa500),
                                  iconBgColor: cc.white,
                                  title: "Add Service",
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
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
                                  title: "Promotion",
                                ),
                              ],
                            ),

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
                          ],
                        ),
                      )
                    ],
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
