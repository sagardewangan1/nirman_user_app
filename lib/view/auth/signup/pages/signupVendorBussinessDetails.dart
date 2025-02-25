import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/model/navigationModel.dart';
import 'package:qixer/service/auth_services/signUpVendorService.dart';
import 'package:qixer/view/auth/signup/pages/tac_pp.dart';
import 'package:qixer/view/chooseCategory/chooseCategorView.dart';
import '../../../../service/app_string_service.dart';
import '../../../utils/common_helper.dart';
import '../../../utils/constant_colors.dart';
import '../../../utils/custom_input.dart';
import '../../../utils/others_helper.dart';
import '../components/country_states_dropdowns.dart';

class SignupVendorBusinessDetails extends StatefulWidget {
  final TextEditingController businessName;
  final TextEditingController gstNumber;
  final TextEditingController businessAddress;
  final TextEditingController state;
  final TextEditingController city;
  final TextEditingController businessMobileNumber;
  final TextEditingController businessEmailNumber;
  final TextEditingController businessDescription;
  final TextEditingController fullNameController;
  final TextEditingController userNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;

  const SignupVendorBusinessDetails({
    super.key,
    required this.businessName,
    required this.gstNumber,
    required this.businessAddress,
    required this.businessMobileNumber,
    required this.businessEmailNumber,
    required this.businessDescription,
    required this.state,
    required this.city,
    required this.fullNameController,
    required this.userNameController,
    required this.phoneController,
    required this.emailController,
  });

  @override
  State<SignupVendorBusinessDetails> createState() =>
      _SignupVendorBusinessDetailsState();
}

