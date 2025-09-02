import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/model/CategoryDataModel.dart';
import 'package:qixer/model/navigationModel.dart';
import 'package:qixer/service/addServiceProvider/addServicerProvider.dart';
import 'package:qixer/service/home_services/category_service.dart';
import 'package:qixer/view/VenderDashBoard/VenderDashBoardView.dart';
import 'package:qixer/view/VenderDashBoard/subscriptionModule.dart';
import 'package:qixer/view/addService/addServiceView.dart';
import 'package:qixer/view/chooseCategory/widgets/CategorySelectCard.dart';
import 'package:qixer/view/home/categories/components/category_card.dart';
import 'package:qixer/view/home/landing_page.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/app_string_service.dart';
import '../utils/common_helper.dart';
import 'package:qixer/generated/app_localizations.dart';

class ChooseCategoryView extends StatefulWidget {
  final NavigationModel? navigationModel;
  const ChooseCategoryView({super.key, this.navigationModel});

  @override
  State<ChooseCategoryView> createState() => _ChooseCategoryViewState();
}

class _ChooseCategoryViewState extends State<ChooseCategoryView> {
  // List<MenuItem> categories = [
  //   MenuItem(
  //     id: 1,
  //     name: "Civil Work",
  //     imageUrl: "https://i.postimg.cc/9fPYn58n/civilworkimage.jpg",
  //   ),
  //   MenuItem(
  //     id: 2,
  //     name: "Electrical",
  //     imageUrl: "https://i.postimg.cc/7h5fLZ1W/electrical.jpg",
  //   ),
  //   MenuItem(
  //     id: 3,
  //     name: "Plumbing",
  //     imageUrl: "https://i.postimg.cc/VsKt3Rb6/plumbing.jpg",
  //   ),
  //   MenuItem(
  //     id: 4,
  //     name: "Painting",
  //     imageUrl: "https://i.postimg.cc/RVVvQV1Y/painting.jpg",
  //   ),
  //   MenuItem(
  //     id: 5,
  //     name: "Carpentry",
  //     imageUrl: "https://i.postimg.cc/m2vZDx3y/carpentry.jpg",
  //   ),
  // ];

  ConstantColors cc = ConstantColors();

  fistLoad() async {
    final categoryController =
        Provider.of<CategoryService>(context, listen: false);
    final serviceProvider =
        Provider.of<AddServiceController>(context, listen: false);
    if (mounted) {
      await categoryController.fetchCategory();
      print("calling this=====> ${widget.navigationModel?.navFrom}");
      if (widget.navigationModel?.navFrom == "Dashboard") {
        await serviceProvider.getSelectedCategory();
        categoryController.selectedCatList.clear();
        for (var element in serviceProvider.selectedCategoryList) {
          print("cat id =====> ${element['id']}");
          categoryController.addCategory(element['id'].toString());
        }
      }
    }
  }

