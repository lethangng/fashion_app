import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../app/routes.dart';
import '../../services/notification_service.dart';
import '../profile_view_models/history_viewmodel.dart';

class NotificationController extends GetxController {
  final NotificationSetUp _noti = NotificationSetUp();

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here

    Map<String, String?>? payload = receivedNotification.payload;
    // print('payload: $payload');

    if (payload != null) {
      Get.put(HistoryViewModel());
      Get.toNamed(Routes.orderDetail, arguments: {
        'orderId': int.parse(payload['order_id']!),
      });
    }
  }

  // Future<void> initData() async {
  //   if (Platform.isAndroid) {
  //     final String? token = await FirebaseMessaging.instance.getToken();
  //     debugPrint(token);
  //   }
  // }

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

    // initData();
    super.onInit();
  }
}
