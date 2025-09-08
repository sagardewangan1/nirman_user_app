import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/SharedPreferencesHelper.dart';
import 'package:qixer/model/navigationModel.dart';
import 'package:qixer/service/auth_services/login_service.dart';
import 'package:qixer/view/auth/signup/signup.dart';
import 'package:qixer/view/auth/signup/signupVenderView.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/common_service.dart';
import '../home/landing_page.dart';

class OtpVerifyPage extends StatefulWidget {
  final NavigationModel? navigationModel;
  const OtpVerifyPage({Key? key, required this.navigationModel})
      : super(key: key);

  @override
  State<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginService = Provider.of<LoginService>(context);
    return Scaffold(
      appBar: CommonHelper()
          .appbarCommon("Verify OTP", context, () => Navigator.pop(context)),
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              SizedBox(height: 24),
              Text(
                textAlign: TextAlign.left,
                "OTP has been sent to +91${widget.navigationModel?.pageName.toString()}. "
                "Check your messages for the 6-digit code and enter it below to proceed.",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 24),
              CommonHelper().labelCommon("Enter OTP"),
              Pinput(
                length: 6,
                controller: otpController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (val) =>
                    (val?.length == 6) ? null : "Enter 6-digit OTP",
              ),
              SizedBox(height: 24),
              CommonHelper().buttonOrange(
                "Verify OTP",
                () {
                  final code = otpController.text.trim();
                  if (code.length != 6) {
                    OthersHelper()
                        .toastShort("Please enter valid OTP", cc.warningColor);
                    return;
                  }
                  loginService
                      .verifyOTP(
                    verificationId: loginService.verificationId ?? '',
                    smsCode: code,
                    context: context,
                  )
                      .then(
                    (userCred) {
                      if (userCred?.user != null) {
                        loginService
                            .otpVerify(
                          widget.navigationModel?.pageName.toString() ?? '',
                          otpController.text.toString(),
                          widget.navigationModel?.roleType.toString(),
                          context,
                          true,
                        )
                            .then((value) async {
                          if (value != null) {
                            if (value.status == true) {
                              SharedPreferencesHelper.setData(value);
                              if (value.user?.userType == 0) {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setBool(
                                    'local_loops_user_is_logged_in', true);
                                if (value.user?.isNew == 0) {
                                  OthersHelper().showCompactSuccessDialog2(
                                    context,
                                    image: "assets/icons/like.gif",
                                    messageType: "Success",
                                    messageTitle: "Success",
                                    message: "OTP Verified Successfully!",
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  ).whenComplete(
                                    () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SignUpVendorView(),
                                      ),
                                    ),
                                  );
                                } else {
                                  OthersHelper().showCompactSuccessDialog2(
                                    context,
                                    image: "assets/icons/like.gif",
                                    messageType: "Success",
                                    messageTitle: "Success",
                                    message: "OTP Verified Successfully!",
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  ).whenComplete(
                                    () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LandingPage()),
                                        (route) => false,
                                      );
                                    },
                                  );
                                }
                                otpController.clear();
                              } else {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setBool(
                                    'local_loops_user_is_logged_in', true);
                                if (value.user?.isNew == 0) {
                                  OthersHelper().showCompactSuccessDialog2(
                                    context,
                                    image: "assets/icons/like.gif",
                                    messageType: "Success",
                                    messageTitle: "Success",
                                    message: "OTP Verified Successfully!",
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  ).whenComplete(
                                    () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => SignupPage(),
                                      ),
                                    ),
                                  );
                                } else {
                                  OthersHelper().showCompactSuccessDialog2(
                                    context,
                                    image: "assets/icons/like.gif",
                                    messageType: "Success",
                                    messageTitle: "Success",
                                    message: "OTP Verified Successfully!",
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  ).whenComplete(
                                    () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LandingPage()),
                                        (route) => false,
                                      );
                                    },
                                  );
                                }
                              }
                            } else {
                              OthersHelper().showToast(
                                "Something went wrong an api",
                                ConstantColors().warningColor,
                              );
                            }
                          } else {
                            OthersHelper().showToast(
                              "Something went wrong",
                              ConstantColors().warningColor,
                            );
                          }
                        });
                      } else {
                        OthersHelper().showCompactSuccessDialog2(
                          context,
                          image: "assets/icons/error.gif",
                          messageType: "Error",
                          messageTitle: "Error",
                          message: "OTP Verification Failed",
                          onTap: () => Navigator.of(context).pop(),
                        );
                      }
                    },
                  );
                },
                isloading: loginService.isLoadingVerifyOTP,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// provider
