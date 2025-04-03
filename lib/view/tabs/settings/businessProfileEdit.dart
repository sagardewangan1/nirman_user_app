import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:qixer/model/navigationModel.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/auth_services/signUpVendorService.dart';
import 'package:qixer/service/dropdowns_services/area_dropdown_service.dart';
import 'package:qixer/service/dropdowns_services/country_dropdown_service.dart';
import 'package:qixer/service/dropdowns_services/state_dropdown_services.dart';
import 'package:qixer/service/getImageController.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../service/country_states_service.dart';
import '../../auth/signup/components/country_states_dropdowns.dart';
import '../../auth/signup/dropdowns/area_dropdown_popup.dart';
import '../../auth/signup/dropdowns/country_states_dropdowns.dart';
import '../../auth/signup/dropdowns/state_dropdown_popup.dart';
import '../../utils/custom_input.dart';
import '../../utils/responsive.dart';

class BusinessProfileEdit extends StatefulWidget {
  final NavigationModel navigationModel;
  const BusinessProfileEdit({super.key, required this.navigationModel});

  @override
  State<BusinessProfileEdit> createState() => _BusinessProfileEditState();
}

class _BusinessProfileEditState extends State<BusinessProfileEdit> {
  String businessProfileImages = '';

  // Basic Details
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessMobileNumberController =
      TextEditingController();
  TextEditingController businessEmailController = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();
  TextEditingController businessStateController = TextEditingController();
  TextEditingController businessCityController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();
  TextEditingController businessDescriptionController = TextEditingController();

  ConstantColors cc = ConstantColors();

  final _formKey = GlobalKey<FormState>();

  bool termsAgree = false;
  @override
  void initState() {
    firstLoad();
    super.initState();
  }

  String? userType;
  firstLoad() async {
    final profileController =
        Provider.of<ProfileService>(context, listen: false);
    await profileController.getProfileDetails(
        isFromProfileupdatePage: true, context: context);
    print(
        "gst id===> ${profileController.profileDetails.userDetails.businessGstNumber} ${profileController.profileDetails.userDetails.businessGstNumber.runtimeType}");

    addDetails(
        businessName: profileController.profileDetails.userDetails.businessName,
        businessAddress:
            profileController.profileDetails.userDetails.businessFullAddress,
        businessDescription:
            profileController.profileDetails.userDetails.businessDescription,
        businessGSTNumber:
            (profileController.profileDetails.userDetails.businessGstNumber !=
                        null &&
                    profileController.profileDetails.userDetails
                        .businessGstNumber!.isNotEmpty)
                ? profileController.profileDetails.userDetails.businessGstNumber
                : '',
        businessEmail:
            profileController.profileDetails.userDetails.businessEmail,
        phoneNumber:
            profileController.profileDetails.userDetails.businessPhoneNumber,
        // countryId: profileController.profileDetails.userDetails.country.id,
        // countryName:
        //     profileController.profileDetails.userDetails.country.country,
        // cityId: profileController.profileDetails.userDetails.city.id,
        // cityName: profileController.profileDetails.userDetails.city.serviceCity,
        // areaId: 12,
        // areaName: "Test",
        businessProfileImage: profileController.businessProfile);
    final pref = await SharedPreferences.getInstance();
    userType = pref.getString("shashaktnirmanusertype");
    print("userType =====> $userType ${userType.runtimeType}");
  }

