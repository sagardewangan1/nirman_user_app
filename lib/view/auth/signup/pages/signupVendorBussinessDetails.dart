import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/model/navigationModel.dart';
import 'package:qixer/service/auth_services/signUpVendorService.dart';
import 'package:qixer/service/country_states_service.dart';
import 'package:qixer/service/dropdowns_services/state_dropdown_services.dart';
import 'package:qixer/service/getImageController.dart';
import 'package:qixer/view/auth/signup/pages/tac_pp.dart';
import 'package:qixer/view/chooseCategory/chooseCategorView.dart';
import '../../../../service/app_string_service.dart';
import '../../../../service/dropdowns_services/area_dropdown_service.dart';
import '../../../utils/common_helper.dart';
import '../../../utils/constant_colors.dart';
import '../../../utils/custom_input.dart';
import '../../../utils/others_helper.dart';
import '../../../utils/responsive.dart';
import '../components/country_states_dropdowns.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../dropdowns/area_dropdown_popup.dart';
import '../dropdowns/country_states_dropdowns.dart';
import '../dropdowns/state_dropdown_popup.dart';

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
        AppLocalizations.of(context)!
            .youMustAgreeWithTheTermsAndConditionsToRegister,
        Colors.black,
      );
      return;
    }
    if (businessNameController.text.isEmpty) {
      OthersHelper().showToast(
          AppLocalizations.of(context)!.pleaseEnterYourBusinessName,
          cc.warningColor);
    }

    if (businessAddressController.text.isEmpty) {
      OthersHelper().showToast(
          AppLocalizations.of(context)!.pleaseEnterYourBusinessAddress,
          cc.warningColor);
      return;
    }

    if (businessMobileNumberController.text.isEmpty) {
      OthersHelper().showToast(
          AppLocalizations.of(context)!.pleaseEnterYourPhoneNumber,
          cc.warningColor);
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
          imagePath: context.read<GetImageController>().fileSingle?.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    final getImageController = Provider.of<GetImageController>(context);
    Size size = MediaQuery.of(context).size;
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
                AppLocalizations.of(context)!.fillYourBusinessDetails,
              ),
              const SizedBox(height: 18),

              InkWell(
                onTap: () {
                  getImageController.chooseImage();
                },
                child: Container(
                  height: 150,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(width: 1, color: cc.black6)),
                  child: getImageController.fileSingle != null
                      ? Image.file(
                          fit: BoxFit.contain,
                          getImageController.fileSingle!,
                          height: 150,
                          width: size.width,
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_search,
                              size: 40,
                              color: cc.black6,
                            ),
                            Text(
                              "Tap to add Shop/Business Image",
                              style: TextStyle(fontSize: 14, color: cc.black5),
                            )
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 18),

              // Business Name
              CommonHelper().labelCommon(
                  AppLocalizations.of(context)!.businessName,
                  isRequired: true),
              CustomInput(
                controller: businessNameController,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!
                        .pleaseEnterYourBusinessName;
                  }
                  return null;
                },
                hintText: AppLocalizations.of(context)!.enterYourBusinessName,
                icon: 'assets/icons/business.png',
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 18),

              // GST Number
              CommonHelper()
                  .labelCommon(AppLocalizations.of(context)!.businessGstNumber),
              CustomInput(
                controller: gstNumberController,
                maxLength: 20,
                counterText: "",
                hintText: AppLocalizations.of(context)!.enterYourGstNumber,
                icon: 'assets/icons/gstn.png',
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 18),
              // Phone Number
              CommonHelper().labelCommon(
                  AppLocalizations.of(context)!.businessPhoneNumber,
                  isRequired: true),
              CustomInput(
                controller: businessMobileNumberController,
                isNumberField: true,
                inputType: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 10,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!
                        .pleaseEnterYourPhoneNumber;
                  }
                  return null;
                },
                hintText: AppLocalizations.of(context)!.enterYourMobileNumber,
                icon: 'assets/icons/phone.png',
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 18),

              // Email Number
              CommonHelper().labelCommon(
                  AppLocalizations.of(context)!.businessEmail,
                  isRequired: true),
              CustomInput(
                controller: businessEmailController,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!
                        .pleaseEnterYourBusinessEmail;
                  }
                  return null;
                },
                hintText: AppLocalizations.of(context)!.enterYourBusinessEmail,
                icon: 'assets/icons/email.png',
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 18),

              // Address
              CommonHelper().labelCommon(
                  AppLocalizations.of(context)!.businessAddress,
                  isRequired: true),
              CustomInput(
                controller: businessAddressController,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!
                        .pleaseEnterYourBusinessAddress;
                  }
                  return null;
                },
                hintText:
                    AppLocalizations.of(context)!.enterYourBusinessAddress,
                // icon: 'assets/icons/address.png',
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 18),

              Consumer<CountryStatesService>(
                  builder: (context, provider, child) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //dropdown and search box
                          // const SizedBox(
                          //   width: 17,
                          // ),

                          // // Country dropdown ===============>
                          // Column(
                          //   crossAxisAlignment:
                          //       CrossAxisAlignment.start,
                          //   children: [
                          //     CommonHelper().labelCommon(
                          //         'Choose Country',
                          //         isRequired: true),
                          //     Consumer<CountryDropdownService>(
                          //       builder: (context, p, child) =>
                          //           InkWell(
                          //         onTap: () {
                          //           // p.fetchCountries(context, isrefresh: true);
                          //           showModalBottomSheet(
                          //               context: context,
                          //               isScrollControlled: true,
                          //               builder: (BuildContext
                          //                   context) {
                          //                 return SizedBox(
                          //                     height: screenHeight /
                          //                             2 +
                          //                         MediaQuery.of(
                          //                                     context)
                          //                                 .viewInsets
                          //                                 .bottom /
                          //                             2,
                          //                     child:
                          //                         const CountryDropdownPopup());
                          //               });
                          //         },
                          //         child: dropdownPlaceholder(
                          //           hintText: p.selectedCountry,
                          //         ),
                          //       ),
                          //     )
                          //   ],
                          // ),

                          // const SizedBox(
                          //   height: 25,
                          // ),
                          // States dropdown ===============>
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonHelper().labelCommon(
                                  AppLocalizations.of(context)!.chooseState,
                                  isRequired: true),
                              Consumer<StateDropdownService>(
                                builder: (context, p, child) => InkWell(
                                  onTap: () {
                                    // p.fetchStates(context, isrefresh: true);
                                    showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (BuildContext context) {
                                          return SizedBox(
                                              height: screenHeight / 2 +
                                                  MediaQuery.of(context)
                                                          .viewInsets
                                                          .bottom /
                                                      2,
                                              child:
                                                  const StateDropdownPopup());
                                        });
                                  },
                                  child: dropdownPlaceholder(
                                      hintText: p.selectedState),
                                ),
                              )
                            ],
                          ),

                          const SizedBox(
                            height: 25,
                          ),

                          // Area dropdown ===============>
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonHelper().labelCommon(
                                  AppLocalizations.of(context)!.chooseCity,
                                  isRequired: true),
                              Consumer<AreaDropdownService>(
                                builder: (context, p, child) => InkWell(
                                  onTap: () {
                                    // p.fetchArea(context, isrefresh: true);
                                    showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (BuildContext context) {
                                          return SizedBox(
                                              height: screenHeight / 2 +
                                                  MediaQuery.of(context)
                                                          .viewInsets
                                                          .bottom /
                                                      2,
                                              child: const AreaDropdownPopup());
                                        });
                                  },
                                  child: dropdownPlaceholder(
                                      textWidth: 200.0,
                                      textOverflow: TextOverflow.visible,
                                      hintText: p.selectedArea.isNotEmpty
                                          ? p.selectedArea
                                          : AppLocalizations.of(context)!
                                              .selectCity),
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
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
                  AppLocalizations.of(context)!.businessDescription,
                  isRequired: true),
              Consumer<SignupVendorService>(
                builder: (context, sginupProvider, child) {
                  return CustomInput(
                    controller: businessDescriptionController,
                    // maxLines: 5,
                    maxLength: 500,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!
                            .pleaseEnterYourBusinessDescription;
                      }
                      return null;
                    },
                    counterText:
                        "${sginupProvider.currentOverviewLength}/${sginupProvider.totalLength}",
                    onChanged: (p0) {
                      sginupProvider.setOverviewLength(p0.length);
                    },
                    hintText: AppLocalizations.of(context)!
                        .enterYourBusinessDescription,
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
                        text: "${AppLocalizations.of(context)!.iAgreeTo} ",
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
                              text: AppLocalizations.of(context)!
                                  .termsAndCondition,
                              style: TextStyle(
                                color: cc.primaryColor,
                                fontWeight: FontWeight.w600,
                              )),
                          TextSpan(
                              text:
                                  "${" ${AppLocalizations.of(context)!.and}"} ",
                              style: TextStyle(color: cc.black5)),
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.toPage(const TacPP(
                                    route: "/privacy-policy",
                                  ));
                                  FocusScope.of(context).unfocus();
                                },
                              text: AppLocalizations.of(context)!.privacyPolicy,
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
                    .buttonOrange(AppLocalizations.of(context)!.continueText,
                        () {
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
