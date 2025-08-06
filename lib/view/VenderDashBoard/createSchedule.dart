import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';

class CreateSchedule extends StatefulWidget {
  const CreateSchedule({super.key});

  @override
  State<CreateSchedule> createState() => _CreateScheduleState();
}

class _CreateScheduleState extends State<CreateSchedule> {
  ConstantColors cc = ConstantColors();

  final List<Map<String, dynamic>> _dayList = [
    {"id": 1, "dayName": "Sun"},
    {"id": 2, "dayName": "Mon"},
    {"id": 3, "dayName": "Tue"},
    {"id": 4, "dayName": "Wed"},
    {"id": 5, "dayName": "Thu"},
    {"id": 6, "dayName": "Fri"},
    {"id": 7, "dayName": "Sat"},
  ];

  void showDaySelectionDialog(BuildContext context) {
    List<Map<String, dynamic>> dayList = [
      {"id": 1, "dayName": "Sun"},
      {"id": 2, "dayName": "Mon"},
      {"id": 3, "dayName": "Tue"},
      {"id": 4, "dayName": "Wed"},
      {"id": 5, "dayName": "Thu"},
      {"id": 6, "dayName": "Fri"},
      {"id": 7, "dayName": "Sat"},
    ];

    String? selectedDay;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Select a Day",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Important: Avoids loose constraints
              children: [
                DropdownSearch<String>(
                  items:
                      dayList.map((day) => day["dayName"].toString()).toList(),
                  onChanged: (value) {
                    selectedDay = value;
                  },
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Day",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  popupProps: PopupProps.menu(
                    showSearchBox: false, // Disables search
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    hintText: "11:00 AM - 07:00 PM",
                    prefixIcon: const Icon(Icons.access_time),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, selectedDay);
                print("Selected Day: $selectedDay"); // Handle selection
              },
              child: const Text(
                "OK",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStringService>(
      builder: (context, value, child) {
        return SafeArea(
          child: Scaffold(
            appBar: CommonHelper().appbarCommon(
                "Create Schedule", context, () => Navigator.pop(context),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        showDaySelectionDialog(context);
                      },
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: cc.primaryColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: Icon(
                              Icons.add,
                              color: cc.white,
                            ),
                          )),
                    ),
                  ),
                ]),
            body: SmartRefresher(
              controller: RefreshController(),
              child: _dayList.isEmpty
                  ? Center(
                      child: OthersHelper().showLoading(cc.primaryColor),
                    )
                  : ListView.builder(
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: cc.white,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 3,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 10),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: cc.black8,
                                    child: Icon(Icons.timeline,
                                        color: cc.successColor),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: "Day : ",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: cc.black3,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: "Sun",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: cc.black6,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        RichText(
                                          text: TextSpan(
                                            text: "Time : ",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: cc.black3,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: "11:00 AM - 07:00 PM",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: cc.black6,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.delete,
                                    color: cc.errorColor,
                                  ),
                                ],
                              ),
                            ));
                      },
                    ),
            ),
          ),
        );
      },
    );
  }
}
