import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../app/routes.dart';
import '../../view_models/login_view_models/signup_view_model.dart';
import '../widgets/text_input_container.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final SignUpViewModel signUpViewModel = Get.put(SignUpViewModel());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                  isTrue: nameController.text.isNotEmpty,
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
                  isTrue: emailController.text.isNotEmpty,
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
                  isTrue: passwordController.text.isNotEmpty,
                  isPassword: true,
                  event: signUpViewModel.handleShowPassword,
                  showPassword: signUpViewModel.showPassword.value,
                  errorString: signUpViewModel.formError.value.password,
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
            ],
          ),
        ),
      ),
    );
  }
}
