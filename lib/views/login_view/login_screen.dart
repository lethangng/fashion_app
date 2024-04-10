import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../app/routes.dart';
import '../../utils/text_themes.dart';
import '../../view_models/login_view_models/login_controller.dart';
import '../widgets/text_input_container.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController loginViewModel = Get.put(LoginController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).viewPadding.top;
    final appBarHeight = AppBar().preferredSize.height;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFf9f9f9),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            SizedBox(height: height + appBarHeight),
            SvgPicture.asset(
              'assets/images/logo.svg',
              fit: BoxFit.cover,
              width: size.width * 0.5,
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'Đăng nhập tài khoản',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Vui lòng nhập tài khoản của bạn ở đây')
                  ],
                ),
              ],
            ),
            const SizedBox(height: 50),
            Obx(
              () => TextInputContainer(
                textController: emailController,
                title: 'Email',
                des: 'Nhập email',
                isLast: loginViewModel.isLast.value,
                isPassword: false,
                errorString: loginViewModel.formError.value.email,
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => TextInputContainer(
                textController: passwordController,
                title: 'Mật khẩu',
                des: 'Nhập mật khẩu',
                isLast: loginViewModel.isLast.value,
                isPassword: true,
                event: loginViewModel.handleShowPassword,
                showPassword: loginViewModel.showPassword.value,
                errorString: loginViewModel.formError.value.password,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Get.toNamed(Routes.forgotPassword),
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.symmetric(
                      // horizontal: 12,
                      vertical: 6,
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Row(
                    children: [
                      Text(
                        'Quên mật khẩu?',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF3098FF),
                        ),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFDB3022),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: TextButton(
                onPressed: () => loginViewModel.validate(
                  emailController.text,
                  passwordController.text,
                ),
                child: const Text(
                  'Đăng nhập',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Get.toNamed(Routes.signup),
                  child: Row(
                    children: [
                      const Text(
                        'Bạn chưa có tài khoản?',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 5),
                      SvgPicture.asset(
                        'assets/icons/tiep-theo.svg',
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: Get.width * 0.6,
              child: Column(
                children: [
                  Text(
                    'Hoặc bạn cũng có thể đăng nhập với',
                    style: TextThemes.textBlack_14_400,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: loginContainer(
                          image: 'assets/icons/google.svg',
                          event: () {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: loginContainer(
                          image: 'assets/icons/facebook.svg',
                          event: () {},
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.1)
          ],
        ),
      ),
    );
  }

  Widget loginContainer({
    required String image,
    required void Function()? event,
  }) {
    return GestureDetector(
      onTap: event,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              offset: const Offset(0, 1),
              color: const Color(0xFF000000).withOpacity(0.05),
            ),
          ],
        ),
        child: SvgPicture.asset(image),
      ),
    );
  }
}
