import 'package:get/get.dart';

// import 'app_data_controller.dart';
import '../auth/auth_controller.dart';
import 'notification_controller.dart';
import 'user_controller.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<NotificationController>(NotificationController());
    // Get.put<NetworkController>(NetworkController());
    Get.put<UserController>(UserController());
    Get.put<AuthController>(AuthController());
  }
}
