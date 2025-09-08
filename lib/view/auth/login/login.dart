import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:qixer/generated/app_localizations.dart';
import 'package:qixer/helper/SharedPreferencesHelper.dart';
import 'package:qixer/model/navigationModel.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/auth_services/login_service.dart';
import 'package:qixer/service/auth_services/signup_service.dart';
import 'package:qixer/view/auth/OtpVerifyPage.dart';
import 'package:qixer/view/auth/signup/signupVenderView.dart';
import 'package:qixer/view/home/landing_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
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
  final scaffoldKey = GlobalKey();

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  bool shashaktnirman_is_logged_in = true;
  @override
  void initState() {
    super.initState();

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

  Future<void> loginFunction(
      BuildContext context, LoginService provider, String phoneNumber) async {
    if (!provider.isloading) {
      if (_formKey.currentState?.validate() ?? false) {
        // bool otpSent = await provider.sendOTPWithFirebase(
        //   context: context,
        //   phoneNumber: "+91$phoneNumber",
        // );

        bool otpSent = await provider.sendOTP(
          phoneNumber,
          widget.navigationModel?.roleType.toString(),
          context,
          isFromLoginPage: true,
        );

        if (otpSent) {
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
        } else {
          OthersHelper().showToast(
              'Failed to send OTP. Please try again.', cc.errorColor);
        }
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
            AppLocalizations.of(context)!.enterOtp,
          ),
          SizedBox(height: 16),
          Pinput(
            length: 6,
            controller: otpController,
            // Configure Pinput as needed
          ),
          SizedBox(height: 16),
          CommonHelper()
              .buttonOrange(AppLocalizations.of(context)!.continueText, () {
            if (otpController.text.isEmpty) {
              OthersHelper().showToast(
                AppLocalizations.of(context)!.pleaseEnterOtp,
                ConstantColors().warningColor,
              );
            } else {
              // provider
              //     .verifyOTP(
              //         context: context,
              //         smsCode: otpController.text.toString(),
              //         verificationId: provider.verificationId.toString())
              //     .then(
              //   (userCred) {
              //     if (userCred?.user != null) {
              //       provider
              //           .otpVerify(
              //               numberController.text.toString(),
              //               userCred?.user?.uid.toString() ?? '',
              //               widget.navigationModel?.roleType.toString(),
              //               context,
              //               true)
              //           .then(
              //         (value) async {
              //           if (value != null) {
              //             if (value.status == true) {
              //               OthersHelper().showToast(
              //                 AppLocalizations.of(context)!
              //                     .otpVerificationSuccess,
              //                 ConstantColors().successColor,
              //               );
              //               SharedPreferencesHelper.setData(value);
              //               print(
              //                   "value type is new ====> ${value.user?.isNew}");
              //               if (value.user?.isNew == 0) {
              //                 if (value.user?.userType == 0) {
              //                   final prefs =
              //                       await SharedPreferences.getInstance();
              //                   prefs.setBool(
              //                       'shashaktnirman_is_logged_in', false);
              //                   Navigator.of(context).push(MaterialPageRoute(
              //                       builder: (context) =>
              //                           SignUpVendorView()));
              //                 } else {
              //                   Navigator.of(context).push(
              //                     MaterialPageRoute(
              //                         builder: (context) => LandingPage()),
              //                   );
              //                 }
              //               } else {
              //                 SharedPreferencesHelper.setData(value);
              //                 if (mounted) {
              //                   Navigator.of(context).pushAndRemoveUntil(
              //                     MaterialPageRoute(
              //                         builder: (context) => LandingPage()),
              //                     (route) => false,
              //                   );
              //                 }
              //               }
              //             } else {
              //               OthersHelper().showToast(
              //                 AppLocalizations.of(context)!
              //                     .otpVerificationFailed,
              //                 ConstantColors().warningColor,
              //               );
              //             }
              //           } else {
              //             OthersHelper().showToast(
              //               AppLocalizations.of(context)!
              //                   .otpVerificationFailed,
              //               ConstantColors().warningColor,
              //             );
              //           }
              //         },
              //       );
              //     } else {
              //       OthersHelper()
              //           .showToast("OTP Verification Failed!", cc.errorColor);
              //     }
              //   },
              // );

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
                      AppLocalizations.of(context)!.otpVerificationSuccess,
                      ConstantColors().successColor,
                    );
                    SharedPreferencesHelper.setData(value);
                    print("value type is new ====> ${value.user?.isNew}");
                    if (value.user?.isNew == 0) {
                      if (value.user?.userType == 0) {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool('shashaktnirman_is_logged_in', false);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignUpVendorView()));
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => LandingPage()),
                        );
                      }
                    } else {
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
                      AppLocalizations.of(context)!.otpVerificationFailed,
                      ConstantColors().warningColor,
                    );
                  }
                } else {
                  OthersHelper().showToast(
                    AppLocalizations.of(context)!.otpVerificationFailed,
                    ConstantColors().warningColor,
                  );
                }
              });
              // Navigator.pop(context);
            }
          }, isloading: provider.isloading2),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    final loginController = Provider.of<LoginService>(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: CommonHelper().appbarCommon(
        AppLocalizations.of(context)!.login,
        context,
        () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: CustomScrollView(
          physics: physicsCommon,
          slivers: [
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
                                AppLocalizations.of(context)!.welcomeBackLogin,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                AppLocalizations.of(context)!.loginViewText,
                                style: TextStyle(
                                  color: cc.greyThree,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 25),
                              CommonHelper().labelCommon(
                                AppLocalizations.of(context)!.mobileNumber,
                              ),
                              Consumer<RtlService>(
                                builder: (context, rtlP, child) =>
                                    IntlPhoneField(
                                  controller: numberController,
                                  decoration:
                                      SignupHelper().phoneFieldDecoration(),
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  searchText: AppLocalizations.of(context)!
                                      .searchCountry,
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
                                    provider
                                        .setCountryCode(phone.countryISOCode);

                                    provider.setPhone(phone.completeNumber);
                                  },
                                  validator: (p0) {
                                    if (p0?.number.length != 10) {
                                      return AppLocalizations.of(context)!
                                          .numberValidation;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 25),
                              const SizedBox(height: 13),
                              CommonHelper().buttonOrange(
                                AppLocalizations.of(context)!.continueText,
                                () async {
                                  if (numberController.text.trim().isEmpty ||
                                      numberController.text.trim().length !=
                                          10 ||
                                      !RegExp(r'^[0-9]{10}$').hasMatch(
                                          numberController.text.trim())) {
                                    OthersHelper().showToast(
                                        AppLocalizations.of(context)!
                                            .invalidMobileNumber,
                                        ConstantColors().warningColor);
                                  } else {
                                    loginController
                                        .sendOTPWithFirebase(
                                            phoneNumber:
                                                "+91${numberController.text.toString()}",
                                            context: context)
                                        .then(
                                      (value) {
                                        if (value == true) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  ChangeNotifierProvider.value(
                                                value:
                                                    Provider.of<LoginService>(
                                                        context,
                                                        listen: false),
                                                child: OtpVerifyPage(
                                                  navigationModel:
                                                      NavigationModel(
                                                    isLoggedIn: false,
                                                    navFrom: "login",
                                                    pageName: numberController
                                                        .text
                                                        .toString(),
                                                    roleType: widget
                                                        .navigationModel
                                                        ?.roleType
                                                        .toString(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        } else {
                                          final errorMessage = loginController
                                              .verificationErrorMessage;
                                          OthersHelper()
                                              .showCompactSuccessDialog2(
                                            context,
                                            image: "assets/icons/error.gif",
                                            messageType: "Error",
                                            messageTitle: "Error",
                                            message: errorMessage.toString(),
                                            onTap: () =>
                                                Navigator.of(context).pop(),
                                          );
                                        }
                                      },
                                    );
                                  }
                                },
                                isloading: loginController.isloading == false
                                    ? false
                                    : true,
                              ),
                              const SizedBox(
                                height: 100,
                              ),
                              // const FadingNote(),
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
      ),
    );
  }
}

class FadingNote extends StatefulWidget {
  const FadingNote({super.key});

  @override
  State<FadingNote> createState() => _FadingNoteState();
}

class _FadingNoteState extends State<FadingNote> {
  double _opacity = 1.0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // Start fading loop
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _opacity = _opacity == 1.0 ? 0.0 : 1.0;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Clean up timer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(seconds: 2),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(fontSize: 14, color: Colors.black),
            children: [
              TextSpan(
                text: 'Note: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              TextSpan(
                text:
                    'After clicking Continue, please don’t press back or refresh. ',
              ),
              TextSpan(
                text:
                    'A verification code is being sent — just wait a moment.\n\n',
              ),
              TextSpan(
                text: 'नोट: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              TextSpan(
                text:
                    'Continue पर क्लिक करने के बाद पीछे न जाएं या ऐप को बंद न करें। ',
              ),
              TextSpan(
                text:
                    'verification code भेजा जा रहा है — कृपया थोड़ी देर प्रतीक्षा करें।',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
