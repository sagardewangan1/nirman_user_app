import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/auth_services/signup_service.dart';
import 'package:qixer/view/auth/signup/pages/signup_country_states.dart';
import 'package:qixer/view/auth/signup/pages/signup_email_name.dart';
import 'package:qixer/view/auth/signup/pages/signup_phone_pass.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  ConstantColors cc = ConstantColors();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController repeatNewPasswordController = TextEditingController();

  @override
  void initState() {
    initPassword();
    super.initState();
  }

  bool shashaktnirman_is_logged_in = false;

  initPassword() async {
    final signUpController = Provider.of<SignupService>(context, listen: false);
    signUpController.setPageController(signUpController.pagecontroller);
    signUpController.setSelectedPageO(0);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    shashaktnirman_is_logged_in =
        prefs.getBool('shashaktnirman_is_logged_in') ?? true;
    String? email;
    String? pass;
    String? number;
    if (shashaktnirman_is_logged_in) {
      email = prefs.getString('shashaktnirmanemail');
      pass = prefs.getString("pass");
      number = prefs.getString("shashaktnirmanphone");
      print("number===> $number");
    }

    if (email!.isNotEmpty) {
      emailController.text = email ?? "";
      signUpController.setReadOnly(true);
    } else {
      emailController.clear();
      signUpController.setReadOnly(false);
    }

    if (number!.isNotEmpty) {
      numberController.text = number ?? "";
      signUpController.setReadOnly(true);
      signUpController.setPhone(number);
    } else {
      emailController.clear();
      signUpController.setReadOnly(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Consumer<AppStringService>(
      builder: (context, asProvider, child) => Consumer<SignupService>(
        builder: (context, provider, child) => WillPopScope(
          onWillPop: () {
            if (provider.selectedPage == 0) {
              return Future.value(true);
            } else {
              context.read<SignupService>().pagecontroller.animateToPage(
                  provider.selectedPage - 1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease);
              return Future.value(false);
            }
            // return Future.value(false);
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: CommonHelper().appbarCommon('', context, () {
              if (provider.selectedPage == 0) {
                Navigator.pop(context);
              } else {
                context.read<SignupService>().pagecontroller.animateToPage(
                    provider.selectedPage - 1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease);
              }
            }),
            body: Listener(
              onPointerDown: (_) {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.focusedChild?.unfocus();
                }
              },
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: CommonHelper().titleCommon("Add Your Details"),
                    ),

                    const SizedBox(
                      height: 35,
                    ),

                    //Page steps show =======>

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var i = 0; i < 3; i++)
                          Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: provider.selectedPage >= i
                                        ? cc.primaryColor
                                        : Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: provider.selectedPage >= i
                                            ? Colors.transparent
                                            : cc.greyFive)),
                                child: provider.selectedPage - 1 < i
                                    ? Text(
                                        '${i + 1}',
                                        style: TextStyle(
                                            color: provider.selectedPage >= i
                                                ? Colors.white
                                                : cc.greyPrimary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : const Icon(
                                        Icons.check_outlined,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                              ),
                              //line
                              i > 1
                                  ? Container()
                                  : Container(
                                      height: 3,
                                      width: screenWidth / 2 - 85,
                                      color: provider.selectedPage >= i
                                          ? cc.primaryColor
                                          : cc.greyFive,
                                    )
                            ],
                          ),
                      ],
                    ),

                    const SizedBox(
                      height: 35,
                    ),

                    //Slider =============>
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: SizedBox(
                          height: 750,
                          child: PageView.builder(
                              controller:
                                  context.read<SignupService>().pagecontroller,
                              physics: const NeverScrollableScrollPhysics(),
                              onPageChanged: (value) {
                                provider.setSelectedPage(value);
                              },
                              itemCount: 3,
                              // physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, i) {
                                if (i == 0) {
                                  return SignupEmailName(
                                    fullNameController: fullNameController,
                                    emailController: emailController,
                                    userNameController: userNameController,
                                  );
                                } else if (i == 1) {
                                  return SignupPhonePass(
                                    passController: newPasswordController,
                                    repeatPassController:
                                        repeatNewPasswordController,
                                    numberController: numberController,
                                  );
                                } else {
                                  return SignupCountryStates(
                                    emailController: emailController,
                                    fullNameController: fullNameController,
                                    passController: newPasswordController,
                                    userNameController: userNameController,
                                  );
                                }
                              }),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
