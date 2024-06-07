import 'package:fashion_app/view_models/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../app/routes.dart';
import '../../services/response/api_status.dart';
import '../../utils/color_app.dart';
import '../../utils/text_themes.dart';
import '../../view_models/login_view_models/login_viewmodel.dart';
import '../widgets/button_primary.dart';
import '../widgets/text_input_container.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginViewModel _loginViewModel = Get.put(LoginViewModel());
  final AuthController _authController = AuthController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).viewPadding.top;
    final appBarHeight = AppBar().preferredSize.height;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFf9f9f9),
      // appBar: AppBar(
      //   scrolledUnderElevation: 0,
      //   backgroundColor: Colors.transparent,
      // ),
      body: SingleChildScrollView(
        child: Container(
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
                  textController: _emailController,
                  title: 'Email',
                  des: 'Nhập email',
                  isLast: _loginViewModel.isLastCheck.value,
                  isPassword: false,
                  errorString: _loginViewModel.formError.value.email,
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => TextInputContainer(
                  textController: _passwordController,
                  title: 'Mật khẩu',
                  des: 'Nhập mật khẩu',
                  isLast: _loginViewModel.isLastCheck.value,
                  isPassword: true,
                  event: _loginViewModel.handleShowPassword,
                  showPassword: _loginViewModel.showPassword.value,
                  errorString: _loginViewModel.formError.value.password,
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
              Obx(
                () {
                  if (_authController.loginRes.value.status == Status.loading) {
                    return const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(color: ColorApp.primary),
                    );
                  }

                  return ButtonPrimary(
                    title: 'Đăng nhập',
                    event: () => _loginViewModel.validate(
                      _emailController.text,
                      _passwordController.text,
                    ),
                  );
                },
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
              const SizedBox(height: 30),
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
                          child: Obx(
                            () {
                              if (_authController.loginRes.value.status ==
                                  Status.loading) {
                                return const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                      color: ColorApp.primary),
                                );
                              }

                              return loginContainer(
                                image: 'assets/icons/google.svg',
                                event: () async {
                                  await _authController
                                      .authenticationWithGoogle();
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Obx(
                            () {
                              if (_authController.loginRes.value.status ==
                                  Status.loading) {
                                return const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                      color: ColorApp.primary),
                                );
                              }

                              return loginContainer(
                                image: 'assets/icons/facebook.svg',
                                event: () async {
                                  await _authController
                                      .authenticationWithFacebook();
                                },
                              );
                            },
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
