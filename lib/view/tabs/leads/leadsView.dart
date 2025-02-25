import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/model/navigationModel.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/leadsController/leadsController.dart';
import 'package:qixer/view/home/components/section_title.dart';
import 'package:qixer/view/tabs/leads/leadsDetailsView.dart';
import 'package:qixer/view/utils/constant_colors.dart';

import 'components/LeadItemCard.dart';

class LeadsView extends StatefulWidget {
  final NavigationModel? navigationModel;
  const LeadsView({super.key, this.navigationModel});

  @override
  State<LeadsView> createState() => _LeadsViewState();
}

class _LeadsViewState extends State<LeadsView> {
  final ConstantColors cc = ConstantColors();

  @override
  void initState() {
    firstLoad();
    super.initState();
  }

  firstLoad() {
    final leadController = Provider.of<LeadsController>(context, listen: false);
    if (mounted) {
      leadController.setIsNew(false);
      leadController.getMyLeads();
    }
  }

  String getTimeDifference(String createdAt) {
    try {
      // Parse the created_at timestamp and convert it to local time
      DateTime createdTime = DateTime.parse(createdAt).toLocal();
      DateTime now = DateTime.now();

      Duration diff = now.difference(createdTime);

      if (diff.inSeconds < 60) {
        return '${diff.inSeconds} sec ago';
      } else if (diff.inMinutes < 60) {
        return '${diff.inMinutes} min ago';
      } else if (diff.inHours < 24) {
        return '${diff.inHours} hr ago';
      } else if (diff.inDays < 7) {
        return '${diff.inDays} day${diff.inDays > 1 ? "s" : ""} ago';
      } else if (diff.inDays < 30) {
        return '${(diff.inDays / 7).floor()} week${(diff.inDays / 7).floor() > 1 ? "s" : ""} ago';
      } else {
        return DateFormat('dd MMM yyyy, hh:mm a').format(createdTime);
      }
    } catch (e) {
      return 'Invalid time';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final leadController = Provider.of<LeadsController>(context);
    print("is  new ===> ${leadController.isNew}");
    return StreamBuilder<Object?>(
      stream: leadController.countStream(),
      builder: (context, snapshot) {
        print("counts====> ${leadController.count}");
        // if (!snapshot.hasData) {
        //   return Scaffold(
        //     body: Center(
        //       child: CircularProgressIndicator(),
        //     ),
        //   );
        // }

        return Consumer<AppStringService>(
          builder: (context, asProvider, child) {
            return Consumer<LeadsController>(
              builder: (BuildContext context, leadsProvider, child) {
                return Scaffold(
                    appBar: AppBar(
                      centerTitle: true,
                      surfaceTintColor: cc.white,
                      iconTheme: IconThemeData(color: cc.greyPrimary),
                      systemOverlayStyle: SystemUiOverlayStyle.dark,
                      title: Text(
                        asProvider.getString("My Leads"),
                        style: TextStyle(
                            color: cc.greyPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      backgroundColor: cc.white,
                      elevation: 0,
                      leading: widget.navigationModel?.navFrom != "Home"
                          ? InkWell(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(
                                Icons.arrow_back_ios,
                                // size: 24,
                              ),
                            )
                          : null,
                    ),
                    body: Consumer<LeadsController>(
                      builder: (context, leadController, child) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: buildCustomCard(
                                          icon: Icons.insert_chart,
                                          title:
                                              "${leadController.myLeadsDataModel.newLeads ?? '0'} New Leads",
                                          backgroundColor:
                                              Colors.green.shade400,
                                          textColor: Colors.white,
                                          iconColor: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: buildCustomCard(
                                          icon: Icons.insert_chart_outlined,
                                          title:
                                              "${leadController.myLeadsDataModel.openLeads ?? '0'} Open Leads",
                                          backgroundColor: Colors.red.shade400,
                                          textColor: Colors.white,
                                          iconColor: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(height: 10),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Expanded(
                                  //       child: buildCustomCard(
                                  //         icon: Icons.local_fire_department_rounded,
                                  //         title: "Priority Leads",
                                  //         backgroundColor: Colors.orange.shade700,
                                  //         boxShadow: [
                                  //           BoxShadow(
                                  //             blurRadius: 5,
                                  //             color: Colors.orange.withOpacity(0.2),
                                  //             offset: Offset(0, 2),
                                  //           )
                                  //         ],
                                  //         textColor: Colors.white,
                                  //         iconColor: Colors.white,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  SizedBox(height: 10),
                                  leadController
                                              .myLeadsDataModel.data?.length ==
                                          0
                                      ? Offstage()
                                      : CategoryTitle2(
                                          cc: cc,
                                          title: asProvider
                                              .getString('Recent Leads'),
                                          hasSeeAllBtn: true,
                                          pressed: () => context
                                              .toPage(LeadsDetailsView()),
                                        ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: leadController
                                            .myLeadsDataModel.data?.length ==
                                        0
                                    ? Center(
                                        child: Text(
                                            "No Leads Generated For You Now"),
                                      )
                                    : ListView.builder(
                                        padding: const EdgeInsets.only(top: 3),
                                        itemCount: leadController
                                            .myLeadsDataModel.data?.length,
                                        itemBuilder: (context, index) {
                                          final leads = leadController
                                              .myLeadsDataModel.data?[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: LeadItemCard(
                                              cc: cc,
                                              isNew: leadController.isNew,
                                              name: leads?.buyer?.name ?? '',
                                              enquiryName:
                                                  leads?.serviceName ?? '',
                                              imageUrl:
                                                  "https://i.postimg.cc/FKrHpCYL/pngwing-com-2.png",
                                              leftTime: getTimeDifference(
                                                  leads?.createdAt ?? ''),
                                              address:
                                                  "234-236, Kerawalla Mansion, Above City walk Shoes, Tilak Marg,Mumbai",
                                              onTap: () => context
                                                  .toPage(LeadsDetailsView()),
                                              onTapCall: () => print("calling"),
                                              isFav: false,
                                            ),
                                          );
                                        },
                                      ))
                          ],
                        );
                      },
                    ));
              },
            );
          },
        );
      },
    );
  }

  // Custom Card Builder
  Widget buildCustomCard({
    required IconData icon,
    required String title,
    required Color backgroundColor,
    Color textColor = Colors.black,
    Color iconColor = Colors.black,
    List<BoxShadow>? boxShadow,
  }) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: backgroundColor,
        boxShadow: boxShadow ??
            [
              BoxShadow(
                blurRadius: 3,
                color: Colors.grey.withOpacity(0.3),
                offset: Offset(0, 2),
              ),
            ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 20),
            SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
