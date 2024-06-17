import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../services/notification_service.dart';

class NotificationController extends GetxController {
  final NotificationSetUp _noti = NotificationSetUp();

  // String? deviceToken;

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here

    // Map<String, String?>? payload = receivedNotification.payload;
    //
  }

  Future<void> initData() async {
    if (Platform.isAndroid) {
      final String? token = await FirebaseMessaging.instance.getToken();
      // deviceToken = token;
      debugPrint(token);
    }
  }

  Future<String?> getToken() async {
    if (Platform.isAndroid) {
      final String? token = await FirebaseMessaging.instance.getToken();
      return token;
    }
    return null;
  }

  @override
  void onInit() {
    _noti.configurePushNotifications();
    _noti.eventListenerCallback();

    initData();
    super.onInit();
  }
}
