
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jog_inventory/common/globals/config.dart';
import 'package:jog_inventory/common/utils/utils.dart';
import 'package:jog_inventory/services/notifications/handle_tap.dart';

class _FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotification = FlutterLocalNotificationsPlugin();
  late final FCMToken;

  /// setup notification fr IOS and android
  Future<void> initNotifications() async {
    var settings = await _firebaseMessaging.requestPermission(
        sound: true,
        badge: true,
        alert: true,
        announcement: true,
        provisional: false);
    print('User granted permission: ${settings.authorizationStatus}');

    // Device Token
    FCMToken = await _firebaseMessaging.getToken();
    print("==============================================================");
    print("FCM token:  ${FCMToken}");
    print("==============================================================");
    await initPushNotification();
    await initLocalNotification();
  }

  /// init push notification
  Future<void> initPushNotification() async {
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true, sound: true, badge: true);

    /// check for the initial message
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();

    /// when app is terminated
    if (initialMessage != null) {
      handleMessageTap(initialMessage);
    }

    /// on background message
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessageTap);
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    /// local notification
    if (config.isAndroid)
      FirebaseMessaging.onMessage.listen(localNotificationHandle);
  }

  /// local notification setup for Ios and Android
  Future<void> initLocalNotification() async {
    // if (config.isAndroid) {
    //   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    //       FlutterLocalNotificationsPlugin();
    //   flutterLocalNotificationsPlugin
    //       .resolvePlatformSpecificImplementation<
    //           AndroidFlutterLocalNotificationsPlugin>()
    //       ?.requestNotificationsPermission();
    // }
    final IOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    const AndroidInitializationSettings android =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final setting = InitializationSettings(android: android, iOS: IOS);
    _localNotification.initialize(setting,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  /// handle local notification for Android and Ios
  localNotificationHandle(RemoteMessage message) {
    final notification = message.notification;
    if (notification == null) return;
    print(message.data);
    var Ios = DarwinNotificationDetails();
    var channel = AndroidNotificationChannel(
        Random.secure().nextInt(1000).toString(), "general_channel",
        importance: Importance.max);
    var androidNotificationDetail = AndroidNotificationDetails(
        channel.id, channel.name,
        importance: Importance.high, priority: Priority.high, ticker: "ticker");
    _localNotification.show(
        notification.hashCode,
        notification.title,
        payload: message.data.toString(),
        notification.body,
        NotificationDetails(android: androidNotificationDetail, iOS: Ios));
  }

  ///
  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) {
    print("Notification tapped");
    print(notificationResponse.payload);
    var payload = ParseData.stringToMap(notificationResponse.payload??"");
    // var payLoad = jsonDecode(notificationResponse.payload);
    navigateUserToPage(payload);
  }

  ////
  Future onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    // _localNotification.show(
    //     id,
    //     title,
    //     body,
    //     NotificationDetails(
    //         iOS: DarwinNotificationDetails(
    //       subtitle: "HElloooo",
    //     )));
  }
}

var firebaseApi = _FirebaseApi();
