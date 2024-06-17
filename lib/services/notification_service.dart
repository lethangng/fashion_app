import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../view_models/controllers/notification_controller.dart';
// import 'package:flutter/material.dart';

class NotificationSetUp {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initializeNotification() async {
    AwesomeNotifications().initialize(
      'resource://drawable/res_launcher_icon',
      [
        NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'high_importance_channel',
          channelName: 'Chat notifications',
          importance: NotificationImportance.Max,
          vibrationPattern: highVibrationPattern,
          channelShowBadge: true,
          playSound: true,
          onlyAlertOnce: true,
          groupAlertBehavior: GroupAlertBehavior.Children,
          defaultPrivacy: NotificationPrivacy.Private,
          defaultColor: Colors.deepPurple,
          ledColor: Colors.deepPurple,
          channelDescription: 'Chat notifications.',
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true,
    );

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  // void configurePushNotifications(BuildContext context) async {
  void configurePushNotifications() async {
    await initializeNotification();

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    if (Platform.isIOS) getIOSPermission();

    // FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("================");
      print("=========${message.notification!.body}=======");
      print("================");
      if (message.notification != null) {
        createOrderNotifications(
          title: message.notification!.title,
          body: message.notification!.body,
          image: message.notification!.android!.imageUrl,
        );
        // createOrderNotifications(message);
      }
    });
  }

  Future<void> createOrderNotifications(
      {String? title, String? body, String? image}) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 0,
      channelKey: 'high_importance_channel',
      title: title,
      body: body,
      bigPicture: image,
      // largeIcon:
      //     'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
      notificationLayout: NotificationLayout.BigPicture,
    ));
  }

  // void eventListenerCallback(BuildContext context) {
  void eventListenerCallback() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
    );
  }

  void getIOSPermission() {
    _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
  }
}

@pragma("vm:entry-point")
Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  // await createOrderNotifications(message);
  // await Firebase.initializeApp();
  // await AwesomeNotifications().createNotificationFromJsonData(message.data);
}

// Future<void> createOrderNotifications(RemoteMessage message) async {
//   await AwesomeNotifications().createNotification(
//     content: NotificationContent(
//       id: 0,
//       channelKey: 'high_importance_channel',
//       title: message.data['title'],
//       // title: 'ok',
//       body: message.data['body'],
//       bigPicture: message.data['image'],
//       notificationLayout: NotificationLayout.BigPicture,
//       largeIcon: message.data['image'],
//       payload: Map<String, String>.from(message.data),
//       hideLargeIconOnExpand: true,
//     ),
//   );
// }

// class NotificationController {
//   /// Use this method to detect when a new notification or a schedule is created
//   @pragma("vm:entry-point")
//   static Future<void> onActionReceivedMethod(
//       ReceivedNotification receivedNotification) async {
//     // Your code goes here
//   }
// }
