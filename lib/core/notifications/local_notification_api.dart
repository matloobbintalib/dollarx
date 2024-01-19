import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationsApi {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  LocalNotificationsApi({FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin})
      : _flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin ?? FlutterLocalNotificationsPlugin();

  ///create channel
  AndroidNotificationChannel _channel = const AndroidNotificationChannel(
    'app_channel', // id
    'App Channel', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  /// Initialize
  Future<void> initialize() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
    await _initSetting();
  }

  /// Show Notification
  void showNotification(RemoteMessage remoteMessage, AndroidNotification? android) async {
    RemoteNotification? notification = remoteMessage.notification;

    if (notification != null && android != null) {
      AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        _channel.id,
        _channel.name,
        channelDescription: _channel.description,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      );
      NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
      await _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        notificationDetails,
        payload: jsonEncode(remoteMessage.data),
      );
    }
  }

  /// Remove Notification
  Future<void> removeNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  /// Initialize Settings
  Future<void> _initSetting() async {
    // android
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

    // darwin/IOS
    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
      defaultPresentSound: true,
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );

    // initializationSettings for Android/IOS
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );
  }

  /// For Darwin
  void _onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {}

  /// On select notification
  void _onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      Map<String, dynamic> json = jsonDecode(payload!);
      PayloadModel payloadModel = PayloadModel.fromJson(json);

      if (payloadModel.page == 'chat') {
        // navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => ConversationPage()));
      }
    }
  }
}

class PayloadModel {
  final String page;

  PayloadModel({required this.page});

  factory PayloadModel.fromJson(Map<String, dynamic> json) {
    return PayloadModel(
      page: json['page'],
    );
  }
}