  addDetails(
      {String? businessName,
      String? businessGSTNumber,
      String? phoneNumber,
      String? businessEmail,
      String? businessAddress,
      String? businessDescription,
      // int? countryId,
      // String? countryName,
      // int? cityId,
      // String? cityName,
      // int? areaId,
      // String? areaName,
      String? businessProfileImage}) {
    businessNameController.text = businessName.toString();
    gstNumberController.text = businessGSTNumber.toString();
    businessMobileNumberController.text = phoneNumber.toString();
    businessEmailController.text = businessEmail.toString();
    businessAddressController.text = businessAddress.toString();
    businessDescriptionController.text = businessDescription.toString();
    // context.read<CountryDropdownService>().setSelectedCountryId(countryId);
    // context.read<CountryDropdownService>().setCountryValue(countryName);
    // context.read<StateDropdownService>().setSelectedStatesId(cityId);
    // context.read<StateDropdownService>().setStatesValue(cityName);
    // context.read<AreaDropdownService>().setSelectedAreaId(areaId);
    // context.read<AreaDropdownService>().setAreaValue(areaName);
    businessProfileImages = businessProfileImage ?? '';
    print("business profile image ======> $businessProfileImages");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final getImageController = Provider.of<GetImageController>(context);
    Size size = MediaQuery.of(context).size;
    return Consumer<ProfileService>(
      builder: (context, profileController, child) {
        return Scaffold(
          appBar: CommonHelper().appbarCommon2(
              AppLocalizations.of(context)!.editBusinessProfile, context),
          body: profileController.isloading
              ? Center(
                  child: OthersHelper().showLoading(cc.primaryColor),
                )
              : ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Gap(10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          getImageController
                              .chooseImage(); // User taps to choose a new image
                        },
                        child: Container(
                          height: 150,
                          width: size.width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: cc.white,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(width: 1, color: cc.black6),
                          ),
                          child: getImageController.fileSingle != null
                              ? Image.file(
                                  getImageController.fileSingle!,
                                  fit: BoxFit.contain,
                                  height: 150,
                                  width: size.width,
                                )
                              : (businessProfileImages != ''
                                  ? CommonHelper().profileImage(
                                      fit: BoxFit.contain,
                                      businessProfileImages,
                                      150,
                                      size.width)
                                  : Icon(Icons.image_search,
                                      size: 50,
                                      color: Colors
                                          .grey)), // ✅ Default icon agar kuch na ho
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                      ),
                      child: Text(
                        textAlign: TextAlign.right,
                        "(Tap here to change the image)",
                        style: TextStyle(
                          fontSize: 14,
                          color: cc.black5,
                        ),
                      ),
                    ),
                    Gap(10),
                    Consumer<AppStringService>(
                      builder: (context, asProvider, child) => Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: cc.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Column(
                                // physics: NeverScrollableScrollPhysics(),
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title
                                  const SizedBox(height: 18),

                                  // Business Name
                                  CommonHelper().labelCommon(
                                      AppLocalizations.of(context)!
                                          .businessName,
                                      isRequired: true),
                                  CustomInput(
                                    controller: businessNameController,
                                    validation: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppLocalizations.of(context)!
                                            .enterYourBusinessName;
                                      }
                                      return null;
                                    },
                                    hintText: AppLocalizations.of(context)!
                                        .enterYourBusinessName,
                                    icon: 'assets/icons/business.png',
                                    textInputAction: TextInputAction.next,
                                  ),
                                  const SizedBox(height: 18),

                                  // GST Number
                                  CommonHelper().labelCommon(
                                    AppLocalizations.of(context)!
                                        .businessGstNumber,
                                  ),
                                  CustomInput(
                                    controller: gstNumberController,
                                    // validation: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return AppLocalizations.of(context)!
                                    //         .pleaseEnterYourGstNumber;
                                    //   }
                                    //   return null;
                                    // },
                                    hintText: AppLocalizations.of(context)!
                                        .enterYourGstNumber,
                                    icon: 'assets/icons/gstn.png',
                                    textInputAction: TextInputAction.next,
                                  ),
                                  const SizedBox(height: 18),

                                  // Phone Number
                                  CommonHelper().labelCommon(
                                      AppLocalizations.of(context)!
                                          .businessPhoneNumber,
                                      isRequired: true),
                                  CustomInput(
                                    controller: businessMobileNumberController,
                                    isNumberField: true,
                                    inputType: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    maxLength: 10,
                                    validation: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppLocalizations.of(context)!
                                            .pleaseEnterYourPhoneNumber;
                                      }
                                      return null;
                                    },
                                    hintText: AppLocalizations.of(context)!
                                        .enterYourPhoneNumber,
                                    icon: 'assets/icons/phone.png',
                                    textInputAction: TextInputAction.next,
                                  ),
                                  const SizedBox(height: 18),

