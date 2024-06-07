import 'package:get/get.dart';

// import '../../app/routes.dart';
import '../../app/routes.dart';
import '../controllers/user_controller.dart';

class SplashViewModel extends GetxController {
  final UserController _userController = Get.find<UserController>();

  Future<void> initData() async {
    await _userController.handleGetUser();
  }

  Future<void> goToScreen() async {
    await Future.delayed(const Duration(seconds: 1), () {
      Get.offAllNamed(Routes.home);
    });
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }
}
