import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/auth_services/signUpVendorService.dart';
import 'package:qixer/service/dropdowns_services/area_dropdown_service.dart';
import 'package:qixer/service/dropdowns_services/country_dropdown_service.dart';
import 'package:qixer/service/dropdowns_services/state_dropdown_services.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth/signup/components/country_states_dropdowns.dart';
import '../../utils/custom_input.dart';

class BusinessProfileEdit extends StatefulWidget {
  const BusinessProfileEdit({super.key});

  @override
  State<BusinessProfileEdit> createState() => _BusinessProfileEditState();
}

class _BusinessProfileEditState extends State<BusinessProfileEdit> {
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
    await profileController.getProfileDetails(isFromProfileupdatePage: true);
    print(
        "country id===> ${profileController.profileDetails.userDetails.country.id.toString()}");
    addDetails(
      businessName: profileController.profileDetails.userDetails.businessName,
      businessAddress:
          profileController.profileDetails.userDetails.businessFullAddress,
      businessDescription:
          profileController.profileDetails.userDetails.businessDescription,
      businessGSTNumber:
          profileController.profileDetails.userDetails.businessGstNumber,
      businessEmail: profileController.profileDetails.userDetails.businessEmail,
      phoneNumber:
          profileController.profileDetails.userDetails.businessPhoneNumber,
      countryId: profileController.profileDetails.userDetails.country.id,
      countryName: profileController.profileDetails.userDetails.country.country,
      cityId: profileController.profileDetails.userDetails.city.id,
      cityName: profileController.profileDetails.userDetails.city.serviceCity,
      areaId: profileController.profileDetails.userDetails.area.id,
      areaName: profileController.profileDetails.userDetails.area.serviceArea,
    );
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
      int? countryId,
      String? countryName,
      int? cityId,
      String? cityName,
      int? areaId,
      String? areaName}) {
    businessNameController.text = businessName.toString();
    gstNumberController.text = businessGSTNumber.toString();
    businessMobileNumberController.text = phoneNumber.toString();
    businessEmailController.text = businessEmail.toString();
    businessAddressController.text = businessAddress.toString();
    businessDescriptionController.text = businessDescription.toString();
    context.read<CountryDropdownService>().setSelectedCountryId(countryId);
    context.read<CountryDropdownService>().setCountryValue(countryName);
    context.read<StateDropdownService>().setSelectedStatesId(cityId);
    context.read<StateDropdownService>().setStatesValue(cityName);
    context.read<AreaDropdownService>().setSelectedAreaId(areaId);
    context.read<AreaDropdownService>().setAreaValue(areaName);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileService>(
      builder: (context, profileController, child) {
        return Scaffold(
          appBar:
              CommonHelper().appbarCommon2("Edit Business Profile", context),
          body: profileController.isloading
              ? Center(
                  child: OthersHelper().showLoading(cc.primaryColor),
                )
              : ListView(
                  padding: EdgeInsets.zero,
                  children: [
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
                                      asProvider.getString("Business Name"),
                                      isRequired: true),
                                  CustomInput(
                                    controller: businessNameController,
                                    validation: (value) {
                                      if (value == null || value.isEmpty) {
                                        return asProvider.getString(
                                            "Please enter your business name");
                                      }
                                      return null;
                                    },
                                    hintText: asProvider
                                        .getString("Enter your business name"),
                                    icon: 'assets/icons/business.png',
                                    textInputAction: TextInputAction.next,
                                  ),
                                  const SizedBox(height: 18),

                                  // GST Number
                                  CommonHelper().labelCommon(
                                      asProvider
                                          .getString("Business GST Number"),
                                      isRequired: true),
                                  CustomInput(
                                    controller: gstNumberController,
                                    validation: (value) {
                                      if (value == null || value.isEmpty) {
                                        return asProvider.getString(
                                            "Please enter your GST number");
                                      }
                                      return null;
                                    },
                                    hintText: asProvider
                                        .getString("Enter your GST Number"),
                                    icon: 'assets/icons/gstn.png',
                                    textInputAction: TextInputAction.next,
                                  ),
                                  const SizedBox(height: 18),

                                  // Phone Number
                                  CommonHelper().labelCommon(
                                      asProvider
                                          .getString("Business Phone Number"),
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
                                        return asProvider.getString(
                                            "Please enter your Phone number");
                                      }
                                      return null;
                                    },
                                    hintText: asProvider
                                        .getString("Enter your Phone Number"),
                                    icon: 'assets/icons/phone.png',
                                    textInputAction: TextInputAction.next,
                                  ),
                                  const SizedBox(height: 18),

                                  // Email Number
                                  CommonHelper().labelCommon(
                                      asProvider.getString("Business Email"),
                                      isRequired: true),
                                  CustomInput(
                                    controller: businessEmailController,
                                    validation: (value) {
                                      if (value == null || value.isEmpty) {
                                        return asProvider.getString(
                                            "Please enter your Business Email");
                                      }
                                      return null;
                                    },
                                    hintText: asProvider
                                        .getString("Enter your Business Email"),
                                    icon: 'assets/icons/email.png',
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
                                  // Address
                                  CommonHelper().labelCommon(
                                      asProvider.getString("Business Address"),
                                      isRequired: true),
                                  CustomInput(
                                    controller: businessAddressController,
                                    validation: (value) {
                                      if (value == null || value.isEmpty) {
                                        return asProvider.getString(
                                            "Please enter your Business Address");
                                      }
                                      return null;
                                    },
                                    hintText: asProvider.getString(
                                        "Enter your Business Address"),
                                    // icon: 'assets/icons/address.png',
                                    textInputAction: TextInputAction.next,
                                  ),
                                  const SizedBox(height: 18),
                                  // Description
                                  CommonHelper().labelCommon(
                                      asProvider
                                          .getString("Business Description"),
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
                                            return asProvider.getString(
                                                "Please enter your Business Description");
                                          }
                                          return null;
                                        },
                                        counterText:
                                            "${sginupProvider.currentOverviewLength}/${sginupProvider.totalLength}",
                                        onChanged: (p0) {
                                          sginupProvider
                                              .setOverviewLength(p0.length);
                                        },
                                        hintText: asProvider.getString(
                                            "Enter your Business Description"),
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
                              asProvider.getString("Continue"), () {
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
                                        context)
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
                                  "Please Fill Required Fields",
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
