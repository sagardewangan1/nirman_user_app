import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/model/navigationModel.dart';
import 'package:qixer/service/addServiceProvider/addServicerProvider.dart';
import 'package:qixer/service/home_services/category_service.dart';
import 'package:qixer/view/VenderDashBoard/VenderDashBoardView.dart';
import 'package:qixer/view/addService/addServiceView.dart';
import 'package:qixer/view/chooseCategory/widgets/CategorySelectCard.dart';
import 'package:qixer/view/home/landing_page.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/app_string_service.dart';
import '../utils/common_helper.dart';

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
            categoryController.selectedCatList.clear();
            if (widget.navigationModel?.navFrom == "SignUp") {
              context.toPage(LandingPage());
            } else {
              Navigator.of(context).pop(true);
            }
            return true;
          },
          child: Scaffold(
            appBar: CommonHelper().appbarCommon('Choose Category', context, () {
              categoryController.selectedCatList.clear();
              categoryController.clearLists();
              Navigator.pop(context);
            }),
            body: Stack(
              children: [
                categoryController.isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Offstage(),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3 columns
                    // crossAxisSpacing: 10, // Space between columns
                    // mainAxisSpacing: 10, // Space between rows
                    childAspectRatio:
                        1, // Aspect ratio of each grid item (width:height)
                  ),
                  itemCount:
                      categoryController.categoryDataModel.categories?.length,
                  itemBuilder: (context, index) {
                    final category =
                        categoryController.categoryDataModel.categories?[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          categoryController
                              .addCategory(category?.id.toString() ?? "0");
                        },
                        child: CategorySelectCard(
                          imageUrl: "${category?.mobileIcon.toString()}" ??
                              "https://i.postimg.cc/9fPYn58n/civilworkimage.jpg",
                          title: category?.name ?? "Default",
                          isSelected: categoryController.selectedCatList
                                  .contains(category?.id.toString())
                              ? true
                              : false,
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
            bottomNavigationBar: Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 55,
                  child: CommonHelper().buttonOrange("Continue", () async {
                    categoryController.setCategoryForSeller().then(
                      (value) {
                        if (value == true) {
                          showSuccessDialog(context);
                        } else {
                          OthersHelper()
                              .toastShort("Category Not Seleted", Colors.red);
                        }
                      },
                    );
                  }),
                )),
          ),
        );
      },
    );
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext contextS) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          contentPadding: EdgeInsets.all(20.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 80,
              ),
              SizedBox(height: 20),
              Text(
                "Success!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Your have selected category successfully.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () async {
                  final pref = await SharedPreferences.getInstance();
                  contextS.toPage(VendorDashBoardVies(
                    navigationModel: NavigationModel(
                      isLoggedIn: pref.getBool("shashaktnirman_is_logged_in"),
                      navFrom: "Direct",
                      roleType: "Vendor",
                      pageName: "Vendor Dashboard",
                    ),
                  ));
                },
                child: Text("OK"),
              ),
            ],
          ),
        );
      },
    );
  }
}
