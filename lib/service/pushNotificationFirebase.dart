import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushNotifications {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create and register a notification channel (Android 8.0+)
  static Future<void> _setupNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'nirmaan_notifications', // Channel ID (must match Firebase payload)
      'Nirmaan Notifications', // Channel Name (user-visible)
      description: 'This channel is for Nirmaan Notifications',
      importance: Importance.high,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  /// Initialize local notifications
  static Future<void> initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/snotification_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        print("Notification clicked: ${response.payload}");
      },
    );

    // Ensure notification channel is created
    await _setupNotificationChannel();
  }

  /// Handle background messages
  static Future<void> handleMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    if (message.notification != null) {
      print("Title: ${message.notification?.title ?? ""}");
      print("Body: ${message.notification?.body ?? ""}");
      print("Data Payload: ${message.data}");

      // Navigate based on data payload (optional)
      if (message.data.containsKey('route')) {
        String route = message.data['route'];
        if (route == "/home") {
          String? propertyID = message.data['propertyID'];
          if (propertyID != null) {
            // Perform navigation (Ensure AppGlobalKeys is properly implemented)
            // AppGlobalKeys.navigatorKey.currentState?.push(
            //   MaterialPageRoute(builder: (context) => PropertyDetailsView(propertyID: propertyID)),
            // );
          }
        }
      }
    }

    // Show notification
    await showNotification(message);
  }

  /// Initialize Firebase Messaging
  static void firebaseInitial() {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      if (event.notification != null) {
        debugPrint("Foreground Message: ${event.data}");
        showNotification(event); // Local notification trigger karo
      }
      showNotification(event);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(
          "Notification clicked while app was in background: ${message.data}");
    });
  }

  /// Show local notification
  static Future<void> showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidChannelSpecifics =
        AndroidNotificationDetails(
            'nirmaan_notifications', // Ensure this matches the created channel
            'Nirmaan Notifications',
            channelDescription: 'This channel is for Nirmaan Notifications',
            importance: Importance.high,
            priority: Priority.high,
            showWhen: true,
            icon: '@drawable/snotification_icon');

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidChannelSpecifics,
    );

    // Use unique notification ID (avoids overwriting notifications)
    int notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    await _flutterLocalNotificationsPlugin.show(
      notificationId,
      message.notification?.title ?? "No Title",
      message.notification?.body ?? "No Body",
      platformChannelSpecifics,
    );
  }

  /// Request Notification Permissions and Retrieve FCM Token
  static Future<void> init() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false, // `false` since it's not required for most apps
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
      providesAppNotificationSettings: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted notification permissions.");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User granted provisional permissions.");
    } else {
      print("User denied notification permissions.");
    }

    // Retrieve and save FCM token
    final prefs = await SharedPreferences.getInstance();
    try {
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        print("FCM Token: $token");
        await prefs.setString('sashaktNirmaanDeviceToken', token);
      } else {
        print("Failed to retrieve FCM token.");
      }
    } catch (e) {
      print("Error retrieving FCM token: $e");
    }

    // Listen for token refresh
    _firebaseMessaging.onTokenRefresh.listen((String newToken) async {
      print("FCM Token refreshed: $newToken");
      await prefs.setString('sashaktNirmaanDeviceToken', newToken);
    });

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(handleMessage);
  }

  static void isTokenRefreshed() {
    _firebaseMessaging.onTokenRefresh.listen((String newToken) async {
      print("FCM Token refreshed: $newToken");
      // Save updated token to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('sashaktNirmaanDeviceToken', newToken);
    });
  }
}
