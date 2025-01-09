import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pusher_beams/pusher_beams.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/push_notification_service.dart';
import '../view/notification/push_notification_helper.dart';
import '../view/utils/responsive.dart';

class PusherHelper {
  late BuildContext context;

  //Notification alert
  //=================>
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
      debugPrint("_onMessageReceivedInTheForeground".toString());
    }
    await _checkForInitialMessage(context);
    //init pusher instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('userId');
    try {
      await PusherBeams.instance.addDeviceInterest('debug-buyer$userId');
    } catch (e) {
      debugPrint(e.toString());
    }
    debugPrint("debug-buyer$userId".toString());
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
    debugPrint(data.toString());
    Map metaData = data["data"] is Map ? data["data"] as Map : {};
    if (metaData["type"] == "message" &&
        metaData["sender-id"] == chatSellerId) {
      return;
    }
    PushNotificationHelper().notificationAlert(
        context, data["title"].toString(), data["body"].toString());
  }
}
