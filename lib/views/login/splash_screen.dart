import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// import '../../utils/color_app.dart';
import '../../services/response/api_status.dart';
import '../../utils/text_themes.dart';
import '../../view_models/controllers/user_controller.dart';
import '../../view_models/login_view_models/splash_viewmodel.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final SplashViewModel _splashViewModel = Get.put(SplashViewModel());
  final UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf9f9f9),
      body: Obx(() {
        if (_userController.userRes.value.status == Status.error) {
          showDialogError(error: _userController.userRes.value.message!);
        }

        if (_userController.userRes.value.status == Status.completed) {
          _splashViewModel.goToScreen();
        }

        return loading();
      }),
    );
  }

  void showDialogError({required String error}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.dialog(
        barrierDismissible: false,
        Center(
          child: Container(
            width: Get.width * 0.8,
            decoration: const BoxDecoration(
              color: Color(0xFF202025),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Material(
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/sad.png',
                        height: Get.height * 0.25,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      error,
                      textAlign: TextAlign.center,
                      style: TextThemes.text16_600,
                    ),
                    // const SizedBox(height: 16),
                    // ButtonPrimary(
                    //   title: 'Thử lại',
                    //   event: () {
                    //     Get.back();
                    //     Future.delayed(const Duration(seconds: 1), () {
                    //       _splashViewModel.fetchDataAppId();
                    //     });
                    //   },
                    // )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Center loading() {
    return Center(
      child: SvgPicture.asset(
        'assets/images/logo.svg',
        fit: BoxFit.cover,
        width: Get.width * 0.5,
      ),
    );
  }
}
