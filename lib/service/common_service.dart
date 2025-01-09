import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/home_services/category_service.dart';
import 'package:qixer/service/home_services/recent_services_service.dart';
import 'package:qixer/service/home_services/slider_service.dart';
import 'package:qixer/service/home_services/top_rated_services_service.dart';
import 'package:qixer/service/jobs_service/recent_jobs_service.dart';
import 'package:qixer/service/permissions_service.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/service/push_notification_service.dart';
import 'package:qixer/service/rtl_service.dart';
import 'package:qixer/view/utils/others_helper.dart';

late bool isIos;

Future<bool> checkConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    OthersHelper()
        .showToast("Please turn on your internet connection", Colors.black);
    return false;
  } else {
    return true;
  }
}

twoDouble(double value) {
  return double.parse(value.toStringAsFixed(1));
}

getYear(value) {
  final f = DateFormat('yyyy');
  var d = f.format(value);
  return d;
}

getTime(value) {
  final f = DateFormat('hh:mm a');
  var d = f.format(value);
  return d;
}

getDate(value) {
  final f = DateFormat('yyyy-MM-dd');
  var d = f.format(value);
  return d;
}

getMonthAndDate(value, local) {
  final f = DateFormat("MMMM dd", local);
  var d = f.format(value);
  return d;
}

firstThreeLetter(value, local) {
  var weekDayName = DateFormat('EEEE', local).format(value).toString();
  return weekDayName.substring(0, 3);
}

checkPlatform() {
  if (Platform.isAndroid) {
    isIos = false;
  } else if (Platform.isIOS) {
    isIos = true;
  }
}

removeUnderscore(value) {
  return value.replaceAll(RegExp('_'), ' ');
}

removeDollar(value) {
  return value.replaceAll(RegExp('[^0-9.]'), '');
}

runAtstart(BuildContext context) async {
  Provider.of<RtlService>(context, listen: false).fetchCurrency();
  //language direction (ltr or rtl)

  await Provider.of<RtlService>(context, listen: false).fetchDirection(context);
  await Provider.of<ProfileService>(context, listen: false).fetchData();
//fetch translated strings
  // Provider.of<AppStringService>(context, listen: false)
  //     .fetchTranslatedStrings();
}

runAtHome(BuildContext context) async {
  await Provider.of<PushNotificationService>(context, listen: false)
      .fetchPusherCredential(context: context);
  Provider.of<SliderService>(context, listen: false).loadSlider();
  Provider.of<CategoryService>(context, listen: false).fetchCategory();
  Provider.of<TopRatedServicesSerivce>(context, listen: false)
      .fetchTopService();
  Provider.of<RecentServicesService>(context, listen: false)
      .fetchRecentService();
  Provider.of<RecentJobsService>(context, listen: false)
      .fetchRecentJobs(context);
  Provider.of<ProfileService>(context, listen: false).getProfileDetails();
  // Provider.of<CountryStatesService>(context, listen: false)
  //     .fetchCountries(context);

  Provider.of<PermissionsService>(context, listen: false)
      .fetchUserPermissions(context);

  //
}
