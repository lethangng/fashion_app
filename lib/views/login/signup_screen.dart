import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../app/routes.dart';
import '../../utils/text_themes.dart';
import '../../view_models/login_view_models/signup_controller.dart';
import '../widgets/text_input_container.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final SignUpController signUpViewModel = Get.put(SignUpController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).viewPadding.top;
    final appBarHeight = AppBar().preferredSize.height;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFf9f9f9),
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
                        'Tạo tài khoản mới',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Chào mừng bạn đến với Fashion')
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Obx(
                () => TextInputContainer(
                  textController: nameController,
                  title: 'Họ và tên',
                  des: 'Nhập họ và tên',
                  isLast: signUpViewModel.isLast.value,
                  isPassword: false,
                  errorString: signUpViewModel.formError.value.name,
                ),
              ),
              const SizedBox(height: 12),
              Obx(
                () => TextInputContainer(
                  textController: emailController,
                  title: 'Email',
                  des: 'Nhập email',
                  isLast: signUpViewModel.isLast.value,
                  isPassword: false,
                  errorString: signUpViewModel.formError.value.email,
                ),
              ),
              const SizedBox(height: 12),
              Obx(
                () => TextInputContainer(
                  textController: passwordController,
                  title: 'Mật khẩu',
                  des: 'Nhập mật khẩu',
                  isLast: signUpViewModel.isLast.value,
                  isPassword: true,
                  event: () => signUpViewModel.handleShowPassword(
                      passwordType: PasswordType.password),
                  showPassword: signUpViewModel.passwordShow['password'],
                  errorString: signUpViewModel.formError.value.password,
                ),
              ),
              const SizedBox(height: 12),
              Obx(
                () => TextInputContainer(
                  textController: confirmPasswordController,
                  title: 'Nhập lại mật khẩu',
                  des: 'Nhập lại mật khẩu',
                  isLast: signUpViewModel.isLast.value,
                  isPassword: true,
                  event: () => signUpViewModel.handleShowPassword(
                      passwordType: PasswordType.confirmPassword),
                  showPassword: signUpViewModel.passwordShow['confirmPassword'],
                  errorString: signUpViewModel.formError.value.confirmPassword,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFDB3022),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: TextButton(
                  onPressed: () => signUpViewModel.validate(
                    nameController.text,
                    emailController.text,
                    passwordController.text,
                    confirmPasswordController.text,
                  ),
                  child: const Text(
                    'Đăng ký',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.toNamed(Routes.login),
                    child: Row(
                      children: [
                        const Text(
                          'Bạn đã có tài khoản?',
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
              SizedBox(height: Get.height * 0.05),
              SizedBox(
                width: Get.width * 0.6,
                child: Column(
                  children: [
                    Text(
                      'Hoặc bạn cũng có thể đăng ký với',
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
              SizedBox(height: Get.height * 0.05)
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