//     .sendOTPWithFirebase(
//         phoneNumber:
//             "+91${numberController.text.toString()}",
//         context: context)
//     .then(
//   (value) {
//     if (value) {
//       showModalBottomSheet(
//         showDragHandle: false,
//         isDismissible: false,
//         isScrollControlled: true,
//         context: context,
//         backgroundColor:
//             Colors.transparent,
//         builder: (contextDialogue) {
//           final isKeyboardOpen =
//               MediaQuery.of(context)
//                       .viewInsets
//                       .bottom >
//                   0;
//
//           return DraggableScrollableSheet(
//             expand: false,
//             initialChildSize:
//                 isKeyboardOpen
//                     ? 0.65
//                     : 0.35,
//             minChildSize:
//                 isKeyboardOpen
//                     ? 0.5
//                     : 0.2,
//             maxChildSize: 0.9,
//             builder: (contextDialogue,
//                 scrollController) {
//               return Consumer<
//                   LoginService>(
//                 builder: (context,
//                     loginService,
//                     child) {
//                   return Container(
//                     decoration:
//                         BoxDecoration(
//                       color: Colors
//                           .white,
//                       borderRadius:
//                           const BorderRadius
//                               .only(
//                         topRight: Radius
//                             .circular(
//                                 16),
//                         topLeft: Radius
//                             .circular(
//                                 16),
//                       ),
//                     ),
//                     child: Column(
//                       mainAxisSize:
//                           MainAxisSize
//                               .min,
//                       children: [
//                         const SizedBox(
//                             height:
//                                 10),
//                         const Text(
//                           "Enter OTP",
//                           style:
//                               TextStyle(
//                             fontSize:
//                                 18,
//                             fontWeight:
//                                 FontWeight
//                                     .bold,
//                           ),
//                         ),
//                         const SizedBox(
//                             height:
//                                 16),
//                         Padding(
//                           padding:
//                               const EdgeInsets
//                                   .all(
//                                   8.0),
//                           child:
//                               Pinput(
//                             length: 6,
//                             keyboardType:
//                                 TextInputType
//                                     .number,
//                             controller:
//                                 otpController,
//                             inputFormatters: [
//                               FilteringTextInputFormatter
//                                   .digitsOnly
//                             ],
//                             pinputAutovalidateMode:
//                                 PinputAutovalidateMode
//                                     .onSubmit,
//                             validator:
//                                 (value) {
//                               if (value ==
//                                       null ||
//                                   value.length !=
//                                       6) {
//                                 return 'Please enter a valid 6-digit OTP';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         const SizedBox(
//                             height:
//                                 16),
//                         Consumer<
//                                 LoginService>(
//                             builder: (context,
//                                 logService,
//                                 child) {
//                           return Padding(
//                             padding: const EdgeInsets
//                                 .all(
//                                 16.0),
//                             child: CommonHelper()
//                                 .buttonOrange(
//                               asProvider
//                                   .getString("Verify OTP"),
//                               () {
//                                 if (otpController.text.isEmpty ||
//                                     otpController.text.length != 6) {
//                                   OthersHelper().toastShort(
//                                     asProvider.getString("Please enter valid otp"),
//                                     cc.warningColor,
//                                   );
//                                   return;
//                                 }
//                                 // If OTP is valid
//                                 debugPrint(
//                                     "OTP====> ${otpController.text}");
//                                 loginController
//                                     .verifyOTP(verificationId: loginController.verificationId ?? '', smsCode: otpController.text.toString(), context: context)
//                                     .then(
//                                   (userCred) {
//                                     if (userCred?.user != null) {
//                                       loginService
//                                           .otpVerify(
//                                         numberController.text.trim(),
//                                         otpController.text.toString(),
//                                         context,
//                                         true,
//                                       )
//                                           .then((value) async {
//                                         if (value != null) {
//                                           if (value.status == true) {
//                                             SharedPreferencesHelper.setData(value);
//                                             if (value.user?.userType == 1) {
//                                               final prefs = await SharedPreferences.getInstance();
//                                               prefs.setBool('local_loops_user_is_logged_in', true);
//                                               if (value.user?.isNew == 0) {
//                                                 OthersHelper().showCompactSuccessDialog2(
//                                                   context,
//                                                   image: "assets/icons/like.gif",
//                                                   messageType: "Success",
//                                                   messageTitle: "Success",
//                                                   message: "OTP Verified Successfully!",
//                                                   onTap: () {
//                                                     Navigator.of(contextDialogue).pop();
//                                                   },
//                                                 ).whenComplete(
//                                                   () => Navigator.of(context).push(
//                                                     MaterialPageRoute(
//                                                       builder: (context) => SignUpView(
//                                                         mobileNumber: numberController.text.toString(),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 );
//                                               } else {
//                                                 OthersHelper().showCompactSuccessDialog2(
//                                                   context,
//                                                   image: "assets/icons/like.gif",
//                                                   messageType: "Success",
//                                                   messageTitle: "Success",
//                                                   message: "OTP Verified Successfully!",
//                                                   onTap: () {
//                                                     Navigator.of(contextDialogue).pop();
//                                                   },
//                                                 ).whenComplete(
//                                                   () {
//                                                     runAtHome(context);
//                                                     Navigator.of(context).pushAndRemoveUntil(
//                                                       MaterialPageRoute(builder: (context) => LandingPage()),
//                                                       (route) => false,
//                                                     );
//                                                   },
//                                                 );
//                                               }
//                                               otpController.clear();
//                                             }
//                                           } else {
//                                             OthersHelper().showToast(
//                                               "Something went wrong an api",
//                                               ConstantColors().warningColor,
//                                             );
//                                           }
//                                         } else {
//                                           OthersHelper().showToast(
//                                             "Something went wrong",
//                                             ConstantColors().warningColor,
//                                           );
//                                         }
//                                       });
//                                     } else {
//                                       OthersHelper().showCompactSuccessDialog2(
//                                         context,
//                                         image: "assets/icons/error.gif",
//                                         messageType: "Error",
//                                         messageTitle: "Error",
//                                         message: "OTP Verification Failed",
//                                         onTap: () => Navigator.of(contextDialogue).pop(),
//                                       );
//                                     }
//                                   },
//                                 );
//                               },
//                               isloading:
//                                   logService.isLoadingVerifyOTP,
//                             ),
//                           );
//                         }),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       );
//     } else {
//       final errorMessage = provider
//           .verificationErrorMessage;
//       OthersHelper()
//           .showCompactSuccessDialog2(
//         context,
//         image:
//             "assets/icons/error.gif",
//         messageType: "Error",
//         messageTitle: "Error",
//         message:
//             errorMessage.toString(),
//         onTap: () =>
//             Navigator.of(context)
//                 .pop(),
//       );
//     }
//   },
// );
