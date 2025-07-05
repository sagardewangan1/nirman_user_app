import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/profile_service.dart';

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
  final appLinks = AppLinks(); // AppLinks is singleton

  @override
  void initState() {
    super.initState();
    appLinks.uriLinkStream.listen((uri) {
      debugPrint("url=====> $uri");
    });
    Future.delayed(Duration.zero, () {
      screenSizeAndPlatform(context);
    });
    // runAtstart(context);
    // SplashService().loginOrGoHome(context);
    //run when app starts
  }

  startInitialization(BuildContext contextBuild) async {
    // PushNotifications.start(
    //     getApplicationContext(), "03806d23-cb51-408f-b104-935f01fb08a9");
    // PushNotifications.addDeviceInterest("hello");
    // await runAtstart(context);
    initializeLNProvider(contextBuild);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLogin = prefs.getBool('shashaktnirman_is_logged_in');
    // await Provider.of<PushNotificationService>(context, listen: false)
    //     .fetchPusherCredential(context: context);
    Future.delayed(const Duration(seconds: 8), () async {
      if (isLogin == false || isLogin == null) {
        Navigator.pushReplacement(
          contextBuild,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const IntroductionPage(),
          ),
        );
        return;
      } else {
        var senderId = prefs.getString('shashaktnirmanUserId');

        Navigator.pushAndRemoveUntil(
          contextBuild,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const LandingPage(),
          ),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    startInitialization(context);
    return Scaffold(
        // backgroundColor: Colors.white,
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/gif/splash_screen.gif"))),

      // color: ConstantColors().primaryColor,
      // child: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Container(
      //       height: 270,
      //       width: double.infinity,
      //       decoration: BoxDecoration(
      //           image: DecorationImage(
      //               image: AssetImage(appLogoIcon), fit: BoxFit.fitHeight)),
      //     ),
      //     // const SizedBox(height: 24),
      //     // OthersHelper().showLoading(ConstantColors().primaryColor),
      //     // const SizedBox(height: 24),
      //     // Text(
      //     //   appVersion,
      //     //   style: TextStyle(
      //     //       fontSize: 14,
      //     //       color: ConstantColors().greyFour,
      //     //       fontWeight: FontWeight.w600),
      //     // )
      //   ],
      // ),
    ));
  }
}
