import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/auth_services/signup_service.dart';
import 'package:qixer/service/dropdowns_services/area_dropdown_service.dart';
import 'package:qixer/service/dropdowns_services/state_dropdown_services.dart';
import 'package:qixer/view/auth/signup/components/country_states_dropdowns.dart';
import 'package:qixer/view/auth/signup/pages/tac_pp.dart';
import 'package:qixer/view/auth/signup/signup_helper.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';

class SignupCountryStates extends StatefulWidget {
  const SignupCountryStates({
    super.key,
    this.fullNameController,
    this.userNameController,
    this.emailController,
    this.passController,
  });

  final fullNameController;
  final userNameController;
  final emailController;
  final passController;

  @override
  _SignupCountryStatesState createState() => _SignupCountryStatesState();
}

class _SignupCountryStatesState extends State<SignupCountryStates> {
  @override
  void initState() {
    super.initState();
  }

  bool termsAgree = false;

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Consumer<AppStringService>(
      builder: (context, asProvider, child) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const CountryStatesDropdowns(),
              //Agreement checkbox ===========>
              const SizedBox(
                height: 17,
              ),
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
              //Login button ==================>
              const SizedBox(
                height: 17,
              ),
              Consumer<SignupService>(
                builder: (context, provider, child) => CommonHelper()
                    .buttonOrange(lnProvider.getString("Sign Up"), () {
                  if (termsAgree == false) {
                    OthersHelper().showToast(
                        asProvider.getString(
                            "You must agree with the terms and conditions to register"),
                        Colors.black);
                  } else {
                    if (provider.isloading == false) {
                      var selectedStateId = Provider.of<StateDropdownService>(
                              context,
                              listen: false)
                          .selectedStateId;
                      var selectedAreaId = Provider.of<AreaDropdownService>(
                              context,
                              listen: false)
                          .selectedAreaId;
                      if (selectedStateId == '0' ||
                          selectedAreaId == '0' ||
                          selectedAreaId == null) {
                        OthersHelper().showSnackBar(
                            context,
                            asProvider
                                .getString("You must select a state and area"),
                            cc.warningColor);
                        return;
                      }

                      provider.signup(
                          widget.fullNameController.text.trim(),
                          widget.emailController.text.trim(),
                          widget.userNameController.text.trim(),
                          widget.passController.text.trim(),
                          context);
                    }
                  }
                }, isloading: provider.isloading == false ? false : true),
              ),

              const SizedBox(
                height: 25,
              ),
              SignupHelper().haveAccount(context),

              const SizedBox(
                height: 30,
              ),
            ],
          )),
    );
  }
}
