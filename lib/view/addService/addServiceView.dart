import 'dart:convert';
import 'package:qixer/generated/app_localizations.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:provider/provider.dart';
import 'package:qixer/model/navigationModel.dart';
import 'package:qixer/service/addServiceProvider/addServicerProvider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/getImageController.dart';
import 'package:qixer/service/home_services/category_service.dart';
import 'package:qixer/service/jobs_service/recent_jobs_service.dart';
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
  // final quill.QuillController _controllerQuillOverview =
  //     quill.QuillController.basic();
  // final quill.QuillController _controllerQuillPriceChart =
  //     quill.QuillController.basic();
  // final quill.QuillController _controllerQuillTimeChart =
  //     quill.QuillController.basic();`
  //

  final TextEditingController _serviceName = TextEditingController();
  final TextEditingController _serviceExperience = TextEditingController();
  final TextEditingController _servicePrice = TextEditingController();
  final TextEditingController _serviceOverview = TextEditingController();

  List<String> serviceImages = [];
  String serviceImage = '';

  // Future<void> _selectOpenTime(
  //     BuildContext context, AddServiceController addServiceController) async {
  //   final TimeOfDay? pickedTime = await showTimePicker(
  //     context: context,
  //     initialTime: addServiceController.selectedOpenTime ?? TimeOfDay.now(),
  //     builder: (BuildContext context, Widget? child) {
  //       return MediaQuery(
  //         data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
  //         child: Theme(
  //           data: ThemeData.light().copyWith(
  //             timePickerTheme: TimePickerThemeData(
  //               backgroundColor: Colors.white, // Dialog background color
  //               hourMinuteTextColor:
  //                   Colors.black, // Text color for hours and minutes
  //               dialHandColor: cc.primaryColor, // Color for the clock hands
  //               dialBackgroundColor:
  //                   Colors.grey[200]!, // Background of the clock
  //               entryModeIconColor:
  //                   Colors.grey, // Color for the mode switch icon
  //               dayPeriodTextColor: WidgetStateColor.resolveWith(
  //                 (states) => states.contains(WidgetState.selected)
  //                     ? Colors.white // Selected AM/PM text color
  //                     : Colors.grey, // Unselected text color
  //               ),
  //             ),
  //             buttonTheme: ButtonThemeData(
  //               colorScheme: ColorScheme.light(primary: cc.primaryColor),
  //             ),
  //             dialogBackgroundColor:
  //                 Colors.blueGrey[50]!, // Dialog container background
  //           ),
  //           child: child!,
  //         ),
  //       );
  //     },
  //   );
  //   if (pickedTime != null &&
  //       pickedTime != addServiceController.selectedOpenTime) {
  //     addServiceController
  //         .setOpenTime(pickedTime); // Set the selected open time
  //   }
  // }
  //
  // Future<void> _selectCloseTime(
  //     BuildContext context, AddServiceController addServiceController) async {
  //   TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: addServiceController.selectedCloseTime ?? TimeOfDay.now(),
  //     builder: (BuildContext context, Widget? child) {
  //       return MediaQuery(
  //         data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
  //         child: Theme(
  //           data: ThemeData.light().copyWith(
  //             timePickerTheme: TimePickerThemeData(
  //               backgroundColor: Colors.white, // Dialog background color
  //               hourMinuteTextColor:
  //                   Colors.black, // Text color for hours and minutes
  //               dialHandColor: cc.primaryColor, // Color for the clock hands
  //               dialBackgroundColor:
  //                   Colors.grey[200]!, // Background of the clock
  //               entryModeIconColor:
  //                   Colors.grey, // Color for the mode switch icon
  //               dayPeriodTextColor: WidgetStateColor.resolveWith(
  //                 (states) => states.contains(WidgetState.selected)
  //                     ? Colors.white // Selected AM/PM text color
  //                     : Colors.grey, // Unselected text color
  //               ),
  //             ),
  //             buttonTheme: ButtonThemeData(
  //               colorScheme: ColorScheme.light(primary: cc.primaryColor),
  //             ),
  //             dialogBackgroundColor:
  //                 Colors.blueGrey[50]!, // Dialog container background
  //           ),
  //           child: child!,
  //         ),
  //       );
  //     },
  //   );
  //
  //   if (picked != null && picked != addServiceController.selectedCloseTime) {
  //     addServiceController.setCloseTime(picked);
  //   }
  // }

  final _formKey = GlobalKey<FormState>();

  firstLoad() async {
    final int? cityId = context.read<RecentJobsService>().cityID;
    print("cityId= $cityId");
    Provider.of<CategoryService>(context, listen: false)
        .fetchCategory(location_id: cityId.toString() ?? '');
    final addServiceProvider =
        Provider.of<AddServiceController>(context, listen: false);
    await addServiceProvider.getSelectedCategory();
    if (widget.navigationModel?.pageName == "Update Service") {
      await addServiceProvider.getMyServiceById(
          serviceId: widget.navigationModel?.roleType.toString());

      // Directly fetching from myServiceData map
      var serviceData = addServiceProvider.myServiceData;

      if (serviceData != null) {
        List<Map<String, String>> serviceAreas = [];

        if (serviceData["service_area_id"] != null &&
            serviceData["service_area_id"] is List) {
          serviceAreas = (serviceData["service_area_id"] as List)
              .map((area) => {
                    "id": area["id"].toString(),
                    "area_name": area["service_area"].toString(),
                  })
              .toList();
        }

        setMyServiceLoadData(
            addServiceController: addServiceProvider,
            title: serviceData["title"]?.toString() ?? "",
            experience: serviceData["experience"]?.toString() ?? "",
            price: serviceData["price"]?.toString() ?? "",
            overview: serviceData["description"] ?? "",
            categoryId: serviceData["category_id"]?.toString() ?? "",
            subCategoryId: serviceData["subcategory_id"]?.toString() ?? "",
            childCategoryId: serviceData["child_category_id"]?.toString() ?? "",
            imageUrl: serviceData["image"]?["img_url"]?.toString() ?? "",
            countryId: '06',
            countryName: "India",
            stateId: serviceData["service_city"]["id"].toString() ?? "",
            stateName:
                serviceData["service_city"]["service_city"].toString() ?? "",
            serviceAreas: serviceAreas);
      }
    }
  }

  setMyServiceLoadData(
      {AddServiceController? addServiceController,
      String? title,
      String? experience,
      String? price,
      String? overview,
      String? categoryId,
      String? subCategoryId,
      String? childCategoryId,
      String? imageUrl,
      String? countryId,
      String? countryName,
      String? stateId,
      String? stateName,
      List<Map<String, String>>? serviceAreas}) {
    _serviceName.text = title ?? '';
    _serviceExperience.text = experience ?? '';
    _servicePrice.text = price ?? '';
    _serviceOverview.text = overview ?? '';

    addServiceController?.setCatId(categoryId.toString());
    addServiceController?.getSelectedCategory(
        category_id: addServiceController.catIds);

    if (categoryId != null) {}

    if (subCategoryId != null) {
      addServiceController?.setSubCatId(subCategoryId);
    }

    if (childCategoryId != null) {
      addServiceController?.setChildCatId(childCategoryId);
    }

    // Set the service image if available
    if (imageUrl != null && imageUrl.isNotEmpty) {
      serviceImage =
          imageUrl; // Assuming serviceImage is a String that holds the image URL
    }
    // country
    context.read<CountryDropdownService>().setSelectedCountryId(countryId);
    context.read<CountryDropdownService>().setCountryValue(countryName);
    // // state
    context.read<StateDropdownService>().setSelectedStatesId(stateId);
    context.read<StateDropdownService>().setStatesValue(stateName);
    // city (area)
    for (var area in serviceAreas ?? []) {
      context
          .read<AreaDropdownService>()
          .setSelectedCity(area["area_name"], area["id"]);
    }
  }

  @override
  void initState() {
    firstLoad();
    super.initState();
  }

  // @override
  // void dispose() {
  //   _controllerQuillOverview.dispose();
  //   _controllerQuillPriceChart.dispose();
  //   _controllerQuillTimeChart.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final getImageController = Provider.of<GetImageController>(context);
    final addServiceController = Provider.of<AddServiceController>(context);
    final categoryController = Provider.of<CategoryService>(context);
    return Consumer<AppStringService>(
      builder: (context, asProvider, child) {
        return Consumer<AddServiceController>(
          builder: (context, serviceProvider, child) {
            return PopScope(
              onPopInvokedWithResult: (didPop, result) {
                getImageController.removeFile();
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
                body: addServiceController.isLoading2
                    ? Center(child: OthersHelper().showLoading(cc.primaryColor))
                    : Form(
                        key: _formKey,
                        child: ListView(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          children: [
                            CommonHelper().labelCommon2(
                                AppLocalizations.of(context)!.categories,
                                isRequired: true),
                            SizedBox(height: 10),
                            categoryController.isLoading
                                ? OthersHelper().showLoading(cc.primaryColor)
                                : SizedBox(
                                    height: 160,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: categoryController
                                          .categoryDataModel.categories?.length,
                                      itemBuilder: (context, index) {
                                        var category = categoryController
                                            .categoryDataModel
                                            .categories?[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: InkWell(
                                            onTap: () {
                                              addServiceController
                                                  .setCatId(category?.id);
                                              addServiceController
                                                  .getSelectedCategory(
                                                      category_id:
                                                          addServiceController
                                                              .catIds);
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      border: Border.all(
                                                          width: addServiceController
                                                                      .selectedCatIds ==
                                                                  category?.id
                                                                      .toString()
                                                              ? 2
                                                              : 1,
                                                          color: addServiceController
                                                                      .selectedCatIds ==
                                                                  category?.id
                                                                      .toString()
                                                              ? cc.primaryColor
                                                              : cc.black3)),
                                                  child: CommonHelper()
                                                      .profileImage(
                                                          fit: BoxFit.contain,
                                                          category?.mobileIcon
                                                                  .toString() ??
                                                              "https://cdn-icons-png.flaticon.com/512/11498/11498792.png",
                                                          75,
                                                          75),
                                                ),
                                                SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                    textAlign: TextAlign.center,
                                                    maxLines: 4,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    category?.name.toString() ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: cc.black3),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                            SizedBox(
                                height: addServiceController
                                        .selectedSubCategoryList.isEmpty
                                    ? 0
                                    : 10),
                            // Container(
                            //   decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     borderRadius: BorderRadius.circular(8.0),
                            //   ),
                            //   child: DropdownSearch<dynamic>(
                            //     dropdownBuilder: (context, selectedItem) {
                            //       return Text(
                            //         selectedItem?["name"] ?? "Select Category",
                            //       );
                            //     },
                            //     items: serviceProvider.selectedCategoryList,
                            //     popupProps: PopupProps.menu(
                            //       itemBuilder: (context, item, isSelected) {
                            //         return Container(
                            //           color: Colors.white,
                            //           child: Padding(
                            //             padding: const EdgeInsets.symmetric(
                            //                 horizontal: 15.0, vertical: 5.0),
                            //             child: Text(
                            //               item["name"],
                            //             ),
                            //           ),
                            //         );
                            //       },
                            //       fit: FlexFit.loose,
                            //     ),
                            //     onChanged: (dynamic data) {
                            //       print(
                            //           "Selected category ===> ${data?["id"]}  runtype==> ${data?['id'].runtimeType}");
                            //       addServiceController
                            //           .setCatId(data?["id"].toString());
                            //       // addServiceController.selectedCatIds = data?['id'];
                            //       // addServiceController.selectedSubCategoryList
                            //       //     .clear();
                            //       addServiceController.getSelectedCategory(
                            //           category_id:
                            //               addServiceController.selectedCatIds);
                            //     },
                            //     dropdownDecoratorProps: DropDownDecoratorProps(
                            //       dropdownSearchDecoration: InputDecoration(
                            //         focusedBorder: OutlineInputBorder(
                            //           borderSide: BorderSide(
                            //             color: ConstantColors().greyFive,
                            //             width: 1,
                            //           ),
                            //           borderRadius: BorderRadius.circular(8.0),
                            //         ),
                            //         enabledBorder: OutlineInputBorder(
                            //           borderRadius: BorderRadius.circular(8.0),
                            //           borderSide: BorderSide(
                            //             color: ConstantColors().greyFive,
                            //             width: 1,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     itemAsString: (dynamic item) => item["name"],
                            //     // selectedItem: serviceProvider.selectedCategoryList.firstWhere(
                            //     //       (item) => item["id"].toString() == addServiceController.selectedCatIds,
                            //     //   orElse: () => {"id": 0, "name": "Select Category"},
                            //     // ),
                            //     selectedItem: serviceProvider
                            //         .selectedCategoryList
                            //         .firstWhere(
                            //       (item) =>
                            //           item["id"].toString() ==
                            //           addServiceController.selectedCatIds,
                            //       orElse: () =>
                            //           {"id": 0, "name": "Select Category"},
                            //     ),
                            //   ),
                            // ),
                            // sub category
                            // sub category name
                            addServiceController.selectedSubCategoryList.isEmpty
                                ? Offstage()
                                : CommonHelper().labelCommon2(
                                    AppLocalizations.of(context)!.subcategories,
                                    isRequired: true),
                            SizedBox(
                                height: addServiceController
                                        .selectedSubCategoryList.isEmpty
                                    ? 0
                                    : 10),
                            addServiceController.isLoading
                                ? OthersHelper().showLoading(cc.primaryColor)
                                : SizedBox(
                                    height: addServiceController
                                            .selectedSubCategoryList.isEmpty
                                        ? 0
                                        : 160,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: addServiceController
                                          .selectedSubCategoryList.length,
                                      itemBuilder: (context, index) {
                                        var subCategory = addServiceController
                                            .selectedSubCategoryList[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: InkWell(
                                            onTap: () {
                                              addServiceController.setSubCatId(
                                                  subCategory?["id"]
                                                      .toString());
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      border: Border.all(
                                                          width: addServiceController
                                                                      .selectedSubIds ==
                                                                  subCategory?[
                                                                          "id"]
                                                                      .toString()
                                                              ? 2
                                                              : 1,
                                                          color: addServiceController
                                                                      .selectedSubIds ==
                                                                  subCategory?[
                                                                          "id"]
                                                                      .toString()
                                                              ? cc.primaryColor
                                                              : cc.black3)),
                                                  child: CommonHelper()
                                                      .profileImage(
                                                          fit: BoxFit.contain,
                                                          subCategory?["image"]
                                                                  .toString() ??
                                                              "https://cdn-icons-png.flaticon.com/512/11498/11498792.png",
                                                          75,
                                                          75),
                                                ),
                                                SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                    textAlign: TextAlign.center,
                                                    maxLines: 4,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    subCategory?["name"]
                                                            .toString() ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: cc.black3),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                            SizedBox(
                                height: addServiceController
                                        .selectedSubCategoryList.isEmpty
                                    ? 0
                                    : 10),
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
                                    selectedItem?["name"] ??
                                        "Select Sub Category",
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
                                  print(
                                      "Selected Sub Category ===> ${data?["id"]}");

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
                                : CommonHelper().labelCommon2(
                                    "Child Categories",
                                    isRequired: true),
                            serviceProvider.selectedChildCategoryList.isEmpty
                                ? Offstage()
                                : SizedBox(height: 10),
                            if (serviceProvider
                                .selectedChildCategoryList.isEmpty)
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
                                  items:
                                      serviceProvider.selectedChildCategoryList,
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
                                      addServiceController.setChildCatId(
                                          data?['id'].toString());
                                      serviceProvider.selectedChildCategoryList
                                          .clear();
                                      serviceProvider.selectedChildCategoryList
                                          .add(data);
                                      print(
                                          "✅ Selected Child Category: ${serviceProvider.selectedChildCategoryList}");
                                    }
                                  },
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ConstantColors().greyFive,
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ConstantColors().greyFive,
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  itemAsString: (dynamic item) => item["name"],
                                  selectedItem:
                                      addServiceController.selectedChildCatName,
                                ),
                              ),
                            // Service Name
                            CommonHelper().labelCommon2(
                                AppLocalizations.of(context)!.serviceName,
                                isRequired: true),
                            SizedBox(height: 10),
                            CustomInput(
                              controller: _serviceName,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .pleaseEnterYourServiceName;
                                }
                                return null;
                              },
                              hintText: AppLocalizations.of(context)!
                                  .enterYourServiceName,
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
                            CommonHelper().labelCommon2(
                                AppLocalizations.of(context)!.serviceExperience,
                                isRequired: true),
                            SizedBox(height: 10),
                            CustomInput(
                              controller: _serviceExperience,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .pleaseEnterYourServiceExperience;
                                }
                                return null;
                              },
                              hintText: AppLocalizations.of(context)!
                                  .enterYourServiceExperience,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //dropdown and search box
                                        // const SizedBox(
                                        //   width: 17,
                                        // ),

                                        // // Country dropdown ===============>
                                        // Column(
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.start,
                                        //   children: [
                                        //     CommonHelper().labelCommon(
                                        //         'Choose Country',
                                        //         isRequired: true),
                                        //     Consumer<CountryDropdownService>(
                                        //       builder: (context, p, child) =>
                                        //           InkWell(
                                        //         onTap: () {
                                        //           // p.fetchCountries(context, isrefresh: true);
                                        //           showModalBottomSheet(
                                        //               context: context,
                                        //               isScrollControlled: true,
                                        //               builder: (BuildContext
                                        //                   context) {
                                        //                 return SizedBox(
                                        //                     height: screenHeight /
                                        //                             2 +
                                        //                         MediaQuery.of(
                                        //                                     context)
                                        //                                 .viewInsets
                                        //                                 .bottom /
                                        //                             2,
                                        //                     child:
                                        //                         const CountryDropdownPopup());
                                        //               });
                                        //         },
                                        //         child: dropdownPlaceholder(
                                        //           hintText: p.selectedCountry,
                                        //         ),
                                        //       ),
                                        //     )
                                        //   ],
                                        // ),

                                        // const SizedBox(
                                        //   height: 25,
                                        // ),
                                        // States dropdown ===============>
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CommonHelper().labelCommon(
                                                AppLocalizations.of(context)!
                                                    .chooseState,
                                                isRequired: true),
                                            Consumer<StateDropdownService>(
                                              builder: (context, p, child) =>
                                                  InkWell(
                                                onTap: () {
                                                  // p.fetchStates(context, isrefresh: true);
                                                  showModalBottomSheet(
                                                      context: context,
                                                      isScrollControlled: true,
                                                      builder: (BuildContext
                                                          context) {
                                                        return SizedBox(
                                                            height: screenHeight /
                                                                    2 +
                                                                MediaQuery.of(
                                                                            context)
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
                                            CommonHelper().labelCommon(
                                                AppLocalizations.of(context)!
                                                    .chooseCity,
                                                isRequired: true),
                                            Consumer<AreaDropdownService>(
                                              builder: (context, p, child) =>
                                                  InkWell(
                                                onTap: () {
                                                  // p.fetchArea(context, isrefresh: true);
                                                  showModalBottomSheet(
                                                      context: context,
                                                      isScrollControlled: true,
                                                      builder: (BuildContext
                                                          context) {
                                                        return SizedBox(
                                                            height: screenHeight /
                                                                    2 +
                                                                MediaQuery.of(
                                                                            context)
                                                                        .viewInsets
                                                                        .bottom /
                                                                    2,
                                                            child:
                                                                const AreaDropdownPopup2());
                                                      });
                                                },
                                                child: dropdownPlaceholder(
                                                    hintText: p.selectedCity
                                                            .isNotEmpty
                                                        ? p.selectedCity
                                                            .join(',')
                                                        : AppLocalizations.of(
                                                                context)!
                                                            .selectCity),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )),
                            SizedBox(height: 15),
                            CommonHelper().labelCommon2(
                                AppLocalizations.of(context)!.servicePrice,
                                isRequired: true),
                            SizedBox(height: 10),
                            CustomInput(
                              controller: _servicePrice,
                              isNumberField: false,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .enterServicePrice;
                                }
                                return null;
                              },
                              hintText: AppLocalizations.of(context)!
                                  .enterServicePrice,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 15),
                            CommonHelper().labelCommon2(
                                AppLocalizations.of(context)!.serviceOverview,
                                isRequired: true),
                            SizedBox(height: 10),
                            CustomInput(
                              controller: _serviceOverview,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .enterServiceOverview;
                                }
                                return null;
                              },
                              onChanged: (p0) {
                                addServiceController
                                    .setOverviewLength(p0.length);
                              },
                              counterText:
                                  "${addServiceController.currentOverviewLength}/${addServiceController.totalLength}",
                              hintText: AppLocalizations.of(context)!
                                  .enterServiceOverview,
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
                            CommonHelper().labelCommon2(
                                AppLocalizations.of(context)!.serviceImage,
                                isRequired: true),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Display image if fileSingle is available, otherwise show URL image
                                  if (getImageController.fileSingle != null ||
                                      (widget.navigationModel?.pageName ==
                                              "Update Service" &&
                                          serviceImage.isNotEmpty))
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                border: Border.all(
                                                    width: 1,
                                                    color: cc.greyFive),
                                              ),
                                              child: getImageController
                                                          .fileSingle !=
                                                      null
                                                  ? Image.file(
                                                      getImageController
                                                          .fileSingle!,
                                                      height: 160,
                                                      width: 220,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : CommonHelper().profileImage(
                                                      serviceImage, // URL image for update mode
                                                      160,
                                                      220,
                                                    ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              if (getImageController
                                                      .fileSingle !=
                                                  null) {
                                                getImageController.removeFile();
                                              } else {
                                                serviceImage = '';
                                                setState(() {});
                                              }
                                            },
                                            icon: const Icon(Icons.delete,
                                                color: Colors.red),
                                          ),
                                        ],
                                      ),
                                    )
                                  else
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          "No Image Selected",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),

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
                                    AppLocalizations.of(context)!.addImage,
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
                bottomNavigationBar: SafeArea(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 55,
                        child: CommonHelper().buttonOrange(
                          AppLocalizations.of(context)!.continueText,
                          () async {
                            // OthersHelper()
                            //     .showToast("Service Added", cc.successColor);
                            if (serviceProvider.isLoading == false) {
                              // Ensure category IDs are not null

                              // Map<String, String> images = {};
                              // Map<String, String> imageUrls = {};
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
                                String message = AppLocalizations.of(context)!
                                    .categoryAndSubcategoryRequired;
                                OthersHelper()
                                    .showToast(message, cc.warningColor);
                                return;
                              }

                              if (_serviceOverview.text.length < 150) {
                                return OthersHelper().showToast(
                                    AppLocalizations.of(context)!
                                        .serviceOverviewMust150Char,
                                    cc.warningColor);
                              }

                              if (_formKey.currentState?.validate() ?? false) {
                                final pref =
                                    await SharedPreferences.getInstance();
                                bool isLogged =
                                    pref.getBool("shashaktnirmanIsLoggedIn") ??
                                        false;
                                if (widget.navigationModel?.pageName ==
                                    "Update Service") {
                                  var body = {
                                    "service_id": widget
                                        .navigationModel?.roleType
                                        .toString(),
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
                                        "[${context.read<AreaDropdownService>().selectedCityID.map((e) => '"$e"').join(",")}]",
                                    "experience": _serviceExperience.text,
                                  };

                                  print("body=====> $body");
                                  bool success =
                                      await serviceProvider.updateService(
                                    context,
                                    body,
                                    isLogged,
                                    imagePath:
                                        getImageController.fileSingle?.path ??
                                            '', // ✅ Pass only one image
                                    images:
                                        serviceImage, // ✅ This should be a required list
                                  );

                                  if (success) {
                                    OthersHelper().showToast(
                                        AppLocalizations.of(context)!
                                            .successfullyUpdated,
                                        cc.successColor);
                                    getImageController.removeFile();
                                    addServiceController.resetCategories();

                                    Navigator.pop(context);
                                  } else {
                                    OthersHelper().showToast(
                                        AppLocalizations.of(context)!
                                            .failedUpdateService,
                                        cc.errorColor);
                                  }
                                } else {
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
                                        "[${context.read<AreaDropdownService>().selectedCityID.map((e) => '"$e"').join(",")}]",
                                    "experience": _serviceExperience.text,
                                  };

                                  print("body=====> $body");

                                  bool success =
                                      await serviceProvider.addService(
                                    context,
                                    body,
                                    isLogged,
                                    imagePath: getImageController.fileSingle
                                        ?.path, // ✅ Pass only one image
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
                            }
                          },
                          isloading:
                              serviceProvider.isLoading == false ? false : true,
                        ),
                      )),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
