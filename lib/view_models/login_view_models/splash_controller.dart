import 'package:get/get.dart';

import '../../app/routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    goToHomeScreen();
    super.onInit();
  }

  void goToHomeScreen() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(Routes.home);
    });
  }
}
