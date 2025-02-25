import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:provider/provider.dart';
import 'package:qixer/model/navigationModel.dart';
import 'package:qixer/service/addServiceProvider/addServicerProvider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/getImageController.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/custom_input.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/country_states_service.dart';
import '../../service/dropdowns_services/area_dropdown_service.dart';
import '../../service/dropdowns_services/country_dropdown_service.dart';
import '../../service/dropdowns_services/state_dropdown_services.dart';
import '../auth/signup/dropdowns/area_dropdown_popup.dart';
import '../auth/signup/dropdowns/country_dropdown_popup.dart';
import '../auth/signup/dropdowns/country_states_dropdowns.dart';
import '../auth/signup/dropdowns/state_dropdown_popup.dart';
import '../utils/constant_colors.dart';
import '../utils/responsive.dart';

class MenuItem {
  final int id;
  final String name;
  final String imageUrl;

  MenuItem({
    required this.id,
    required this.name,
    required this.imageUrl,
  });
}

class AddServiceView extends StatefulWidget {
  final NavigationModel? navigationModel;
  const AddServiceView({super.key, this.navigationModel});

  @override
  State<AddServiceView> createState() => _AddServiceViewState();
}

class _AddServiceViewState extends State<AddServiceView> {
  final quill.QuillController _controllerQuillOverview =
      quill.QuillController.basic();
  final quill.QuillController _controllerQuillPriceChart =
      quill.QuillController.basic();
  final quill.QuillController _controllerQuillTimeChart =
      quill.QuillController.basic();

  final TextEditingController _serviceName = TextEditingController();
  final TextEditingController _serviceExperience = TextEditingController();
  final TextEditingController _servicePrice = TextEditingController();
  final TextEditingController _serviceOverview = TextEditingController();

  List<String> serviceImages = [];
  String serviceImage = '';

  void loadImages(String? jsonString) {
    if (jsonString == null) {
      print("JSON string is null.");
      return;
    }
    try {
      final List<dynamic> decodedList = jsonDecode(jsonString);
      serviceImages = decodedList.map((item) => item.toString()).toList();
      print("decoded images====> $serviceImages");
    } catch (e) {
      print("Error decoding JSON: $e");
    }
  }

