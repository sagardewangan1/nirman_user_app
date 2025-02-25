import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/model/navigationModel.dart';
import 'package:qixer/service/selectionRoleService/selectionRoleService.dart';
import 'package:qixer/view/auth/login/login.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/others_helper.dart';

class SelectionRoleView extends StatefulWidget {
  final bool hasBackButton;
  const SelectionRoleView({super.key, required this.hasBackButton});

  @override
  State<SelectionRoleView> createState() => _SelectionRoleViewState();
}

class _SelectionRoleViewState extends State<SelectionRoleView> {
  ConstantColors cc = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: widget.hasBackButton
              ? InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: cc.black3,
                  ))
              : null,
        ),
        body: Consumer<SelectionRoleService>(
          builder: (context, selectRoleProvider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(appLogoIcon),
                          fit: BoxFit.fitHeight)),
                ),
                sizedBox20(),
                Text(
                  "Select Your Role",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                sizedBoxCustom(10),
                Text(
                  "Tell us who you are to get started",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                sizedBoxCustom(25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Customer Card
                    GestureDetector(
                      onTap: () {
                        selectRoleProvider.setRoleId(1);
                      },
                      child: Container(
                        width: 150, // Set fixed width
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                              width: 1,
                              color: selectRoleProvider.roleId == 1
                                  ? cc.primaryColor
                                  : Colors.black),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 6,
                              offset: Offset(0, 4), // Shadow position
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CommonHelper().profileImage(
                                "https://i.postimg.cc/3xByBJB3/customer.png",
                                40,
                                40),
                            SizedBox(height: 8),
                            Text(
                              "Customer",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "Looking for services",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Seller Card
                    GestureDetector(
                      onTap: () {
                        selectRoleProvider.setRoleId(0);
                      },
                      child: Container(
                        width: 150, // Set fixed width
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                              width: 1,
                              color: selectRoleProvider.roleId == 0
                                  ? cc.primaryColor
                                  : Colors.black),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 6,
                              offset: Offset(0, 4), // Shadow position
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonHelper().profileImage(
                                "https://i.postimg.cc/L8t4SHQG/engineer.png",
                                40,
                                40),
                            SizedBox(height: 8),
                            Text(
                              "Seller",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "Offering services",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(25),
                  child: CommonHelper().buttonOrange(
                      "Continue",
                      () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPage(
                                    navigationModel: NavigationModel(
                                        navFrom: "Role Selection",
                                        isLoggedIn: false,
                                        pageName: "Login",
                                        roleType: selectRoleProvider.roleId
                                            .toString()),
                                  )))),
                )
              ],
            );
          },
        ));
  }
}
