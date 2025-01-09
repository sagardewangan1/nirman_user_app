import 'package:flutter/material.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/view/home/landing_page.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'introduction_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      screenSizeAndPlatform(context);
    });
    // runAtstart(context);
    // SplashService().loginOrGoHome(context);
    //run when app starts
  }

  startInitialization(BuildContext context) async {
    await runAtstart(context);
    initializeLNProvider(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? intro = prefs.getBool('intro');
    debugPrint(intro.toString());
    if (intro == null) {
      //that means user is opening the app for the first time.. so , show the intro
      Future.delayed(const Duration(microseconds: 2), () {
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const IntroductionPage(),
          ),
        );
      });
      return;
    }
    context.toUntilPage(const LandingPage());
  }

  @override
  Widget build(BuildContext context) {
    startInitialization(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          // color: ConstantColors().primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/logo.png'),
                        fit: BoxFit.fitHeight)),
              ),
              const SizedBox(height: 24),
              OthersHelper().showLoading(ConstantColors().primaryColor),
              const SizedBox(height: 24),
              Text(
                appVersion,
                style: TextStyle(
                    fontSize: 14,
                    color: ConstantColors().greyFour,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ));
  }
}