  Future<void> _selectOpenTime(
      BuildContext context, AddServiceController addServiceController) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: addServiceController.selectedOpenTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: Theme(
            data: ThemeData.light().copyWith(
              timePickerTheme: TimePickerThemeData(
                backgroundColor: Colors.white, // Dialog background color
                hourMinuteTextColor:
                    Colors.black, // Text color for hours and minutes
                dialHandColor: cc.primaryColor, // Color for the clock hands
                dialBackgroundColor:
                    Colors.grey[200]!, // Background of the clock
                entryModeIconColor:
                    Colors.grey, // Color for the mode switch icon
                dayPeriodTextColor: WidgetStateColor.resolveWith(
                  (states) => states.contains(WidgetState.selected)
                      ? Colors.white // Selected AM/PM text color
                      : Colors.grey, // Unselected text color
                ),
              ),
              buttonTheme: ButtonThemeData(
                colorScheme: ColorScheme.light(primary: cc.primaryColor),
              ),
              dialogBackgroundColor:
                  Colors.blueGrey[50]!, // Dialog container background
            ),
            child: child!,
          ),
        );
      },
    );
    if (pickedTime != null &&
        pickedTime != addServiceController.selectedOpenTime) {
      addServiceController
          .setOpenTime(pickedTime); // Set the selected open time
    }
  }

  Future<void> _selectCloseTime(
      BuildContext context, AddServiceController addServiceController) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: addServiceController.selectedCloseTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: Theme(
            data: ThemeData.light().copyWith(
              timePickerTheme: TimePickerThemeData(
                backgroundColor: Colors.white, // Dialog background color
                hourMinuteTextColor:
                    Colors.black, // Text color for hours and minutes
                dialHandColor: cc.primaryColor, // Color for the clock hands
                dialBackgroundColor:
                    Colors.grey[200]!, // Background of the clock
                entryModeIconColor:
                    Colors.grey, // Color for the mode switch icon
                dayPeriodTextColor: WidgetStateColor.resolveWith(
                  (states) => states.contains(WidgetState.selected)
                      ? Colors.white // Selected AM/PM text color
                      : Colors.grey, // Unselected text color
                ),
              ),
              buttonTheme: ButtonThemeData(
                colorScheme: ColorScheme.light(primary: cc.primaryColor),
              ),
              dialogBackgroundColor:
                  Colors.blueGrey[50]!, // Dialog container background
            ),
            child: child!,
          ),
        );
      },
    );

    if (picked != null && picked != addServiceController.selectedCloseTime) {
      addServiceController.setCloseTime(picked);
    }
  }

  final _formKey = GlobalKey<FormState>();

  firstLoad() async {
    final addServiceProvider =
        Provider.of<AddServiceController>(context, listen: false);
    await addServiceProvider.getSelectedCategory();
  }

  @override
  void initState() {
    firstLoad();
    super.initState();
  }

  @override
  void dispose() {
    _controllerQuillOverview.dispose();
    _controllerQuillPriceChart.dispose();
    _controllerQuillTimeChart.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final getImageController = Provider.of<GetImageController>(context);
    final addServiceController = Provider.of<AddServiceController>(context);
    return Consumer<AppStringService>(
      builder: (context, asProvider, child) {
        return Consumer<AddServiceController>(
          builder: (context, serviceProvider, child) {
            return PopScope(
              onPopInvokedWithResult: (didPop, result) {
                addServiceController.resetCategories();
              },
              canPop: true,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: CommonHelper().appbarCommon(
                    widget.navigationModel?.navFrom == "Dashboard" &&
                            widget.navigationModel?.pageName == "Update Service"
                        ? widget.navigationModel?.pageName.toString() ?? ''
                        : widget.navigationModel?.pageName.toString() ?? '',
                    context, () {
                  Navigator.pop(context);
                }),
                body: Form(
                  key: _formKey,
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    children: [
                      CommonHelper()
                          .labelCommon2("Categories", isRequired: true),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: DropdownSearch<dynamic>(
                          dropdownBuilder: (context, selectedItem) {
                            return Text(
                              selectedItem?["name"] ?? "Select Category",
                            );
                          },
                          items: serviceProvider.selectedCategoryList,
                          popupProps: PopupProps.menu(
                            itemBuilder: (context, item, isSelected) {
                              return Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 5.0),
                                  child: Text(
                                    item["name"],
                                  ),
                                ),
                              );
                            },
                            fit: FlexFit.loose,
                          ),
                          onChanged: (dynamic data) {
                            print(
                                "Selected category ===> ${data?["id"]}  runtype==> ${data?['id'].runtimeType}");
                            addServiceController
                                .setCatId(data?["id"].toString());
                            // addServiceController.selectedCatIds = data?['id'];
                            // addServiceController.selectedSubCategoryList
                            //     .clear();
                            addServiceController.getSelectedCategory(
                                category_id:
                                    addServiceController.selectedCatIds);
                          },
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ConstantColors().greyFive,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: ConstantColors().greyFive,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                          itemAsString: (dynamic item) => item["name"],
                          selectedItem:
                              serviceProvider.selectedCategoryList.firstWhere(
                            (item) =>
                                item["id"].toString() ==
                                addServiceController.selectedCatIds,
                            orElse: () => {"id": 0, "name": "Select Category"},
                          ),
                        ),
                      ),
                      // sub category
                      SizedBox(height: 15),
                      // sub category name
                      CommonHelper()
                          .labelCommon2("Sub Categories", isRequired: true),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: DropdownSearch<dynamic>(
                          items: addServiceController
                              .selectedSubCategoryList, // ✅ Updated list
                          dropdownBuilder: (context, selectedItem) {
                            return Text(
                              selectedItem?["name"] ?? "Select Sub Category",
                            );
                          },
                          popupProps: PopupProps.menu(
                            itemBuilder: (context, item, isSelected) {
                              return Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 5.0),
                                  child: Text(item["name"] ?? ''),
                                ),
                              );
                            },
                            fit: FlexFit.loose,
                          ),
                          onChanged: (dynamic data) {
                            print("Selected Sub Category ===> ${data?["id"]}");

                            addServiceController
                                .setSubCatId(data?['id'].toString());
                            serviceProvider.getSelectedCategory(
                                subCategory_id: data['id'].toString());

                            print(
                                "Selected Sub Category  ===> ${addServiceController.selectedSubCatName}");
                          },
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ConstantColors().greyFive, width: 1),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ConstantColors().greyFive, width: 1),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          itemAsString: (dynamic item) => item["name"],
                          selectedItem: addServiceController
                              .selectedSubCategoryList
                              .firstWhere(
                            (item) =>
                                item["id"].toString() ==
                                addServiceController.selectedSubIds,
                            orElse: () =>
                                {"id": 0, "name": "Select Sub Category"},
                          ),
                        ),
                      ),
                      // sub child category
                      serviceProvider.selectedChildCategoryList.isEmpty
                          ? Offstage()
                          : SizedBox(height: 15),
                      // child category
                      serviceProvider.selectedChildCategoryList.isEmpty
                          ? Offstage()
                          : CommonHelper().labelCommon2("Child Categories",
                              isRequired: true),
                      serviceProvider.selectedChildCategoryList.isEmpty
                          ? Offstage()
                          : SizedBox(height: 10),
                      if (serviceProvider.selectedChildCategoryList.isEmpty)
                        Offstage()
                      else
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: DropdownSearch<dynamic>(
                            dropdownBuilder: (context, selectedItem) {
                              return Text(
                                selectedItem?["name"] ??
                                    "Select Sub Child Category",
                              );
                            },
                            items: serviceProvider.selectedChildCategoryList,
                            popupProps: PopupProps.menu(
                              itemBuilder: (context, item, isSelected) {
                                return Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 5.0),
                                    child: Text(item.name),
                                  ),
                                );
                              },
                              fit: FlexFit.loose,
                            ),
                            onChanged: (data) {
                              if (data != null) {
                                addServiceController
                                    .setChildCatId(data?['id'].toString());
                                serviceProvider.selectedChildCategoryList
                                    .clear();
                                serviceProvider.selectedChildCategoryList
                                    .add(data);
                                print(
                                    "✅ Selected Child Category: ${serviceProvider.selectedChildCategoryList}");
                              }
                            },
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ConstantColors().greyFive,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ConstantColors().greyFive,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                            itemAsString: (dynamic item) => item["name"],
                            selectedItem:
                                addServiceController.selectedChildCatName,
                          ),
                        ),

                      SizedBox(height: 15),
                      // Service Name
                      CommonHelper().labelCommon2(
                          asProvider.getString("Service Name"),
                          isRequired: true),
                      SizedBox(height: 10),
                      CustomInput(
                        controller: _serviceName,
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return asProvider
                                .getString("Please enter your service name");
                          }
                          return null;
                        },
                        hintText:
                            asProvider.getString("Enter your service name"),
                        textInputAction: TextInputAction.next,
                      ),
                      // SizedBox(height: 15),
                      // // Service Type
                      // CommonHelper().labelCommon2(
                      //   "Service Type",
                      // ),
                      // CustomInput(
                      //   // controller: widget.businessName,
                      //   validation: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return "Please enter your service type";
                      //     }
                      //     return null;
                      //   },
                      //   hintText: "Enter your service type",
                      //   textInputAction: TextInputAction.next,
                      // ),
                      SizedBox(height: 15),
                      // Service Name
                      CommonHelper()
                          .labelCommon2("Service Experience", isRequired: true),
                      SizedBox(height: 10),
                      CustomInput(
                        controller: _serviceExperience,
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your service experience";
                          }
                          return null;
                        },
                        hintText: "Enter your service experience",
                        textInputAction: TextInputAction.next,
                      ),
                      // SizedBox(height: 15),
                      // CommonHelper().labelCommon2(
                      //   "Office/Service Time",
                      // ),
                      // Row(
                      //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Expanded(
                      //       child: InkWell(
                      //         onTap: () {
                      //           _selectOpenTime(context, addServiceController);
                      //         },
                      //         child: Container(
                      //           width: size.width,
                      //           decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(8.0),
                      //               border: Border.all(width: 1, color: cc.greyFive)),
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Row(
                      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 Text(
                      //                   addServiceController.selectedOpenTime
                      //                           ?.formatTo12Hour() ??
                      //                       "Open Time",
                      //                   style: TextStyle(
                      //                       fontSize: 14, fontWeight: FontWeight.w400),
                      //                 ),
                      //                 SizedBox(
                      //                   width: 5,
                      //                 ),
                      //                 Icon(
                      //                   Icons.timer_outlined,
                      //                   size: 18,
                      //                 )
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 25,
                      //     ),
                      //     Expanded(
                      //       child: InkWell(
                      //         onTap: () {
                      //           _selectCloseTime(context, addServiceController);
                      //         },
                      //         child: Container(
                      //           width: size.width,
                      //           decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(8.0),
                      //               border: Border.all(width: 1, color: cc.greyFive)),
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Row(
                      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 Text(
                      //                   addServiceController.selectedCloseTime
                      //                           ?.formatTo12Hour() ??
                      //                       "Close Time",
                      //                   style: TextStyle(
                      //                       fontSize: 14, fontWeight: FontWeight.w400),
                      //                 ),
                      //                 SizedBox(
                      //                   width: 5,
                      //                 ),
                      //                 Icon(
                      //                   Icons.timer_outlined,
                      //                   size: 18,
                      //                 )
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     // Spacer()
                      //   ],
                      // ),
                      // SizedBox(height: 15),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     CommonHelper().labelCommon2(
                      //       "Is Available All Cities :",
                      //     ),
                      //     Switch(
                      //       value: addServiceController.isSwitched,
                      //       onChanged: (value) {
                      //         addServiceController.setSwitch(value);
                      //       },
                      //       activeColor: Colors.green,
                      //       inactiveThumbColor: Colors.red,
                      //       inactiveTrackColor: Colors.white,
                      //       materialTapTargetSize:
                      //           MaterialTapTargetSize.shrinkWrap,
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: 15),
                      // CommonHelper().labelCommon2(
                      //   "Service Cities",
                      // ),
                      // SizedBox(height: 10),
                      // CustomInput(
                      //   // controller: widget.businessName,
                      //   validation: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return "Please enter your service cities";
                      //     }
                      //     return null;
                      //   },
                      //   hintText: "Enter your service cities",
                      //   textInputAction: TextInputAction.next,
                      // ),
                      SizedBox(height: 15),
                      Consumer<CountryStatesService>(
                          builder: (context, provider, child) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //dropdown and search box
                                  const SizedBox(
                                    width: 17,
                                  ),

                                  // Country dropdown ===============>
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CommonHelper().labelCommon(
                                          'Choose Country',
                                          isRequired: true),
                                      Consumer<CountryDropdownService>(
                                        builder: (context, p, child) => InkWell(
                                          onTap: () {
                                            // p.fetchCountries(context, isrefresh: true);
                                            showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                builder:
                                                    (BuildContext context) {
                                                  return SizedBox(
                                                      height: screenHeight / 2 +
                                                          MediaQuery.of(context)
                                                                  .viewInsets
                                                                  .bottom /
                                                              2,
                                                      child:
                                                          const CountryDropdownPopup());
                                                });
                                          },
                                          child: dropdownPlaceholder(
                                            hintText: p.selectedCountry,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 25,
                                  ),
                                  // States dropdown ===============>
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CommonHelper().labelCommon(
                                          lnProvider.getString("Choose State"),
                                          isRequired: true),
                                      Consumer<StateDropdownService>(
                                        builder: (context, p, child) => InkWell(
                                          onTap: () {
                                            // p.fetchStates(context, isrefresh: true);
                                            showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                builder:
                                                    (BuildContext context) {
                                                  return SizedBox(
                                                      height: screenHeight / 2 +
                                                          MediaQuery.of(context)
                                                                  .viewInsets
                                                                  .bottom /
                                                              2,
                                                      child:
                                                          const StateDropdownPopup());
                                                });
                                          },
                                          child: dropdownPlaceholder(
                                              hintText: p.selectedState),
                                        ),
                                      )
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 25,
                                  ),

                                  // Area dropdown ===============>
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CommonHelper().labelCommon("Choose City",
                                          isRequired: true),
                                      Consumer<AreaDropdownService>(
                                        builder: (context, p, child) => InkWell(
                                          onTap: () {
                                            // p.fetchArea(context, isrefresh: true);
                                            showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                builder:
                                                    (BuildContext context) {
                                                  return SizedBox(
                                                      height: screenHeight / 2 +
                                                          MediaQuery.of(context)
                                                                  .viewInsets
                                                                  .bottom /
                                                              2,
                                                      child:
                                                          const AreaDropdownPopup2());
                                                });
                                          },
                                          child: dropdownPlaceholder(
                                              hintText:
                                                  p.selectedCity.isNotEmpty
                                                      ? p.selectedCity.join(',')
                                                      : 'Select Cities'),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                      SizedBox(height: 15),
                      CommonHelper()
                          .labelCommon2("Service Price", isRequired: true),
                      SizedBox(height: 10),
                      CustomInput(
                        controller: _servicePrice,
                        isNumberField: true,
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Service Price';
                          }
                          return null;
                        },
                        hintText: "Enter Service Price",
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 15),
                      CommonHelper()
                          .labelCommon2("Service  Overview", isRequired: true),
                      SizedBox(height: 10),
                      CustomInput(
                        controller: _serviceOverview,
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Service Overview';
                          }
                          return null;
                        },
                        onChanged: (p0) {
                          addServiceController.setOverviewLength(p0.length);
                        },
                        counterText:
                            "${addServiceController.currentOverviewLength}/${addServiceController.totalLength}",
                        hintText: "Enter Service Overview",
                        textInputAction: TextInputAction.next,
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //       border: Border.all(width: 1, color: cc.greyFive)),
                      //   height: 250,
                      //   child: Column(
                      //     children: [
                      //       SingleChildScrollView(
                      //         scrollDirection:
                      //             Axis.horizontal, // Enable horizontal scrolling
                      //         child: quill.QuillSimpleToolbar(
                      //           controller: _controllerQuillOverview,
                      //           configurations:
                      //               const quill.QuillSimpleToolbarConfigurations(
                      //             showListNumbers: true,
                      //             axis: Axis.horizontal,
                      //           ),
                      //         ),
                      //       ),
                      //       SizedBox(height: 10),
                      //       Expanded(
                      //         child: Container(
                      //           decoration: BoxDecoration(
                      //               border: Border.all(width: 1, color: cc.greyFive)),
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: ListView(
                      //               children: [
                      //                 quill.QuillEditor.basic(
                      //                   controller: _controllerQuillOverview,
                      //                   configurations:
                      //                       const quill.QuillEditorConfigurations(
                      //                           scrollBottomInset: 50),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(height: 15),
                      // CommonHelper().labelCommon2(
                      //   "Service Price Chart",
                      // ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //       border: Border.all(width: 1, color: cc.greyFive)),
                      //   height: 250,
                      //   child: Column(
                      //     children: [
                      //       SingleChildScrollView(
                      //         scrollDirection:
                      //             Axis.horizontal, // Enable horizontal scrolling
                      //         child: quill.QuillSimpleToolbar(
                      //           controller: _controllerQuillPriceChart,
                      //           configurations:
                      //               const quill.QuillSimpleToolbarConfigurations(
                      //             axis: Axis.horizontal,
                      //           ),
                      //         ),
                      //       ),
                      //       SizedBox(height: 10),
                      //       Expanded(
                      //         child: Container(
                      //           decoration: BoxDecoration(
                      //               border: Border.all(width: 1, color: cc.greyFive)),
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: ListView(
                      //               children: [
                      //                 quill.QuillEditor.basic(
                      //                   controller: _controllerQuillPriceChart,
                      //                   configurations:
                      //                       const quill.QuillEditorConfigurations(
                      //                           scrollBottomInset: 50),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(height: 15),
                      // CommonHelper().labelCommon2(
                      //   "Service Time Chart",
                      // ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //       border: Border.all(width: 1, color: cc.greyFive)),
                      //   height: 250,
                      //   child: Column(
                      //     children: [
                      //       SingleChildScrollView(
                      //         scrollDirection:
                      //             Axis.horizontal, // Enable horizontal scrolling
                      //         child: quill.QuillSimpleToolbar(
                      //           controller: _controllerQuillTimeChart,
                      //           configurations:
                      //               const quill.QuillSimpleToolbarConfigurations(
                      //             axis: Axis.horizontal,
                      //           ),
                      //         ),
                      //       ),
                      //       SizedBox(height: 10),
                      //       Expanded(
                      //         child: Container(
                      //           decoration: BoxDecoration(
                      //               border: Border.all(width: 1, color: cc.greyFive)),
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: ListView(
                      //               children: [
                      //                 quill.QuillEditor.basic(
                      //                   controller: _controllerQuillTimeChart,
                      //                   configurations:
                      //                       const quill.QuillEditorConfigurations(
                      //                           scrollBottomInset: 50),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      SizedBox(height: 15),
                      CommonHelper()
                          .labelCommon2("Service Images", isRequired: true),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getImageController.files.isNotEmpty
                                ? Text(
                                    'Images from Files ${getImageController.files.length}',
                                    style:
                                        Theme.of(context).textTheme.labelSmall)
                                : const Offstage(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                            width: 1, color: cc.greyFive),
                                      ),
                                      child: getImageController.fileSingle !=
                                              null
                                          ? Image.file(
                                              getImageController.fileSingle!,
                                              height: 160,
                                              width: 220,
                                              fit: BoxFit.cover,
                                            )
                                          : Container(
                                              height: 160,
                                              width: 220,
                                              alignment: Alignment.center,
                                              child: Text(
                                                "No Image Selected",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ), // Fallback if no image is selected
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: getImageController.fileSingle !=
                                            null
                                        ? () {
                                            getImageController.removeFile();
                                          }
                                        : null, // Disable button if no file selected
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                            // ListView.builder(
                            //   shrinkWrap: true,
                            //   physics: const NeverScrollableScrollPhysics(),
                            //   itemCount: getImageController.files.length,
                            //   itemBuilder: (context, index) {
                            //     if (index == getImageController.files.length) {
                            //       return IconButton(
                            //         icon: Icon(Icons.add),
                            //         onPressed: () {
                            //           getImageController.chooseMoreImage();
                            //         },
                            //       );
                            //     }
                            //     return Padding(
                            //       padding: const EdgeInsets.all(8.0),
                            //       child: Row(
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.center,
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         children: [
                            //           ClipRRect(
                            //             borderRadius:
                            //                 BorderRadius.circular(8.0),
                            //             child: Container(
                            //               decoration: BoxDecoration(
                            //                 borderRadius:
                            //                     BorderRadius.circular(8.0),
                            //                 border: Border.all(
                            //                     width: 1, color: cc.greyFive),
                            //               ),
                            //               child: getImageController
                            //                       .files.isNotEmpty
                            //                   ? Image.file(
                            //                       getImageController
                            //                           .files[index],
                            //                       height: 160,
                            //                       width: 220,
                            //                       fit: BoxFit.cover,
                            //                     )
                            //                   : Container(), // Fallback in case it's not a File
                            //             ),
                            //           ),
                            //           IconButton(
                            //             onPressed: getImageController
                            //                         .fileSingle !=
                            //                     null
                            //                 ? () {
                            //                     getImageController.removeFile();
                            //                   }
                            //                 : null, // Disable button if no file selected
                            //             icon: const Icon(Icons.delete,
                            //                 color: Colors.red),
                            //           ),
                            //         ],
                            //       ),
                            //     );
                            //   },
                            // ),
                          ],
                        ),
                      ),

                      // single image
                      widget.navigationModel?.pageName == "Update Service" &&
                              serviceImage != ''
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                              width: 1, color: cc.greyFive),
                                        ),
                                        child: CommonHelper().profileImage(
                                          serviceImage, // Use Image.network for URLs
                                          160,
                                          220,
                                        )),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      serviceImage = '';
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                  ),
                                ],
                              ),
                            )
                          : Offstage(),

                      // // Section for images from _serviceImages
                      // widget.navigationModel?.pageName == "Update Service"
                      //     ? Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             serviceImages.isNotEmpty
                      //                 ? Text('Images from Vehicle API',
                      //                     style: Theme.of(context)
                      //                         .textTheme
                      //                         .labelSmall)
                      //                 : const Offstage(),
                      //             ListView.builder(
                      //               shrinkWrap: true,
                      //               physics:
                      //                   const NeverScrollableScrollPhysics(),
                      //               itemCount: serviceImages.length,
                      //               itemBuilder: (context, index) {
                      //                 return Padding(
                      //                   padding: const EdgeInsets.all(8.0),
                      //                   child: Row(
                      //                     crossAxisAlignment:
                      //                         CrossAxisAlignment.center,
                      //                     mainAxisAlignment:
                      //                         MainAxisAlignment.center,
                      //                     children: [
                      //                       ClipRRect(
                      //                         borderRadius:
                      //                             BorderRadius.circular(8.0),
                      //                         child: Container(
                      //                             decoration: BoxDecoration(
                      //                               borderRadius:
                      //                                   BorderRadius.circular(
                      //                                       8.0),
                      //                               border: Border.all(
                      //                                   width: 1,
                      //                                   color: cc.greyFive),
                      //                             ),
                      //                             child: CommonHelper()
                      //                                 .profileImage(
                      //                               serviceImages[
                      //                                   index], // Use Image.network for URLs
                      //                               160,
                      //                               220,
                      //                             )),
                      //                       ),
                      //                       IconButton(
                      //                         onPressed: () {
                      //                           serviceImages.removeAt(index);
                      //                           setState(() {});
                      //                         },
                      //                         icon: const Icon(Icons.delete,
                      //                             color: Colors.red),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 );
                      //               },
                      //             ),
                      //           ],
                      //         ),
                      //       )
                      //     : const Offstage(),
                      InkWell(
                        onTap: () => getImageController.chooseImage(),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: cc.black6,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              textAlign: TextAlign.center,
                              "Add Image",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: cc.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                bottomNavigationBar: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 55,
                      child: CommonHelper().buttonOrange(
                        "Continue",
                        () async {
                          // OthersHelper()
                          //     .showToast("Service Added", cc.successColor);
                          if (serviceProvider.isLoading == false) {
                            // Ensure category IDs are not null
                            var body = {
                              "category_id":
                                  "${addServiceController.selectedCatIds}",
                              "subcategory_id":
                                  "${addServiceController.selectedSubIds}",
                              "child_category_id":
                                  "${addServiceController.selectedChildIds ?? 0} ",
                              "title": _serviceName.text,
                              "description": _serviceOverview.text,
                              "price": _servicePrice.text.toString(),
                              "service_city_id": context
                                  .read<StateDropdownService>()
                                  .selectedStateId
                                  .toString(),
                              // "service_area_id": jsonEncode(context
                              //     .read<AreaDropdownService>()
                              //     .selectedCityID),
                              "service_area_id":
                                  "[${context.read<AreaDropdownService>().selectedCityID.map((e) => "'$e'").join(",")}]",
                              "experience": _serviceExperience.text,
                            };

                            print("body=====> $body");

                            Map<String, String> images = {};
                            Map<String, String> imageUrls = {};
                            //
                            // // Handle image selection
                            // if (getImageController.files.isNotEmpty) {
                            //   for (int i = 0;
                            //       i < getImageController.files.length;
                            //       i++) {
                            //     images["image$i"] =
                            //         getImageController.files[i].path.toString();
                            //   }
                            // }

                            // Handle existing image URLs if required
                            // if (existingImageUrls.isNotEmpty) {
                            //   for (int i = 0; i < existingImageUrls.length; i++) {
                            //     imageUrls["imageUrl$i"] = existingImageUrls[i];
                            //   }
                            // }

                            if (addServiceController.selectedCatIds == null ||
                                addServiceController.selectedCatIds == '0' ||
                                addServiceController.selectedSubIds == null ||
                                addServiceController.selectedSubIds == '0') {
                              String message =
                                  "Category and Subcategory Required";
                              OthersHelper()
                                  .showToast(message, cc.warningColor);
                              return;
                            }
                            if (getImageController.fileSingle == null) {
                              OthersHelper()
                                  .showToast("Image Required", cc.warningColor);
                              return;
                            }
                            if (_formKey.currentState?.validate() ?? false) {
                              final pref =
                                  await SharedPreferences.getInstance();
                              bool isLogged =
                                  pref.getBool("shashaktnirmanIsLoggedIn") ??
                                      false;

                              bool success = await serviceProvider.addService(
                                context,
                                body,
                                isLogged,
                                imagePath: getImageController
                                    .fileSingle?.path, // ✅ Pass only one image
                                images: getImageController
                                    .files, // ✅ This should be a required list
                              );

                              if (success) {
                                OthersHelper().showToast(
                                    "Service Added", cc.successColor);
                                getImageController.removeFile();
                                addServiceController.resetCategories();

                                Navigator.pop(context);
                              } else {
                                OthersHelper().showToast(
                                    "Failed to add service", cc.errorColor);
                              }
                            }
                          }
                        },
                        isloading:
                            serviceProvider.isLoading == false ? false : true,
                      ),
                    )),
              ),
            );
          },
        );
      },
    );
  }
}
