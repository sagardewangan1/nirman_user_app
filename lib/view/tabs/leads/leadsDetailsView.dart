import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:qixer/model/navigationModel.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/leadsController/leadsController.dart';
import 'package:qixer/view/tabs/leads/components/LeadDetailsItemCard.dart';
import 'package:qixer/view/utils/constant_colors.dart';

class LeadsDetailsView extends StatefulWidget {
  final NavigationModel? navigationModel;
  const LeadsDetailsView({super.key, this.navigationModel});

  @override
  State<LeadsDetailsView> createState() => _LeadsDetailsViewState();
}

class _LeadsDetailsViewState extends State<LeadsDetailsView> {
  final ConstantColors cc = ConstantColors();
  final TextEditingController _remarkController = TextEditingController();

  List<Map<String, dynamic>> mainFilter = [
    {"icon": Icons.groups, "name": "All Leads", 'color': Colors.black},
    // {
    //   "icon": Icons.local_fire_department_rounded,
    //   "name": "High Priority",
    //   'color': Colors.orange,
    // },
    // {
    //   "icon": Icons.recent_actors,
    //   "name": "Recent Leads",
    //   'color': Colors.black
    // },
    // {
    //   "icon": Icons.call_missed,
    //   "name": "Missed Opportunities",
    //   'color': Colors.red.shade400
    // },
    {
      "icon": Icons.fiber_manual_record,
      "name": "Active Leads",
      'color': Colors.green,
    },
    {
      "icon": Icons.check_box_sharp,
      "name": "Opened Leads",
      'color': Colors.orange,
    },
  ];