                                  // Email Number
                                  CommonHelper().labelCommon(
                                      AppLocalizations.of(context)!
                                          .businessEmail,
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
                                    hintText: AppLocalizations.of(context)!
                                        .enterYourBusinessEmail,
                                    icon: 'assets/icons/email.png',
                                    textInputAction: TextInputAction.next,
                                  ),
                                  // const SizedBox(height: 18),
                                  //
                                  // Consumer<CountryStatesService>(
                                  //     builder: (context, provider, child) =>
                                  //         Column(
                                  //           crossAxisAlignment:
                                  //               CrossAxisAlignment.start,
                                  //           children: [
                                  //             //dropdown and search box
                                  //             // const SizedBox(
                                  //             //   width: 17,
                                  //             // ),
                                  //
                                  //             // // Country dropdown ===============>
                                  //             // Column(
                                  //             //   crossAxisAlignment:
                                  //             //       CrossAxisAlignment.start,
                                  //             //   children: [
                                  //             //     CommonHelper().labelCommon(
                                  //             //         'Choose Country',
                                  //             //         isRequired: true),
                                  //             //     Consumer<CountryDropdownService>(
                                  //             //       builder: (context, p, child) =>
                                  //             //           InkWell(
                                  //             //         onTap: () {
                                  //             //           // p.fetchCountries(context, isrefresh: true);
                                  //             //           showModalBottomSheet(
                                  //             //               context: context,
                                  //             //               isScrollControlled: true,
                                  //             //               builder: (BuildContext
                                  //             //                   context) {
                                  //             //                 return SizedBox(
                                  //             //                     height: screenHeight /
                                  //             //                             2 +
                                  //             //                         MediaQuery.of(
                                  //             //                                     context)
                                  //             //                                 .viewInsets
                                  //             //                                 .bottom /
                                  //             //                             2,
                                  //             //                     child:
                                  //             //                         const CountryDropdownPopup());
                                  //             //               });
                                  //             //         },
                                  //             //         child: dropdownPlaceholder(
                                  //             //           hintText: p.selectedCountry,
                                  //             //         ),
                                  //             //       ),
                                  //             //     )
                                  //             //   ],
                                  //             // ),
                                  //
                                  //             // const SizedBox(
                                  //             //   height: 25,
                                  //             // ),
                                  //             // States dropdown ===============>
                                  //             Column(
                                  //               crossAxisAlignment:
                                  //                   CrossAxisAlignment.start,
                                  //               children: [
                                  //                 CommonHelper().labelCommon(
                                  //                     AppLocalizations.of(
                                  //                             context)!
                                  //                         .chooseState,
                                  //                     isRequired: true),
                                  //                 Consumer<
                                  //                     StateDropdownService>(
                                  //                   builder:
                                  //                       (context, p, child) =>
                                  //                           InkWell(
                                  //                     onTap: () {
                                  //                       // p.fetchStates(context, isrefresh: true);
                                  //                       showModalBottomSheet(
                                  //                           context: context,
                                  //                           isScrollControlled:
                                  //                               true,
                                  //                           builder:
                                  //                               (BuildContext
                                  //                                   context) {
                                  //                             return SizedBox(
                                  //                                 height: screenHeight /
                                  //                                         2 +
                                  //                                     MediaQuery.of(context)
                                  //                                             .viewInsets
                                  //                                             .bottom /
                                  //                                         2,
                                  //                                 child:
                                  //                                     const StateDropdownPopup());
                                  //                           });
                                  //                     },
                                  //                     child: dropdownPlaceholder(
                                  //                         hintText:
                                  //                             p.selectedState),
                                  //                   ),
                                  //                 )
                                  //               ],
                                  //             ),
                                  //
                                  //             const SizedBox(
                                  //               height: 25,
                                  //             ),
                                  //
                                  //             // Area dropdown ===============>
                                  //             Column(
                                  //               crossAxisAlignment:
                                  //                   CrossAxisAlignment.start,
                                  //               children: [
                                  //                 CommonHelper().labelCommon(
                                  //                     AppLocalizations.of(
                                  //                             context)!
                                  //                         .chooseCity,
                                  //                     isRequired: true),
                                  //                 Consumer<AreaDropdownService>(
                                  //                   builder:
                                  //                       (context, p, child) =>
                                  //                           InkWell(
                                  //                     onTap: () {
                                  //                       // p.fetchArea(context, isrefresh: true);
                                  //                       showModalBottomSheet(
                                  //                           context: context,
                                  //                           isScrollControlled:
                                  //                               true,
                                  //                           builder:
                                  //                               (BuildContext
                                  //                                   context) {
                                  //                             return SizedBox(
                                  //                                 height: screenHeight /
                                  //                                         2 +
                                  //                                     MediaQuery.of(context)
                                  //                                             .viewInsets
                                  //                                             .bottom /
                                  //                                         2,
                                  //                                 child:
                                  //                                     const AreaDropdownPopup2());
                                  //                           });
                                  //                     },
                                  //                     child: dropdownPlaceholder(
                                  //                         hintText: p
                                  //                                 .selectedCity
                                  //                                 .isNotEmpty
                                  //                             ? p.selectedCity
                                  //                                 .join(',')
                                  //                             : AppLocalizations
                                  //                                     .of(context)!
                                  //                                 .selectCity),
                                  //                   ),
                                  //                 ),
                                  //               ],
                                  //             )
                                  //           ],
                                  //         )),
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
                                  // Address
                                  CommonHelper().labelCommon(
                                      AppLocalizations.of(context)!
                                          .businessAddress,
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
                                    hintText: AppLocalizations.of(context)!
                                        .enterYourBusinessAddress,
                                    // icon: 'assets/icons/address.png',
                                    textInputAction: TextInputAction.next,
                                  ),
                                  const SizedBox(height: 18),
                                  // Description
                                  CommonHelper().labelCommon(
                                      AppLocalizations.of(context)!
                                          .businessDescription,
                                      isRequired: true),
                                  Consumer<SignupVendorService>(
                                    builder: (context, sginupProvider, child) {
                                      return CustomInput(
                                        controller:
                                            businessDescriptionController,
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
                                          sginupProvider
                                              .setOverviewLength(p0.length);
                                        },
                                        hintText: AppLocalizations.of(context)!
                                            .enterYourBusinessDescription,
                                        textInputAction: TextInputAction.next,
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 18),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
          bottomNavigationBar: Consumer<AppStringService>(
            builder: (context, asProvider, child) {
              return Consumer<SignupVendorService>(
                  builder: (context, provider, child) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 55,
                          child: CommonHelper().buttonOrange(
                              AppLocalizations.of(context)!.continueText, () {
                            if (_formKey.currentState!.validate()) {
                              if (provider.isloading == false) {
                                provider
                                    .updateBusinessProfile(
                                        businessNameController.text.toString(),
                                        gstNumberController.text.toString(),
                                        businessMobileNumberController.text
                                            .toString(),
                                        businessEmailController.text.toString(),
                                        businessAddressController.text
                                            .toString(),
                                        businessDescriptionController.text
                                            .toString(),
                                        context,
                                        imagePath:
                                            getImageController.fileSingle?.path)
                                    .then(
                                  (value) {
                                    if (value) {
                                      Navigator.pop(context);
                                    }
                                  },
                                );
                              }
                            } else {
                              OthersHelper().showToast(
                                  AppLocalizations.of(context)!
                                      .pleaseFillRequiredFields,
                                  cc.warningColor);
                            }
                          },
                              isloading:
                                  provider.isloading == false ? false : true),
                        ),
                      ));
            },
          ),
        );
      },
    );
  }
}
