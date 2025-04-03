import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:pusher_beams/pusher_beams.dart';
import 'package:qixer/app/constant/appLanguages.dart';
import 'package:qixer/firebase_options.dart';
import 'package:qixer/service/pushNotificationFirebase.dart';
import 'package:qixer/service/push_notification_service.dart';
import 'package:qixer/service/rtl_service.dart';
import 'package:qixer/themes/default_themes.dart';
import 'package:qixer/view/home/homepage_helper.dart';
import 'package:qixer/view/intro/splash.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/providers/AppInitializer.dart';
import 'helper/pusher_helper.dart';
import 'service/languageController/languageController.dart';

@pragma('vm:entry-point')
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  PushNotifications.init();
  PushNotifications.firebaseInitial();
  PushNotifications.isTokenRefreshed();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('icon'),
    ),
    // onDidReceiveBackgroundNotificationResponse: (_) {},
    // onDidReceiveNotificationResponse: (_) {},
  );

  if (Platform.isIOS) {
    final IOSFlutterLocalNotificationsPlugin? iosImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation();
    await iosImplementation?.pendingNotificationRequests();
  }
  if (Platform.isAndroid) {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await androidImplementation?.requestNotificationsPermission();
  }
  var permission = await HomepageHelper().locationPermissionCheck();
  print("lcoations permissions =========>$permission");
  final providers = await AppInitializer.init();
  // PusherHelper.initNotifications();
  // // await PusherBeams.instance.stop();
  // // await PusherBeams.instance.clearDeviceInterests();
  // const instanceID = '03806d23-cb51-408f-b104-935f01fb08a9';
  // await PusherBeams.instance.start(instanceID);

  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );

  // get user id, so that we can clear everything cached by provider when user logs out and logs in again
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userId = prefs.getInt('userId');
}

int? userId;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppUpdateInfo? _updateInfo;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool _flexibleUpdateAvailable = false;

  // Check for app updates
  Future<void> checkForUpdate() async {
    try {
      AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();
      setState(() {
        _updateInfo = updateInfo;
      });
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        showUpdateSheet();
      }
    } catch (e) {
      showSnack(e.toString());
    }
  }

  // Show update sheet to the user
  void showUpdateSheet() {
    if (_scaffoldKey.currentContext != null) {
      showModalBottomSheet(
        context: _scaffoldKey.currentContext!,
        builder: (context) => Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Update Available!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                  "A new version of the app is available. Please update to continue."),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  performImmediateUpdate();
                },
                child: Text("Update Now"),
              ),
            ],
          ),
        ),
      );
    }
  }

  // Perform immediate update
  void performImmediateUpdate() {
    if (_updateInfo?.updateAvailability == UpdateAvailability.updateAvailable) {
      InAppUpdate.performImmediateUpdate().catchError((e) {
        showSnack("Update failed: \$e");
      });
    }
  }

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }

  @override
  void initState() {
    checkForUpdate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Locale> locals = [];
    for (var language in AppLanguages.languages) {
      locals.add(Locale(language.languageCode!, language.countryCode));
    }
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return Consumer2<RtlService, LanguageController>(
      builder: (context, rtlProvider, langController, child) {
        return MaterialApp(
          locale: langController.appLocale,
          debugShowCheckedModeBanner: false,
          title: 'Shashakt Nirman',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: locals,
          // supportedLocales: [
          //   Locale('ar'),
          //   Locale('en'),
          //   Locale('bn'),
          //   Locale('hi'),
          // ],
          builder: (context, rtlChild) => Directionality(
            textDirection: rtlProvider.direction == 'ltr'
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: rtlChild!,
          ),
          theme: ThemeData(
            scaffoldBackgroundColor: Color(0xFFFFF5F5),
            primarySwatch: Colors.blue,
            appBarTheme: DefaultThemes().appBarTheme(context),
            colorScheme: ColorScheme.fromSeed(seedColor: cc.primaryColor),
            inputDecorationTheme: DefaultThemes().inputDecorationTheme(context),
            outlinedButtonTheme: DefaultThemes().outlinedButtonTheme(context),
            elevatedButtonTheme: DefaultThemes().elevatedButtonTheme(context),
            dropdownMenuTheme: DefaultThemes().dropdownMenuTheme(),
          ),
          home: child,
        );
      },
      child: const SplashScreen(),
    );
    ;
  }
}
