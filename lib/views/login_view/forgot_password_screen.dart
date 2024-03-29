import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view_models/login_view_models/forgot_password_view_model.dart';
import '../widgets/app_bar_container.dart';
import '../widgets/text_input_container.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final ForgotPasswordViewModel forgotPasswordViewModel =
      Get.put(ForgotPasswordViewModel());
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFf9f9f9),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const AppBarContainer(title: 'Quên mật khẩu'),
              SizedBox(
                height: size.height * 0.09,
              ),
              Center(
                child: Image.asset(
                  'assets/images/sad.png',
                  height: size.height * 0.25,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              const Text(
                'Quên mật khẩu?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  // color: Colors.white,
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              const Center(
                child: Text(
                  'Đừng lo lắng, Nhập email bạn đã đăng ký và chúng tôi sẽ gửi cho bạn một mã xác nhận để đặt lại mật khẩu của bạn.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    // color: ColorApp.colorGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: size.height * 0.035,
              ),
              Obx(
                () => TextInputContainer(
                  textController: emailController,
                  title: 'Email',
                  des: 'Nhập email',
                  isTrue: emailController.text.isNotEmpty,
                  isPassword: false,
                  errorString: forgotPasswordViewModel.formError.value.email,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFDB3022),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: TextButton(
                  onPressed: () {
                    forgotPasswordViewModel.validate(emailController.text);
                  },
                  child: const Text(
                    'Tiếp tục',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
