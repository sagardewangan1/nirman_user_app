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
  final TextEditingController state;
  final TextEditingController city;

  final TextEditingController? fullNameController;
  final TextEditingController? userNameController;
  final TextEditingController? phoneController;
  final TextEditingController? emailController;

  const SignupVendorBusinessDetails({
    super.key,
    required this.state,
    required this.city,
    this.fullNameController,
    this.userNameController,
    this.phoneController,
    this.emailController,
  });

  @override
  State<SignupVendorBusinessDetails> createState() =>
      _SignupVendorBusinessDetailsState();
}

class _SignupVendorBusinessDetailsState
    extends State<SignupVendorBusinessDetails> {
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController gstNumberController = TextEditingController();
  final TextEditingController businessAddressController =
      TextEditingController();
  final TextEditingController businessMobileNumberController =
      TextEditingController();
  final TextEditingController businessEmailController = TextEditingController();
  final TextEditingController businessDescriptionController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool termsAgree = false;

  void _submit(BuildContext context, SignupVendorService provider) {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }
    if (!termsAgree) {
      OthersHelper().showToast(
        "You must agree with the terms and conditions to register",
        Colors.black,
      );
      return;
    }
    if (businessNameController.text.isEmpty) {
      OthersHelper()
          .showToast('Please Enter Business Name Required', cc.warningColor);
    }
    // Check each field and show a toast if it's empty
    if (businessNameController.text.isEmpty) {
      OthersHelper()
          .showToast('Please Enter Business Name Required', cc.warningColor);
      return;
    }

    if (gstNumberController.text.isEmpty) {
      OthersHelper()
          .showToast('Please Enter GST Number Required', cc.warningColor);
      return;
    }

    if (businessAddressController.text.isEmpty) {
      OthersHelper()
          .showToast('Please Enter Business Address Required', cc.warningColor);
      return;
    }

    if (businessMobileNumberController.text.isEmpty) {
      OthersHelper().showToast(
          'Please Enter Business Mobile Number Required', cc.warningColor);
      return;
    }

    if (businessEmailController.text.isEmpty) {
      OthersHelper()
          .showToast('Please Enter Business Email Required', cc.warningColor);
      return;
    }

    if (businessDescriptionController.text.isEmpty) {
      OthersHelper().showToast(
          'Please Enter Business Description Required', cc.warningColor);
      return;
    }

    // Proceed with signup if all fields are filled
    if (!provider.isloading) {
      provider.signupvendor(
        widget.fullNameController?.text ?? '',
        widget.emailController?.text ?? '',
        widget.phoneController?.text ?? '',
        businessNameController.text,
        gstNumberController.text,
        businessMobileNumberController.text,
        businessEmailController.text,
        businessAddressController.text,
        businessDescriptionController.text,
        context,
      );
    }
  }

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
              CommonHelper().labelCommon(asProvider.getString("Business Name"),
                  isRequired: true),
              CustomInput(
                controller: businessNameController,
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
                  isRequired: true),
              CustomInput(
                controller: gstNumberController,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter GST Number";
                  }
                  return null;
                },
                maxLength: 20,
                counterText: "",
                hintText: asProvider.getString("Enter your GST Number"),
                icon: 'assets/icons/gstn.png',
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 18),

              // Phone Number
              CommonHelper().labelCommon(
                  asProvider.getString("Business Phone Number"),
                  isRequired: true),
              CustomInput(
                controller: businessMobileNumberController,
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
              CommonHelper().labelCommon(asProvider.getString("Business Email"),
                  isRequired: true),
              CustomInput(
                controller: businessEmailController,
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
                  isRequired: true),
              CustomInput(
                controller: businessAddressController,
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
                  isRequired: true),
              Consumer<SignupVendorService>(
                builder: (context, sginupProvider, child) {
                  return CustomInput(
                    controller: businessDescriptionController,
                    // maxLines: 5,
                    maxLength: 500,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return asProvider.getString(
                            "Please enter your Business Description");
                      }
                      if (value.length < 150) {
                        return asProvider.getString(
                            "Business Description must be at \nleast 150 characters long");
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
                  _submit(context, provider);
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