class _SignupVendorBusinessDetailsState
    extends State<SignupVendorBusinessDetails> {
  final _formKey = GlobalKey<FormState>();

  bool termsAgree = false;

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    return Consumer<AppStringService>(
      builder: (context, asProvider, child) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _formKey,
          child: ListView(
            clipBehavior: Clip.none,
            // physics: NeverScrollableScrollPhysics(),
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              CommonHelper().titleCommon(
                asProvider.getString("Fill your business details"),
              ),
              const SizedBox(height: 18),

              // Business Name
              CommonHelper().labelCommon(
                asProvider.getString("Business Name"),
              ),
              CustomInput(
                controller: widget.businessName,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return asProvider
                        .getString("Please enter your business name");
                  }
                  return null;
                },
                hintText: asProvider.getString("Enter your business name"),
                icon: 'assets/icons/business.png',
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 18),

              // GST Number
              CommonHelper().labelCommon(
                asProvider.getString("Business GST Number"),
              ),
              CustomInput(
                controller: widget.gstNumber,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return asProvider.getString("Please enter your GST number");
                  }
                  return null;
                },
                hintText: asProvider.getString("Enter your GST Number"),
                icon: 'assets/icons/gstn.png',
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 18),

              // Phone Number
              CommonHelper().labelCommon(
                asProvider.getString("Business Phone Number"),
              ),
              CustomInput(
                controller: widget.businessMobileNumber,
                isNumberField: true,
                inputType: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 10,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return asProvider
                        .getString("Please enter your Phone number");
                  }
                  return null;
                },
                hintText: asProvider.getString("Enter your Phone Number"),
                icon: 'assets/icons/phone.png',
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 18),

              // Email Number
              CommonHelper().labelCommon(
                asProvider.getString("Business Email"),
              ),
              CustomInput(
                controller: widget.businessEmailNumber,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return asProvider
                        .getString("Please enter your Business Email");
                  }
                  return null;
                },
                hintText: asProvider.getString("Enter your Business Email"),
                icon: 'assets/icons/email.png',
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 18),

              // Address
              CommonHelper().labelCommon(
                asProvider.getString("Business Address"),
              ),
              CustomInput(
                controller: widget.businessAddress,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return asProvider
                        .getString("Please enter your Business Address");
                  }
                  return null;
                },
                hintText: asProvider.getString("Enter your Business Address"),
                // icon: 'assets/icons/address.png',
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 18),

              const CountryStatesDropdowns(),
              //Agreement checkbox ===========>
              const SizedBox(
                height: 17,
              ),

              //Login button ==================>

              // // Address
              // CommonHelper().labelCommon(
              //   asProvider.getString("State"),
              // ),
              // // State
              // CustomInput(
              //   controller: widget.state,
              //   validation: (value) {
              //     if (value == null || value.isEmpty) {
              //       return asProvider
              //           .getString("Please enter your Business State");
              //     }
              //     return null;
              //   },
              //   hintText: asProvider.getString("Enter your Business State"),
              //   // icon: 'assets/icons/address.png',
              //   textInputAction: TextInputAction.next,
              // ),
              // const SizedBox(height: 18),
              //
              // // City
              // // Address
              // CommonHelper().labelCommon(
              //   asProvider.getString("City"),
              // ),
              // CustomInput(
              //   controller: widget.city,
              //   validation: (value) {
              //     if (value == null || value.isEmpty) {
              //       return asProvider
              //           .getString("Please enter your Business City");
              //     }
              //     return null;
              //   },
              //   hintText: asProvider.getString("Enter your Business City"),
              //   // icon: 'assets/icons/address.png',
              //   textInputAction: TextInputAction.next,
              // ),
              const SizedBox(height: 18),

              // Description
              CommonHelper().labelCommon(
                asProvider.getString("Business Description"),
              ),
              Consumer<SignupVendorService>(
                builder: (context, sginupProvider, child) {
                  return CustomInput(
                    controller: widget.businessDescription,
                    // maxLines: 5,
                    maxLength: 500,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return asProvider.getString(
                            "Please enter your Business Description");
                      }
                      return null;
                    },
                    counterText:
                        "${sginupProvider.currentOverviewLength}/${sginupProvider.totalLength}",
                    onChanged: (p0) {
                      sginupProvider.setOverviewLength(p0.length);
                    },
                    hintText:
                        asProvider.getString("Enter your Business Description"),
                    textInputAction: TextInputAction.next,
                  );
                },
              ),
              const SizedBox(height: 18),
              Row(children: [
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: ConstantColors().primaryColor,
                  value: termsAgree,
                  onChanged: (newValue) {
                    setState(() {
                      termsAgree = !termsAgree;
                    });
                  },
                ),
                Expanded(
                  flex: 1,
                  child: RichText(
                    softWrap: true,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                        text: asProvider.getString("I agree to") + " ",
                        style: TextStyle(
                          color: cc.black5,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.toPage(const TacPP(
                                    route: "/terms-and-condition",
                                  ));
                                  FocusScope.of(context).unfocus();
                                },
                              text: asProvider.getString("Terms & Conditions"),
                              style: TextStyle(
                                color: cc.primaryColor,
                                fontWeight: FontWeight.w600,
                              )),
                          TextSpan(
                              text: "${" " + asProvider.getString("and")} ",
                              style: TextStyle(color: cc.black5)),
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.toPage(const TacPP(
                                    route: "/privacy-policy",
                                  ));
                                  FocusScope.of(context).unfocus();
                                },
                              text: asProvider.getString("Privacy policy"),
                              style: TextStyle(
                                color: cc.primaryColor,
                                fontWeight: FontWeight.w600,
                              )),
                        ]),
                  ),
                ),
              ]),
              const SizedBox(height: 18),

              // Continue Button
              Consumer<SignupVendorService>(
                builder: (context, provider, child) => CommonHelper()
                    .buttonOrange(asProvider.getString("Continue"), () {
                  if (_formKey.currentState!.validate()) {
                    if (termsAgree == false) {
                      OthersHelper().showToast(
                          asProvider.getString(
                              "You must agree with the terms and conditions to register"),
                          Colors.black);
                    } else {
                      if (provider.isloading == false) {
                        provider.signupvendor(
                            widget.fullNameController.text.toString(),
                            widget.emailController.text.toString(),
                            widget.phoneController.text.toString(),
                            widget.businessName.text.toString(),
                            widget.gstNumber.text.toString(),
                            widget.businessMobileNumber.text.toString(),
                            widget.businessEmailNumber.text.toString(),
                            widget.businessAddress.text.toString(),
                            widget.businessDescription.text.toString(),
                            context);
                        context.toPage(ChooseCategoryView(),
                            arguments: NavigationModel(
                              navFrom: "SignUp",
                              roleType: "Vendor",
                              pageName: "Choose Category",
                            ));
                      }
                    }
                  }
                }, isloading: provider.isloading == false ? false : true),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
