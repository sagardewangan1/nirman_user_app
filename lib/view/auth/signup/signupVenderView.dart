import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/model/navigationModel.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/dropdowns_services/state_dropdown_services.dart';
import 'package:qixer/view/auth/signup/pages/signupVenderEmailName.dart';
import 'package:qixer/view/auth/signup/pages/signupVendorBussinessDetails.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../service/auth_services/signUpVendorService.dart';
import '../../../service/auth_services/signup_service.dart';
import '../../utils/common_helper.dart';

class SignUpVendorView extends StatefulWidget {
  final NavigationModel? navigationModel;
  const SignUpVendorView({super.key, this.navigationModel});

  @override
  State<SignUpVendorView> createState() => _SignUpVendorViewState();
}

class _SignUpVendorViewState extends State<SignUpVendorView> {
  ConstantColors cc = ConstantColors();
  // Basic Details
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  // Basic Details
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessMobileNumberController =
      TextEditingController();
  TextEditingController businessEmailController = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();
  TextEditingController businessStateController = TextEditingController();
  TextEditingController businessCityController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();
  TextEditingController businessDescription = TextEditingController();

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
    print("is logged in ====> ${shashaktnirman_is_logged_in}");
    email = prefs.getString('shashaktnirmanemail');
    pass = prefs.getString("pass");
    number = prefs.getString("shashaktnirmanphone");
    print("number===> $number");
    print("email===> ${prefs.getString('shashaktnirmanemail')}");

    if (email != null) {
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
  void initState() {
    initPassword();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<AppStringService>(
      builder: (context, asProvider, child) => Consumer<SignupVendorService>(
        builder: (context, provider, child) => WillPopScope(
          onWillPop: () {
            if (provider.selectedPage == 0) {
              context.read<StateDropdownService>().setStateDefault();
              return Future.value(true);
            } else {
              context.read<SignupVendorService>().pagecontroller.animateToPage(
                  provider.selectedPage - 1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease);
              return Future.value(false);
            }
            // return Future.value(false);
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: CommonHelper().appbarCommon(
                AppLocalizations.of(context)!.addYourDetails, context, () {
              if (provider.selectedPage == 0) {
                Navigator.pop(context);
              } else {
                context
                    .read<SignupVendorService>()
                    .pagecontroller
                    .animateToPage(provider.selectedPage - 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease);
              }
            }),
            body: Listener(
              onPointerDown: (_) {
                debugPrint("Listener is working---------------------------"
                    .toString());
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
                      child: CommonHelper().titleCommon(
                          AppLocalizations.of(context)!.shareSubject),
                    ),

                    const SizedBox(
                      height: 35,
                    ),

                    //Page steps show =======>

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var i = 0; i < 2; i++)
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
                              i > 0
                                  ? Container()
                                  : Container(
                                      height: 3,
                                      width: size.width / 2 - 85,
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
                      child: PageView.builder(
                          controller: context
                              .read<SignupVendorService>()
                              .pagecontroller,
                          physics: const NeverScrollableScrollPhysics(),
                          onPageChanged: (value) {
                            provider.setSelectedPage(value);
                          },
                          itemCount: 2,
                          // physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            if (i == 0) {
                              return SignupVendorEmailName(
                                fullNameController: fullNameController,
                                userNameController: userNameController,
                                emailController: emailController,
                                phoneController: numberController,
                              );
                            } else {
                              return SignupVendorBusinessDetails(
                                state: businessStateController,
                                city: businessCityController,
                                fullNameController: fullNameController,
                                userNameController: userNameController,
                                emailController: emailController,
                                phoneController: numberController,
                              );
                              // } else {
                              return Text("Kya Dalu Yaha Par");
                              // return SignupCountryStates(
                              //   emailController: emailController,
                              //   fullNameController: fullNameController,
                              //   passController: newPasswordController,
                              //   userNameController:
                              //       userNameContrtoPageoller,
                              // );
                            }
                          }),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
