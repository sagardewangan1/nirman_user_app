import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pusher_beams/pusher_beams.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../service/push_notification_service.dart';
import '../view/notification/push_notification_helper.dart';
import '../view/utils/responsive.dart';

class PusherHelper {
  late BuildContext context;
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize Local Notifications
  static Future<void> initNotifications() async {
    var androidInitSettings =
        const AndroidInitializationSettings('@mipmap/launcher_icon');
    var initSettings = InitializationSettings(android: androidInitSettings);
    flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  // Initialize Pusher Beams
  initPusherBeams(BuildContext context) async {
    this.context = context;
    var pusherInstance =
        await Provider.of<PushNotificationService>(context, listen: false)
            .pusherInstance;
    debugPrint(pusherInstance.toString());
    if (pusherInstance == null) return;
    log(pusherInstance.toString());
    debugPrint((!kIsWeb).toString());
    if (!kIsWeb) {
      await PusherBeams.instance
          .onMessageReceivedInTheForeground(_onMessageReceivedInTheForeground);
      debugPrint("_onMessageReceivedInTheForeground");
    }
    await _checkForInitialMessage(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('shashaktnirmanUserId');
    try {
      await PusherBeams.instance.addDeviceInterest('debug-buyer$userId');
    } catch (e) {
      debugPrint("error pusher =====> ${e.toString()}");
    }
    debugPrint("debug-buyer$userId");
    debugPrint((await PusherBeams.instance.getDeviceInterests()).toString());
  }

  Future<void> _checkForInitialMessage(BuildContext context) async {
    final initialMessage = await PusherBeams.instance.getInitialMessage();
    if (initialMessage != null) {
      PushNotificationHelper().notificationAlert(
          context, 'Initial Message Is:', initialMessage.toString());
    }
  }

  void _onMessageReceivedInTheForeground(Map<Object?, Object?> data) {
    debugPrint("notification messages data =====> ${data.toString()}");
    Map metaData = data["data"] is Map ? data["data"] as Map : {};
    if (metaData["type"] == "message" &&
        metaData["sender-id"] == chatSellerId) {
      return;
    }

    // Show Alert Notification
    PushNotificationHelper().notificationAlert(
        context, data["title"].toString(), data["body"].toString());

    // Show Local Notification
    _showLocalNotification(data["title"].toString(), data["body"].toString());

    // Show Toast Notification
    showToastNotification(data["title"].toString());
  }

  // Show Local Notification
  void _showLocalNotification(String title, String body) async {
    var androidDetails = const AndroidNotificationDetails(
      'channel_id',
      'General Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      generalNotificationDetails,
    );
  }

  // Show Toast Notification
  void showToastNotification(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
