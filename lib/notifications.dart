import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  // static final GlobalKey<NavigatorState> navigatorKey =
  //     sl<GlobalKey<NavigatorState>>();
  static const channelId = "com.vlmoon.nearsocialnotifications";
  static const channelName = "nearsocialnotifications";
  static const channelIdImp = "high_importance_channel";
  static const channelNameImp = "High Importance Notifications";
  static const channelNameDesc =
      'This channel is used for important notifications.';
  static final FlutterLocalNotificationsPlugin _notificationPlugin =
      FlutterLocalNotificationsPlugin();
  static void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
  }

  static bool isInited = false;

  static Future<void> init() async {
    // const iOSPlatformChannelSpecifics = DarwinNotificationDetails(
    //   presentAlert: true,
    //   presentSound: true,
    //   presentBadge: true,
    // );

    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher.png");
    DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        log('id: ${id}, title: $title, body: $body, payload: $payload');
      },
    );
    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
        channelIdImp, // id
        channelNameImp, // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.high,
        playSound: true);

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await _notificationPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    _notificationPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveNotificationResponse,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
    LocalNotificationService.isInited = true;
  }

  static void showNotificationOnForeground(LocalNotificationMessage message) {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const iOSPlatformChannelSpecifics = DarwinNotificationDetails(
        presentAlert: true, presentSound: true, presentBadge: true);
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      "$channelName.$channelId",
      channelName,
      playSound: true,
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    // const NotificationDetails platformChannelSpecifics = NotificationDetails(
    //     android: androidPlatformChannelSpecifics,
    //     iOS: iOSPlatformChannelSpecifics);
    flutterLocalNotificationsPlugin.show(
      0,
      'BOS Notifications',
      message.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          channelIdImp,
          channelNameImp,
          channelDescription: channelNameDesc,
          importance: Importance.high,
          color: Colors.blue,
          playSound: true,
          icon: '@mipmap/ic_launcher.png',
        ),
      ),
      payload: 'test',
    );

    // _notificationPlugin.show(DateTime.now().millisecond, message.title,
    //     message.body, platformChannelSpecifics,
    //     payload: json.encode(message.data));
  }
}

class LocalNotificationMessage {
  final String? title;
  final String? body;
  final dynamic data;

  LocalNotificationMessage(this.title, this.body, this.data);
}