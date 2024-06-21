import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// import '../../app/routes.dart';
import '../../services/response/api_status.dart';
import '../../utils/color_app.dart';
import '../../view_models/login_view_models/register_viewmodel.dart';
import '../widgets/button_primary.dart';
import '../widgets/text_input_container.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final RegisterViewModel _registerViewmodel = Get.put(RegisterViewModel());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
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
                          fontSize: 30,
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
                  textController: _nameController,
                  title: 'Họ và tên',
                  des: 'Nhập họ và tên',
                  isLast: _registerViewmodel.isLast.value,
                  isPassword: false,
                  errorString: _registerViewmodel.formError.value.name,
                ),
              ),
              const SizedBox(height: 12),
              Obx(
                () => TextInputContainer(
                  textController: _emailController,
                  title: 'Email',
                  des: 'Nhập email',
                  isLast: _registerViewmodel.isLast.value,
                  isPassword: false,
                  errorString: _registerViewmodel.formError.value.email,
                ),
              ),
              const SizedBox(height: 12),
              Obx(
                () => TextInputContainer(
                  textController: _passwordController,
                  title: 'Mật khẩu',
                  des: 'Nhập mật khẩu',
                  isLast: _registerViewmodel.isLast.value,
                  isPassword: true,
                  event: () => _registerViewmodel.handleShowPassword(
                      passwordType: PasswordType.password),
                  showPassword: _registerViewmodel.passwordShow['password'],
                  errorString: _registerViewmodel.formError.value.password,
                ),
              ),
              const SizedBox(height: 12),
              Obx(
                () => TextInputContainer(
                  textController: _confirmPasswordController,
                  title: 'Nhập lại mật khẩu',
                  des: 'Nhập lại mật khẩu',
                  isLast: _registerViewmodel.isLast.value,
                  isPassword: true,
                  event: () => _registerViewmodel.handleShowPassword(
                      passwordType: PasswordType.confirmPassword),
                  showPassword:
                      _registerViewmodel.passwordShow['confirmPassword'],
                  errorString:
                      _registerViewmodel.formError.value.confirmPassword,
                ),
              ),
              const SizedBox(height: 30),
              Obx(
                () {
                  if (_registerViewmodel.registerRes.value.status ==
                      Status.loading) {
                    return const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(color: ColorApp.primary),
                    );
                  }

                  return ButtonPrimary(
                    title: 'Đăng ký',
                    isUpperCase: true,
                    event: () => _registerViewmodel.validate(
                      _nameController.text,
                      _emailController.text,
                      _passwordController.text,
                      _confirmPasswordController.text,
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    // onPressed: () => Get.toNamed(Routes.login),
                    onPressed: () => Get.back(),
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
