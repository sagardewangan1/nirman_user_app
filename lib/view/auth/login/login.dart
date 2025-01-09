import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/helper/extension/string_extension.dart';
import 'package:qixer/service/auth_services/google_sign_service.dart';
import 'package:qixer/service/auth_services/login_service.dart';
import 'package:qixer/view/auth/login/login_helper.dart';
import 'package:qixer/view/auth/reset_password/reset_pass_email_page.dart';
import 'package:qixer/view/auth/signup/signup.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/custom_input.dart';
import 'package:qixer/view/utils/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../service/auth_services/apple_sign_in_sevice.dart';
import '../../../service/auth_services/facebook_login_service.dart';
import '../../../service/profile_service.dart';
import '../../utils/constant_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.hasBackButton = true});

  final hasBackButton;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    initPassword();
  }

  initPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    keepLoggedIn = prefs.getBool('keepLoggedIn') ?? true;
    String? email;
    String? pass;
    if (keepLoggedIn) {
      email = prefs.getString('email');
      pass = prefs.getString("pass");
    }
    emailController.text = email ?? "";
    passwordController.text = pass ?? "";
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool keepLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: physicsCommon,
        slivers: [
          SliverAppBar.large(
            leading: IconButton(
              onPressed: () {
                debugPrint("Pressed back".toString());
                context.popFalse;
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
            flexibleSpace: Container(
              height: 230.0,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/login-slider.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SizedBox(height: 33),
                    CommonHelper().titleCommon(
                        lnProvider.getString('Welcome back! Login')),
                    const SizedBox(height: 33),

                    CommonHelper()
                        .labelCommon(lnProvider.getString("Email or username")),

                    CustomInput(
                      controller: emailController,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email or username';
                        }
                        return null;
                      },
                      hintText: lnProvider.getString("Email"),
                      icon: 'assets/icons/user.png',
                      textInputAction: TextInputAction.next,
                      autofillHints: const [
                        AutofillHints.username,
                        AutofillHints.email
                      ],
                    ),
                    const SizedBox(height: 25),

                    CommonHelper()
                        .labelCommon(lnProvider.getString("Password")),
                    Container(
                      margin: const EdgeInsets.only(bottom: 19),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: passwordController,
                        textInputAction: TextInputAction.next,
                        obscureText: !_passwordVisible,
                        style: const TextStyle(fontSize: 14),
                        autofillHints: const [AutofillHints.password],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return lnProvider
                                .getString('Please enter your password');
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 22.0,
                                width: 40.0,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/icons/lock.png'),
                                      fit: BoxFit.fitHeight),
                                ),
                              ),
                            ],
                          ),
                          suffixIcon: IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.grey,
                              size: 22,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ConstantColors().greyFive),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ConstantColors().primaryColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ConstantColors().warningColor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ConstantColors().primaryColor),
                          ),
                          hintText: lnProvider.getString('Enter password'),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 18),
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            checkColor: Colors.white,
                            activeColor: ConstantColors().primaryColor,
                            contentPadding: const EdgeInsets.all(0),
                            title: Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                lnProvider.getString("Remember Me"),
                                style: TextStyle(
                                  color: ConstantColors().greyFour,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            value: keepLoggedIn,
                            onChanged: (newValue) {
                              setState(() {
                                keepLoggedIn = !keepLoggedIn;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const ResetPassEmailPage(),
                              ),
                            );
                          },
                          child: SizedBox(
                            width: 122,
                            child: Text(
                              lnProvider.getString("Forgot Password?"),
                              style: TextStyle(
                                color: cc.primaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 13),

                    Consumer<LoginService>(
                      builder: (context, provider, child) =>
                          CommonHelper().buttonOrange(
                        lnProvider.getString("Login"),
                        () {
                          if (provider.isloading == false) {
                            if (_formKey.currentState?.validate() ?? false) {
                              provider
                                  .login(
                                emailController.text.trim(),
                                passwordController.text,
                                context,
                                keepLoggedIn,
                              )
                                  .then((value) {
                                if (value == true) {
                                  context.popTrue;
                                }
                              });
                            }
                          }
                        },
                        isloading: provider.isloading == false ? false : true,
                      ),
                    ),

                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: lnProvider.getString("Don't have account?") +
                                "  ",
                            style: const TextStyle(
                                color: Color(0xff646464), fontSize: 14),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupPage(),
                                      ),
                                    );
                                  },
                                text: lnProvider.getString('Sign up'),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: cc.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Additional components for 'Login with Google', 'Login with Facebook', etc.

                    // Divider (or)
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Container(
                          height: 1,
                          color: cc.greyFive,
                        )),
                        Container(
                          width: 40,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(bottom: 25),
                          child: Text(
                            lnProvider.getString("OR"),
                            style: TextStyle(
                                color: cc.greyPrimary,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: 1,
                          color: cc.greyFive,
                        )),
                      ],
                    ),

                    // login with google, facebook button ===========>
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<GoogleSignInService>(
                      builder: (context, gProvider, child) => InkWell(
                          onTap: () {
                            if (gProvider.isloading == false) {
                              gProvider.googleLogin(context);
                            }
                          },
                          child: LoginHelper().commonButton(
                              'assets/icons/google.png',
                              lnProvider.getString("Login with Google"),
                              isloading:
                                  gProvider.isloading == false ? false : true)),
                    ),

                    if (Platform.isIOS) ...[
                      const SizedBox(height: 20),
                      Consumer<AppleSignInService>(
                        builder: (context, gProvider, child) => InkWell(
                            onTap: () async {
                              if (gProvider.isloading == false) {
                                gProvider.setLoadingTrue();
                                await gProvider
                                    .appleLogin(context, autoLogin: true)
                                    .then((value) async {
                                  if (value == true) {
                                    // Navigator.of(context).pop();
                                    await Provider.of<ProfileService>(context,
                                            listen: false)
                                        .fetchData();
                                    context.popTrue;
                                  }
                                }).onError((error, stackTrace) =>
                                        gProvider.setLoadingFalse());
                                gProvider.setLoadingFalse();
                              }
                            },
                            child: LoginHelper().commonButton(
                                'assets/icons/apple.png',
                                ("Sign in with Apple").tr(),
                                isloading: gProvider.isloading == false
                                    ? false
                                    : true)),
                      )
                    ],
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<FacebookLoginService>(
                      builder: (context, fProvider, child) => InkWell(
                        onTap: () {
                          if (fProvider.isloading == false) {
                            fProvider.checkIfLoggedIn(context);
                          }
                        },
                        child: LoginHelper().commonButton(
                            'assets/icons/facebook.png',
                            lnProvider.getString("Login with Facebook"),
                            isloading:
                                fProvider.isloading == false ? false : true),
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