  int selectedFilterIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStringService>(
      builder: (context, asProvider, child) {
        Size size = MediaQuery.of(context).size;
        final leadController = Provider.of<LeadsController>(context);
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            centerTitle: true,
            surfaceTintColor: cc.white,
            iconTheme: IconThemeData(color: cc.greyPrimary),
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            title: Text(
              asProvider.getString("All Leads"),
              style: TextStyle(
                  color: cc.greyPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            backgroundColor: cc.white,
            elevation: 0,
            leading: widget.navigationModel?.navFrom != "Home Side"
                ? InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      // size: 24,
                    ),
                  )
                : null,
          ),
          body: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 38,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: mainFilter.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 3),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedFilterIndex =
                                    index; // Highlight the selected filter
                              });
                            },
                            borderRadius: BorderRadius.circular(5.0),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                gradient: index == selectedFilterIndex
                                    ? LinearGradient(
                                        colors: [
                                          Colors.blue.shade300,
                                          Colors.blue.shade600,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      )
                                    : null,
                                border: Border.all(
                                  width: 1,
                                  color: index == selectedFilterIndex
                                      ? Colors.transparent
                                      : cc.black6,
                                ),
                                color: index == selectedFilterIndex
                                    ? cc.white
                                    : cc.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Tooltip(
                                      message: mainFilter[index]['name'],
                                      child: Icon(
                                        mainFilter[index]['icon'],
                                        size: 16,
                                        color: index == selectedFilterIndex
                                            ? cc.white
                                            : mainFilter[index]['color'],
                                      ),
                                    ),
                                    Gap(5),
                                    Text(
                                      mainFilter[index]['name'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: index == selectedFilterIndex
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Gap(2),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 2.0),
                  //   child: Container(
                  //     height: 1,
                  //     width: size.width,
                  //     color: Colors.grey.shade600,
                  //   ),
                  // ),
                  // Container(
                  //     alignment: Alignment.centerLeft,
                  //     height: 38,
                  //     child: ListView(
                  //       shrinkWrap: true,
                  //       scrollDirection: Axis.horizontal,
                  //       padding: EdgeInsets.zero,
                  //       children: [
                  //         // Padding(
                  //         //   padding: const EdgeInsets.all(5.0),
                  //         //   child: InkWell(
                  //         //     onTap: () => showModalBottomSheet(
                  //         //         context: context,
                  //         //         backgroundColor: Colors.transparent,
                  //         //         builder: (context) {
                  //         //           return DateBottomSheet(
                  //         //             cc: cc,
                  //         //           );
                  //         //         }),
                  //         //     child: Container(
                  //         //       alignment: Alignment.center,
                  //         //       decoration: BoxDecoration(
                  //         //         color: Colors.grey.shade100,
                  //         //         borderRadius: BorderRadius.circular(5.0),
                  //         //         border:
                  //         //             Border.all(width: 1, color: cc.black7),
                  //         //       ),
                  //         //       child: Padding(
                  //         //         padding: const EdgeInsets.symmetric(
                  //         //             horizontal: 5.0, vertical: 3.0),
                  //         //         child: Row(
                  //         //           mainAxisAlignment: MainAxisAlignment.center,
                  //         //           crossAxisAlignment:
                  //         //               CrossAxisAlignment.center,
                  //         //           mainAxisSize: MainAxisSize.min,
                  //         //           children: [
                  //         //             Icon(
                  //         //               Icons.date_range,
                  //         //               size: 16,
                  //         //             ),
                  //         //             Gap(5),
                  //         //             Text(
                  //         //               "Date",
                  //         //               style: TextStyle(
                  //         //                 fontSize: 12,
                  //         //                 fontWeight: FontWeight.w400,
                  //         //                 color: Colors.black,
                  //         //               ),
                  //         //             ),
                  //         //           ],
                  //         //         ),
                  //         //       ),
                  //         //     ),
                  //         //   ),
                  //         // ),
                  //         // Padding(
                  //         //   padding: const EdgeInsets.all(5.0),
                  //         //   child: Container(
                  //         //     alignment: Alignment.center,
                  //         //     decoration: BoxDecoration(
                  //         //       color: Colors.grey.shade100,
                  //         //       borderRadius: BorderRadius.circular(5.0),
                  //         //       border: Border.all(width: 1, color: cc.black7),
                  //         //     ),
                  //         //     child: Padding(
                  //         //       padding: const EdgeInsets.symmetric(
                  //         //           horizontal: 5.0, vertical: 3.0),
                  //         //       child: Row(
                  //         //         mainAxisAlignment: MainAxisAlignment.center,
                  //         //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         //         mainAxisSize: MainAxisSize.min,
                  //         //         children: [
                  //         //           Icon(
                  //         //             Icons.bookmark_rounded,
                  //         //             size: 16,
                  //         //             color: cc.primaryColor,
                  //         //           ),
                  //         //           Gap(5),
                  //         //           Text(
                  //         //             "Bookmarked",
                  //         //             style: TextStyle(
                  //         //               fontSize: 12,
                  //         //               fontWeight: FontWeight.w400,
                  //         //               color: Colors.black,
                  //         //             ),
                  //         //           ),
                  //         //         ],
                  //         //       ),
                  //         //     ),
                  //         //   ),
                  //         // ),
                  //         // Padding(
                  //         //   padding: const EdgeInsets.all(5.0),
                  //         //   child: Container(
                  //         //     alignment: Alignment.center,
                  //         //     decoration: BoxDecoration(
                  //         //       color: Colors.grey.shade100,
                  //         //       borderRadius: BorderRadius.circular(5.0),
                  //         //       border: Border.all(width: 1, color: cc.black7),
                  //         //     ),
                  //         //     child: Padding(
                  //         //       padding: const EdgeInsets.symmetric(
                  //         //           horizontal: 5.0, vertical: 3.0),
                  //         //       child: Row(
                  //         //         mainAxisAlignment: MainAxisAlignment.center,
                  //         //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         //         mainAxisSize: MainAxisSize.min,
                  //         //         children: [
                  //         //           Icon(
                  //         //             Icons.note_alt_rounded,
                  //         //             size: 16,
                  //         //             color: cc.successColor,
                  //         //           ),
                  //         //           Gap(5),
                  //         //           Text(
                  //         //             "Remarks",
                  //         //             style: TextStyle(
                  //         //               fontSize: 12,
                  //         //               fontWeight: FontWeight.w400,
                  //         //               color: Colors.black,
                  //         //             ),
                  //         //           ),
                  //         //         ],
                  //         //       ),
                  //         //     ),
                  //         //   ),
                  //         // ),
                  //         // Padding(
                  //         //   padding: const EdgeInsets.all(5.0),
                  //         //   child: Container(
                  //         //     alignment: Alignment.center,
                  //         //     decoration: BoxDecoration(
                  //         //       color: Colors.grey.shade100,
                  //         //       borderRadius: BorderRadius.circular(5.0),
                  //         //       border: Border.all(width: 1, color: cc.black7),
                  //         //     ),
                  //         //     child: Padding(
                  //         //       padding: const EdgeInsets.symmetric(
                  //         //           horizontal: 5.0, vertical: 3.0),
                  //         //       child: Row(
                  //         //         mainAxisAlignment: MainAxisAlignment.center,
                  //         //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         //         mainAxisSize: MainAxisSize.min,
                  //         //         children: [
                  //         //           Text(
                  //         //             "More Filter",
                  //         //             style: TextStyle(
                  //         //               fontSize: 12,
                  //         //               fontWeight: FontWeight.w400,
                  //         //               color: Colors.black,
                  //         //             ),
                  //         //           ),
                  //         //           Gap(5),
                  //         //           SvgPicture.asset(
                  //         //               height: 16,
                  //         //               width: 16,
                  //         //               "assets/svg/filter2.svg"),
                  //         //         ],
                  //         //       ),
                  //         //     ),
                  //         //   ),
                  //         // )
                  //       ],
                  //     ))
                ],
              ),
              Expanded(
                  flex: 8,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: LeadsDetailItemCard(
                          cc: cc,
                          isNew: leadController.isNew,
                          name: "Rajesh Kumar Thawait",
                          enquiryName: "Website Development For School",
                          imageUrl:
                              "https://i.postimg.cc/FKrHpCYL/pngwing-com-2.png",
                          leftTime: "12hr",
                          address:
                              "606 , Shanti Ngr, 606 , Shanti Ngr, Behind Shell Colony, Behind Shell Colony, Chembur Mumbai",
                          onTapCall: () => print("calling"),
                          isFav: false,
                          datetime: "23 Jan 2025, 09:25 am",
                          onTapMenu: (value) => showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Center(
                                  child: Text(
                                    "Add Remarks",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize
                                        .min, // Ensures the column takes only the required height
                                    children: [
                                      TextField(
                                        controller: _remarkController,
                                        decoration: InputDecoration(
                                          labelText: "Your Remarks",
                                          border: OutlineInputBorder(),
                                        ),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 3,
                                      ),
                                      SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Add your save logic here
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Save",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  )),
            ],
          ),
        );
      },
    );
  }
}

