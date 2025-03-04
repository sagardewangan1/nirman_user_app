import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/SharedPreferencesHelper.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/model/navigationModel.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/auth_services/login_service.dart';
import 'package:qixer/service/auth_services/signup_service.dart';
import 'package:qixer/view/auth/signup/signup.dart';
import 'package:qixer/view/auth/signup/signupVenderView.dart';
import 'package:qixer/view/home/landing_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../service/rtl_service.dart';
import '../../utils/constant_styles.dart';
import '../signup/signup_helper.dart';

class LoginPage extends StatefulWidget {
  final NavigationModel? navigationModel;
  const LoginPage({super.key, this.hasBackButton = true, this.navigationModel});
  final hasBackButton;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late bool _passwordVisible;
  @override
  void initState() {
    super.initState();
    print("navigationModel =====> ${widget.navigationModel?.roleType}");
    _passwordVisible = false;
    initPassword();
  }

  initPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    shashaktnirman_is_logged_in =
        prefs.getBool('shashaktnirman_is_logged_in') ?? true;
    String? email;
    String? pass;
    String? number;
    if (shashaktnirman_is_logged_in) {
      email = prefs.getString('email');
      pass = prefs.getString("pass");
      number = prefs.getString("number");
    }
    emailController.text = email ?? "";
    passwordController.text = pass ?? "";
    numberController.text = number ?? "";
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  bool shashaktnirman_is_logged_in = true;

  Future<void> loginFunction(context, LoginService provider) async {
    if (provider.isloading == false) {
      if (_formKey.currentState?.validate() ?? false) {
        provider
            .sendOTP(
          numberController.text.trim(),
          widget.navigationModel?.roleType.toString(),
          context,
          false,
        )
            .then((value) {
          if (value == true) {
            showModalBottomSheet(
              isDismissible: false,
              backgroundColor: Colors.transparent,
              enableDrag: false,
              isScrollControlled: true,
              context: context,
              builder: (modalContext) {
                final keyboardVisible =
                    MediaQuery.of(modalContext).viewInsets.bottom > 0;
                final initialChildSize = keyboardVisible ? 0.57 : 0.27;
                return DraggableScrollableSheet(
                  expand: false,
                  maxChildSize: 0.6,
                  initialChildSize: initialChildSize,
                  minChildSize: 0,
                  builder: (modalContext, scrollController) {
                    return otpVerify(context, provider);
                  },
                );
              },
            ).whenComplete(() {
              otpController.clear();
            });
          }
        });
      }
    }
  }

