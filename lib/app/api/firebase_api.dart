import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

//final _localNotifications = FlutterLocalNotificationsPlugin();

void handleMessage(RemoteMessage? message) {
  if (message == null) return;

  // navigatorKey.currentState?.pushNamed
}

final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel', 'high Importance Notifications',
    description: 'This channel is used for important notification',
    importance: Importance.defaultImportance);
final _localNotifications = FlutterLocalNotificationsPlugin();

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("title: ${message.notification?.title}");
  print("body: ${message.notification?.body}");
  print("payload: ${message.data}");
}

Future initLocalNotifications() async {
  //const IOS = IOSInitializationSettings();
  const android = AndroidInitializationSettings('@drawable/logo');
  const settings = InitializationSettings(android: android);

  await _localNotifications.initialize(
    settings,
    // onSelectNotification: (payload) {
    //   final message = RemoteMessage.fromMap(jsonDecode(payload!));
    //   handleMessage(message);
    // },
  );

  final platfrom = _localNotifications.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>();

  await platfrom?.createNotificationChannel(_androidChannel);
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print("token untuk firebase: $fCMToken");
    initPushNotifications();
    // initLocalNotifications();
  }
}

Future initPushNotifications() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
  FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {});
  FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  // FirebaseMessaging.onMessage.listen((message) {
  //   final notification = message.notification;
  //   if (notification == null) return;

  //   _localNotifications.show(
  //     notification.hashCode,
  //     notification.title,
  //     notification.body,
  //     NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         _androidChannel.id,
  //         _androidChannel.name,
  //         channelDescription: _androidChannel.description,
  //         icon: '@drawable/logo',
  //       ),
  //     ),
  //     payload: jsonEncode(message.toMap()),
  //   );
  // });
}