class DateBottomSheet extends StatelessWidget {
  const DateBottomSheet({
    super.key,
    required this.cc,
  });

  final ConstantColors cc;

  @override
  Widget build(BuildContext context) {
    return Consumer<LeadsController>(
      builder: (context, leadController, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
            color: cc.white,
          ),
          child: ListView(
            children: [
              Gap(10),
              Text(
                textAlign: TextAlign.center,
                'Date Filter',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              Divider(),
              ListTile(
                onTap: () => leadController.setDateFilter('today'),
                leading: Radio(
                  value: 'today',
                  groupValue: leadController.selectedDateFilter,
                  onChanged: (value) => leadController.setDateFilter(value!),
                ),
                title: Text(
                  textAlign: TextAlign.left,
                  'Today',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
              // Divider(),
              ListTile(
                onTap: () => leadController.setDateFilter('yesterday'),
                leading: Radio(
                  value: 'yesterday',
                  groupValue: leadController.selectedDateFilter,
                  onChanged: (value) => leadController.setDateFilter(value!),
                ),
                title: Text(
                  textAlign: TextAlign.left,
                  'Yesterday',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
              // Divider(),
              ListTile(
                onTap: () => leadController.setDateFilter('last_7_days'),
                leading: Radio(
                  value: 'last_7_days',
                  groupValue: leadController.selectedDateFilter,
                  onChanged: (value) => leadController.setDateFilter(value!),
                ),
                title: Text(
                  textAlign: TextAlign.left,
                  'Last 7 Days',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
              // Divider(),
              ListTile(
                onTap: () => leadController.setDateFilter('this_month'),
                leading: Radio(
                  value: 'this_month',
                  groupValue: leadController.selectedDateFilter,
                  onChanged: (value) => leadController.setDateFilter(value!),
                ),
                title: Text(
                  textAlign: TextAlign.left,
                  'This Month',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
              // Divider(),
              ListTile(
                onTap: () => leadController.setDateFilter('custom'),
                leading: Radio(
                  value: 'custom',
                  groupValue: leadController.selectedDateFilter,
                  onChanged: (value) => leadController.setDateFilter(value!),
                ),
                title: Text(
                  textAlign: TextAlign.left,
                  'Custom',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
              Divider(),
              Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(width: 1, color: cc.errorColor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 3),
                        child: Text(
                          textAlign: TextAlign.center,
                          "Clear",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(width: 1, color: cc.successColor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 3),
                        child: Text(
                          textAlign: TextAlign.center,
                          "Search",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(10)
            ],
          ),
        );
      },
    );
  }
}

class MoreFilterSheet extends StatelessWidget {
  const MoreFilterSheet({
    super.key,
    required this.cc,
  });

  final ConstantColors cc;

  @override
  Widget build(BuildContext context) {
    return Consumer<LeadsController>(
      builder: (context, leadController, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
            color: cc.white,
          ),
          child: Column(
            children: [
              Gap(10),
              Text(
                textAlign: TextAlign.center,
                'Date Filter',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              Divider(),
              ListTile(
                leading: Radio(
                  value: 'today',
                  groupValue: leadController.selectedDateFilter,
                  onChanged: (value) => leadController.setDateFilter(value!),
                ),
                title: Text(
                  textAlign: TextAlign.left,
                  'Today',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Radio(
                  value: 'yesterday',
                  groupValue: leadController.selectedDateFilter,
                  onChanged: (value) => leadController.setDateFilter(value!),
                ),
                title: Text(
                  textAlign: TextAlign.left,
                  'Yesterday',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Radio(
                  value: 'last_7_days',
                  groupValue: leadController.selectedDateFilter,
                  onChanged: (value) => leadController.setDateFilter(value!),
                ),
                title: Text(
                  textAlign: TextAlign.left,
                  'Last 7 Days',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Radio(
                  value: 'this_month',
                  groupValue: leadController.selectedDateFilter,
                  onChanged: (value) => leadController.setDateFilter(value!),
                ),
                title: Text(
                  textAlign: TextAlign.left,
                  'This Month',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Radio(
                  value: 'custom',
                  groupValue: leadController.selectedDateFilter,
                  onChanged: (value) => leadController.setDateFilter(value!),
                ),
                title: Text(
                  textAlign: TextAlign.left,
                  'Custom',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