  Container otpVerify(BuildContext context, LoginService provider) {
    return Container(
      padding: EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonHelper().titleCommon(
            lnProvider.getString('Enter OTP'),
          ),
          SizedBox(height: 16),
          Pinput(
            length: 6,
            controller: otpController,
            // Configure Pinput as needed
          ),
          SizedBox(height: 16),
          CommonHelper().buttonOrange(
            lnProvider.getString("Continue"),
            () {
              if (otpController.text.isEmpty) {
                OthersHelper().showToast(
                  "Please Enter OTP",
                  ConstantColors().warningColor,
                );
              } else {
                provider
                    .otpVerify(
                  numberController.text.trim(),
                  otpController.text.trim(),
                  widget.navigationModel?.roleType.toString() ?? "",
                  context,
                  false,
                )
                    .then((value) async {
                  if (value != null) {
                    if (value.status == true) {
                      OthersHelper().showToast(
                        "OTP Verification Success",
                        ConstantColors().successColor,
                      );
                      SharedPreferencesHelper.setData(value);
                      print("value type is new ====> ${value.user?.isNew}");
                      if (value.user?.isNew == 0) {
                        if (value.user?.userType == 0) {
                          // context.toPage(const SignUpVendorView());
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignUpVendorView()));
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => LandingPage()),
                          );
                        }
                      } else {
                        final prefs = await SharedPreferences.getInstance();
                        SharedPreferencesHelper.setData(value);
                        if (mounted) {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LandingPage()),
                            (route) => false,
                          );
                        }
                      }
                    } else {
                      OthersHelper().showToast(
                        "OTP Verification Failed",
                        ConstantColors().warningColor,
                      );
                    }
                  } else {
                    OthersHelper().showToast(
                      "OTP Verification Failed",
                      ConstantColors().warningColor,
                    );
                  }
                });
                // Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    final loginController = Provider.of<LoginService>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonHelper().appbarCommon(
        "Login",
        context,
        () => Navigator.pop(context),
      ),
      body: CustomScrollView(
        physics: physicsCommon,
        slivers: [
          // SliverAppBar.large(
          //   leading: IconButton(
          //     onPressed: () {
          //       debugPrint("Pressed back".toString());
          //       context.popFalse;
          //     },
          //     icon: const Icon(Icons.arrow_back_ios_new_rounded),
          //   ),
          //   flexibleSpace: Container(
          //     height: 230.0,
          //     width: double.infinity,
          //     decoration: const BoxDecoration(
          //       image: DecorationImage(
          //         image: AssetImage('assets/images/loginImageNirman.jpg'),
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          // ),
          Consumer<AppStringService>(
            builder: (context, asprovider, child) {
              return Consumer<SignupService>(
                builder: (context, provider, child) {
                  return Form(
                    key: _formKey,
                    child: SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            const SizedBox(height: 33),
                            CommonHelper().titleCommon(
                                lnProvider.getString('Welcome back! Login')),
                            const SizedBox(height: 10),
                            Text(
                              "Enter your mobile number below to receive a One-Time Password (OTP) for verification.",
                              style: TextStyle(
                                color: cc.greyThree,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 25),

                            CommonHelper().labelCommon(
                                lnProvider.getString("Mobile Number")),
                            Consumer<RtlService>(
                              builder: (context, rtlP, child) => IntlPhoneField(
                                controller: numberController,
                                decoration:
                                    SignupHelper().phoneFieldDecoration(),
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                searchText:
                                    asprovider.getString("Search country"),
                                initialCountryCode:
                                    context.read<SignupService>().countryCode,
                                disableLengthCheck: true,
                                textAlign: rtlP.direction == 'ltr'
                                    ? TextAlign.left
                                    : TextAlign.right,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(
                                      10), // Set max length to 10
                                  FilteringTextInputFormatter
                                      .digitsOnly, // Allow only numbers
                                ],
                                onChanged: (phone) {
                                  provider.setCountryCode(phone.countryISOCode);

                                  provider.setPhone(phone.completeNumber);
                                },
                                validator: (p0) {
                                  if (p0?.number.length != 10) {
                                    return "Please Enter Valid Mobile Number";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            // CustomInput(
                            //   controller: numberController,
                            //   validation: (value) {
                            //     if (value == null || value.isEmpty) {
                            //       return 'Please enter your mobile number';
                            //     }
                            //     if (value.length != 10) {
                            //       return 'Please enter valid mobile number';
                            //     }
                            //     return null;
                            //   },
                            //   hintText: lnProvider.getString("Phone"),
                            //   icon: 'assets/icons/user.png',
                            //   textInputAction: TextInputAction.next,
                            //   isNumberField: true,
                            //   inputType: [
                            //     FilteringTextInputFormatter.digitsOnly
                            //   ],
                            //   maxLength: 10,
                            //   autofillHints: const [
                            //     AutofillHints.telephoneNumber,
                            //   ],
                            // ),
                            const SizedBox(height: 25),

                            // CommonHelper()
                            //     .labelCommon(lnProvider.getString("Email or username")),
                            //
                            // CustomInput(
                            //   controller: emailController,
                            //   validation: (value) {
                            //     if (value == null || value.isEmpty) {
                            //       return 'Please enter your email or username';
                            //     }
                            //     return null;
                            //   },
                            //   hintText: lnProvider.getString("Email"),
                            //   icon: 'assets/icons/user.png',
                            //   textInputAction: TextInputAction.next,
                            //   maxLength: 10,
                            //   autofillHints: const [
                            //     AutofillHints.username,
                            //     AutofillHints.email
                            //   ],
                            // ),
                            // const SizedBox(height: 25),

                            // CommonHelper()
                            //     .labelCommon(lnProvider.getString("Password")),
                            // Container(
                            //   margin: const EdgeInsets.only(bottom: 19),
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(10),
                            //   ),
                            //   child: TextFormField(
                            //     controller: passwordController,
                            //     textInputAction: TextInputAction.next,
                            //     obscureText: !_passwordVisible,
                            //     style: const TextStyle(fontSize: 14),
                            //     autofillHints: const [AutofillHints.password],
                            //     validator: (value) {
                            //       if (value == null || value.isEmpty) {
                            //         return lnProvider
                            //             .getString('Please enter your password');
                            //       }
                            //       return null;
                            //     },
                            //     decoration: InputDecoration(
                            //       prefixIcon: Column(
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         children: [
                            //           Container(
                            //             height: 22.0,
                            //             width: 40.0,
                            //             decoration: const BoxDecoration(
                            //               image: DecorationImage(
                            //                   image:
                            //                       AssetImage('assets/icons/lock.png'),
                            //                   fit: BoxFit.fitHeight),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //       suffixIcon: IconButton(
                            //         splashColor: Colors.transparent,
                            //         highlightColor: Colors.transparent,
                            //         icon: Icon(
                            //           _passwordVisible
                            //               ? Icons.visibility_off_outlined
                            //               : Icons.visibility_outlined,
                            //           color: Colors.grey,
                            //           size: 22,
                            //         ),
                            //         onPressed: () {
                            //           setState(() {
                            //             _passwordVisible = !_passwordVisible;
                            //           });
                            //         },
                            //       ),
                            //       enabledBorder: OutlineInputBorder(
                            //         borderSide:
                            //             BorderSide(color: ConstantColors().greyFive),
                            //         borderRadius: BorderRadius.circular(9),
                            //       ),
                            //       focusedBorder: OutlineInputBorder(
                            //         borderSide: BorderSide(
                            //             color: ConstantColors().primaryColor),
                            //       ),
                            //       errorBorder: OutlineInputBorder(
                            //         borderSide: BorderSide(
                            //             color: ConstantColors().warningColor),
                            //       ),
                            //       focusedErrorBorder: OutlineInputBorder(
                            //         borderSide: BorderSide(
                            //             color: ConstantColors().primaryColor),
                            //       ),
                            //       hintText: lnProvider.getString('Enter password'),
                            //       contentPadding: const EdgeInsets.symmetric(
                            //           horizontal: 8, vertical: 18),
                            //     ),
                            //   ),
                            // ),

                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     Expanded(
                            //       child: CheckboxListTile(
                            //         checkColor: Colors.white,
                            //         activeColor: ConstantColors().primaryColor,
                            //         contentPadding: const EdgeInsets.all(0),
                            //         title: Container(
                            //           padding: const EdgeInsets.symmetric(vertical: 5),
                            //           child: Text(
                            //             lnProvider.getString("Remember Me"),
                            //             style: TextStyle(
                            //               color: ConstantColors().greyFour,
                            //               fontWeight: FontWeight.w400,
                            //               fontSize: 14,
                            //             ),
                            //           ),
                            //         ),
                            //         value: shashaktnirman_is_logged_in,
                            //         onChanged: (newValue) {
                            //           setState(() {
                            //             shashaktnirman_is_logged_in = !shashaktnirman_is_logged_in;
                            //           });
                            //         },
                            //         controlAffinity: ListTileControlAffinity.leading,
                            //       ),
                            //     ),
                            //     const SizedBox(width: 10),
                            //     InkWell(
                            //       onTap: () {
                            //         Navigator.push(
                            //           context,
                            //           MaterialPageRoute<void>(
                            //             builder: (BuildContext context) =>
                            //                 const ResetPassEmailPage(),
                            //           ),
                            //         );
                            //       },
                            //       child: SizedBox(
                            //         width: 122,
                            //         child: Text(
                            //           lnProvider.getString("Forgot Password?"),
                            //           style: TextStyle(
                            //             color: cc.primaryColor,
                            //             fontSize: 13,
                            //             fontWeight: FontWeight.w600,
                            //           ),
                            //         ),
                            //       ),
                            //     )
                            //   ],
                            // ),

                            const SizedBox(height: 13),

                            CommonHelper().buttonOrange(
                              lnProvider.getString("Continue"),
                              () async {
                                if (numberController.text.trim().isEmpty ||
                                    numberController.text.trim().length != 10 ||
                                    !RegExp(r'^[0-9]{10}$').hasMatch(
                                        numberController.text.trim())) {
                                  OthersHelper().showToast(
                                      "Invalid Mobile Number",
                                      ConstantColors().warningColor);
                                } else {
                                  await loginFunction(context, loginController);
                                }
                              },
                              isloading: loginController.isloading == false
                                  ? false
                                  : true,
                            ),

                            // Consumer<LoginService>(
                            //   builder: (context, provider, child) =>
                            //
                            // ),

                            // const SizedBox(height: 25),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     RichText(
                            //       text: TextSpan(
                            //         text: lnProvider.getString("Don't have account?") +
                            //             "  ",
                            //         style: const TextStyle(
                            //             color: Color(0xff646464), fontSize: 14),
                            //         children: [
                            //           TextSpan(
                            //             recognizer: TapGestureRecognizer()
                            //               ..onTap = () {
                            //                 Navigator.push(
                            //                   context,
                            //                   MaterialPageRoute(
                            //                     builder: (context) =>
                            //                         const SignupPage(),
                            //                   ),
                            //                 );
                            //               },
                            //             text: lnProvider.getString('Sign up'),
                            //             style: TextStyle(
                            //               fontWeight: FontWeight.w600,
                            //               fontSize: 14,
                            //               color: cc.primaryColor,
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),

                            // Additional components for 'Login with Google', 'Login with Facebook', etc.

                            // Divider (or)
                            const SizedBox(
                              height: 30,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: [
                            //     Expanded(
                            //         child: Container(
                            //       height: 1,
                            //       color: cc.greyFive,
                            //     )),
                            //     Container(
                            //       width: 40,
                            //       alignment: Alignment.center,
                            //       margin: const EdgeInsets.only(bottom: 25),
                            //       child: Text(
                            //         lnProvider.getString("OR"),
                            //         style: TextStyle(
                            //             color: cc.greyPrimary,
                            //             fontSize: 17,
                            //             fontWeight: FontWeight.w600),
                            //       ),
                            //     ),
                            //     Expanded(
                            //         child: Container(
                            //       height: 1,
                            //       color: cc.greyFive,
                            //     )),
                            //   ],
                            // ),
                            //
                            // // login with google, facebook button ===========>
                            // const SizedBox(
                            //   height: 20,
                            // ),
                            // Consumer<GoogleSignInService>(
                            //   builder: (context, gProvider, child) => InkWell(
                            //       onTap: () {
                            //         if (gProvider.isloading == false) {
                            //           gProvider.googleLogin(context);
                            //         }
                            //       },
                            //       child: LoginHelper().commonButton(
                            //           'assets/icons/google.png',
                            //           lnProvider.getString("Login with Google"),
                            //           isloading:
                            //               gProvider.isloading == false ? false : true)),
                            // ),
                            //
                            // if (Platform.isIOS) ...[
                            //   const SizedBox(height: 20),
                            //   Consumer<AppleSignInService>(
                            //     builder: (context, gProvider, child) => InkWell(
                            //         onTap: () async {
                            //           if (gProvider.isloading == false) {
                            //             gProvider.setLoadingTrue();
                            //             await gProvider
                            //                 .appleLogin(context, autoLogin: true)
                            //                 .then((value) async {
                            //               if (value == true) {
                            //                 // Navigator.of(context).pop();
                            //                 await Provider.of<ProfileService>(context,
                            //                         listen: false)
                            //                     .fetchData();
                            //                 context.popTrue;
                            //               }
                            //             }).onError((error, stackTrace) =>
                            //                     gProvider.setLoadingFalse());
                            //             gProvider.setLoadingFalse();
                            //           }
                            //         },
                            //         child: LoginHelper().commonButton(
                            //             'assets/icons/apple.png',
                            //             ("Sign in with Apple").tr(),
                            //             isloading: gProvider.isloading == false
                            //                 ? false
                            //                 : true)),
                            //   )
                            // ],
                            // const SizedBox(
                            //   height: 20,
                            // ),
                            // Consumer<FacebookLoginService>(
                            //   builder: (context, fProvider, child) => InkWell(
                            //     onTap: () {
                            //       if (fProvider.isloading == false) {
                            //         fProvider.checkIfLoggedIn(context);
                            //       }
                            //     },
                            //     child: LoginHelper().commonButton(
                            //         'assets/icons/facebook.png',
                            //         lnProvider.getString("Login with Facebook"),
                            //         isloading:
                            //             fProvider.isloading == false ? false : true),
                            //   ),
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: [
                            //     Expanded(
                            //       child: CommonHelper().buttonOrange(
                            //         "Signup user",
                            //         () => context.toPage(SignupPage()),
                            //       ),
                            //     ),
                            //     SizedBox(width: 10),
                            //     Expanded(
                            //       child: CommonHelper().buttonOrange(
                            //         "Signup vender",
                            //         () => context.toPage(SignUpVendorView(
                            //             navigationModel: NavigationModel())),
                            //       ),
                            //     )
                            //   ],
                            // ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
