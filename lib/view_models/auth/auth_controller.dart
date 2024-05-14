import 'package:get/get.dart';

import '../../app/routes.dart';
import '../../services/auth/auth_service.dart';

class AuthController {
  Future<void> authenticationWithGoogle() async {
    try {
      await AuthService.signInWithGoogle();
      printInfo(info: AuthService.user!.toString());
      Get.toNamed(Routes.home);
    } catch (e) {
      printError(info: e.toString());
    }
  }

  Future<void> authenticationWithFacebook() async {
    try {
      await AuthService.signInWithFacebook();
      printInfo(info: AuthService.user!.toString());
      Get.toNamed(Routes.home);
    } catch (e) {
      printError(info: e.toString());
    }
  }
}
