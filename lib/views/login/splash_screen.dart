import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// import '../../utils/color_app.dart';
import '../../view_models/login_view_models/splash_viewmodel.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final SplashViewModel splashViewModel = Get.put(SplashViewModel());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: const Color(0xFFf9f9f9),
      child: Center(
        child: SvgPicture.asset(
          'assets/images/logo.svg',
          fit: BoxFit.cover,
          width: size.width * 0.5,
        ),
      ),
    );
  }
}