  @override
  void initState() {
    fistLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addServiceController = Provider.of<AddServiceController>(context);
    final categoryController = Provider.of<CategoryService>(context);
    return Consumer<AppStringService>(
      builder: (context, asProvider, child) {
        return WillPopScope(
          onWillPop: () async {
            categoryController.clearLists();
            addServiceController.resetCategories();
            categoryController.selectedCatList.clear();
            if (widget.navigationModel?.navFrom == "SignUp") {
              context.toPage(LandingPage());
            } else {
              Navigator.of(context).pop(true);
            }
            return true;
          },
          child: Scaffold(
            appBar: CommonHelper().appbarCommon(
                AppLocalizations.of(context)!.addService, context, () {
              categoryController.selectedCatList.clear();
              categoryController.clearLists();
              addServiceController.resetCategories();
              Navigator.pop(context);
            }),
            body: SafeArea(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                children: [
                  SizedBox(height: 10),
                  CommonHelper().labelCommon2(
                      AppLocalizations.of(context)!.categories,
                      isRequired: true),
                  SizedBox(height: 10),
                  categoryController.isLoading
                      ? OthersHelper().showLoading(cc.primaryColor)
                      : SizedBox(
                          height: 180,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: categoryController
                                .categoryDataModel.categories?.length,
                            itemBuilder: (context, index) {
                              var category = categoryController
                                  .categoryDataModel.categories?[index];
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InkWell(
                                  onTap: () {
                                    categoryController.addCategoryInList(
                                        category: Categories(
                                      id: category?.id,
                                      name: category?.name,
                                      mobileIcon: category?.mobileIcon,
                                    ));
                                    // for set border color set cat id
                                    addServiceController.setCatId(category?.id);
                                    // for set multiid id in list
                                    addServiceController.setCatIDForSend(
                                        category?.id.toString() ?? '');
                                    // for get sub category,
                                    addServiceController.getSelectedCategory(
                                        category_id:
                                            addServiceController.catIds);
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              border: Border.all(
                                                width: categoryController.catIds
                                                        .any((cat) =>
                                                            cat["catId"] ==
                                                            category?.id)
                                                    ? 1
                                                    : 1, // ✅ Highlight if category is in list
                                                color: categoryController.catIds
                                                        .any((cat) =>
                                                            cat["catId"] ==
                                                            category?.id)
                                                    ? cc.primaryColor
                                                    : cc.black3,
                                              )),
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: CommonHelper().profileImage(
                                                fit: BoxFit.contain,
                                                category?.mobileIcon ?? '',
                                                75,
                                                75),
                                          )),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          maxLines: 4,
                                          overflow: TextOverflow.visible,
                                          category?.name ?? '',
                                          style: TextStyle(
                                              fontSize: 12, color: cc.black3),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                  SizedBox(height: 10),
                  categoryController.catIds.isNotEmpty
                      ? Text(
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                          AppLocalizations.of(context)!.selectSubCategory,
                          style: TextStyle(
                            color: cc.black3,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : Offstage(),
                  addServiceController.isLoading
                      ? OthersHelper().showLoading(cc.primaryColor)
                      : categoryController.catIds.isNotEmpty
                          ? ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: categoryController.catIds.length,
                              itemBuilder: (context, indexRoot) {
                                var category =
                                    categoryController.catIds[indexRoot];
                                var subCategoryList = addServiceController
                                    .selectedSubCategoryList
                                    .where((element) =>
                                        element['category_id'] ==
                                        category['catId'])
                                    .toList(); // ✅ Filtered List
                                return addServiceController.isLoading
                                    ? OthersHelper()
                                        .showLoading(cc.primaryColor)
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 10),
                                          categoryController.catIds.isEmpty
                                              ? Offstage()
                                              : Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                      color: cc.primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Text(
                                                      textAlign: TextAlign.left,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.visible,
                                                      category['name'],
                                                      style: TextStyle(
                                                        color: cc.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          if (categoryController
                                                  .catIds[indexRoot].length !=
                                              0)
                                            SizedBox(
                                              height: 165,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    subCategoryList.length,
                                                itemBuilder: (context, index) {
                                                  var subCategory =
                                                      subCategoryList[index];
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: CategoryCard(
                                                      onTap: () {
                                                        print(
                                                            "category id====> ${subCategory["category_id"]} ");
                                                        categoryController
                                                            .addSubCategoryInList(
                                                                categoryId:
                                                                    subCategory[
                                                                        "category_id"],
                                                                subCategory:
                                                                    Subcategories(
                                                                  id: subCategory[
                                                                      "id"],
                                                                  name: subCategory[
                                                                      "name"],
                                                                  image: subCategory[
                                                                      "image"],
                                                                ));
                                                      },
                                                      name: subCategory["name"],
                                                      id: subCategory["id"],
                                                      cc: cc,
                                                      index: index,
                                                      imagelink:
                                                          subCategory["image"]
                                                              ?.toString(),
                                                      isSelected: categoryController
                                                              .catIds
                                                              .firstWhere(
                                                                  (cat) =>
                                                                      cat["catId"] ==
                                                                      subCategory[
                                                                          "category_id"],
                                                                  orElse: () =>
                                                                      {})
                                                              .containsKey(
                                                                  "subCatIds") &&
                                                          categoryController
                                                              .catIds
                                                              .firstWhere((cat) =>
                                                                  cat["catId"] ==
                                                                  subCategory[
                                                                      "category_id"])[
                                                                  "subCatIds"]
                                                              .any((sub) =>
                                                                  sub["id"] ==
                                                                  subCategory[
                                                                      "id"]),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          else
                                            Offstage()
                                        ],
                                      );
                              },
                            )
                          : Offstage(),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 55,
                  child: CommonHelper().buttonOrange(
                      AppLocalizations.of(context)!.continueText, () async {
                    categoryController.addServiceByCategory(context).then(
                      (value) {
                        if (value == true) {
                          widget.navigationModel?.navFrom == "SignUp"
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SubscriptionModule(
                                      catIds: categoryController.catIds,
                                      navFrom: "Register",
                                    ),
                                  ))
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LandingPage()));
                        } else {
                          OthersHelper().toastShort(
                              AppLocalizations.of(context)!.categoryNotSelected,
                              Colors.red);
                        }
                      },
                    );
                  }, isloading: categoryController.isLoading2),
                )),
          ),
        );
      },
    );
  }

  // void showSuccessDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext contextS) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(12.0),
  //         ),
  //         contentPadding: EdgeInsets.all(20.0),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Icon(
  //               Icons.check_circle,
  //               color: Colors.green,
  //               size: 80,
  //             ),
  //             SizedBox(height: 20),
  //             Text(
  //               AppLocalizations.of(context)!.success,
  //               style: TextStyle(
  //                 fontSize: 22,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.black87,
  //               ),
  //             ),
  //             SizedBox(height: 10),
  //             Text(
  //               AppLocalizations.of(context)!
  //                   .youHaveSelectedCategorySuccessfully,
  //               textAlign: TextAlign.center,
  //               style: TextStyle(fontSize: 16, color: Colors.black54),
  //             ),
  //             SizedBox(height: 20),
  //             ElevatedButton(
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: Colors.green,
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(8.0),
  //                 ),
  //               ),
  //               onPressed: () async {
  //                 final pref = await SharedPreferences.getInstance();
  //                 contextS.toPage(VendorDashBoardVies(
  //                   navigationModel: NavigationModel(
  //                     isLoggedIn: pref.getBool("shashaktnirman_is_logged_in"),
  //                     navFrom: "Direct",
  //                     roleType: "Vendor",
  //                     pageName: "Vendor Dashboard",
  //                   ),
  //                 ));
  //               },
  //               child: Text(AppLocalizations.of(context)!.ok),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
