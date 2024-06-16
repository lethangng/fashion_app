import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../services/response/api_status.dart';
import '../../../utils/color_app.dart';
import '../../../view_models/profile_view_models/change_password_viewmodel.dart';
import '../../widgets/button_primary.dart';
import '../../widgets/text_input_container.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({super.key});

  final ChangePasswordViewModel _changePasswordViewModel =
      Get.put(ChangePasswordViewModel());

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Đổi mật khẩu',
          style: TextStyle(
            color: Color(0xFF222222),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Obx(
                () => TextInputContainer(
                  textController: _oldPasswordController,
                  title: 'Mật khẩu cũ',
                  des: 'Nhập mật khẩu cũ',
                  isLast: _changePasswordViewModel.isLast.value,
                  isPassword: true,
                  event: () => _changePasswordViewModel.handleShowPassword(
                      passwordType: PasswordType.oldPassword),
                  showPassword:
                      _changePasswordViewModel.passwordShow['oldPassword'],
                  errorString:
                      _changePasswordViewModel.formError.value.oldPassword,
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onTap: () => Get.toNamed(Routes.forgotPassword),
                  child: const Text(
                    'Quên mật khẩu?',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorApp.gray,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Obx(
                () => TextInputContainer(
                  textController: _newPasswordController,
                  title: 'Mật khẩu mới',
                  des: 'Nhập mật khẩu mới',
                  isLast: _changePasswordViewModel.isLast.value,
                  isPassword: true,
                  event: () => _changePasswordViewModel.handleShowPassword(
                      passwordType: PasswordType.newPassword),
                  showPassword:
                      _changePasswordViewModel.passwordShow['newPassword'],
                  errorString:
                      _changePasswordViewModel.formError.value.newPassword,
                ),
              ),
              const SizedBox(height: 24),
              Obx(
                () => TextInputContainer(
                  textController: _confirmPasswordController,
                  title: 'Nhập lại mật khẩu',
                  des: 'Nhập lại mật khẩu',
                  isLast: _changePasswordViewModel.isLast.value,
                  isPassword: true,
                  event: () => _changePasswordViewModel.handleShowPassword(
                      passwordType: PasswordType.confirmPassword),
                  showPassword:
                      _changePasswordViewModel.passwordShow['confirmPassword'],
                  errorString:
                      _changePasswordViewModel.formError.value.confirmPassword,
                ),
              ),
              const SizedBox(height: 24),
              Obx(
                () {
                  if (_changePasswordViewModel.changePasswordRes.value.status ==
                      Status.loading) {
                    return const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(color: ColorApp.primary),
                    );
                  }

                  return ButtonPrimary(
                    title: 'Cập nhật',
                    isUpperCase: true,
                    event: () => _changePasswordViewModel.validate(
                      _oldPasswordController.text,
                      _newPasswordController.text,
                      _confirmPasswordController.text,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget containerInfo({
    required String title,
    required String value,
    required String textHind,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            offset: const Offset(0, 1),
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: ColorApp.gray,
            ),
          ),
          const SizedBox(height: 3),
          TextField(
            // controller: controller,
            // obscureText: isPassword,
            cursorColor: ColorApp.colorGrey2,
            style: const TextStyle(color: Colors.white),
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              isDense: true, // Cho chu can giua theo chieu doc
              hintText: textHind,
              hintStyle: const TextStyle(
                color: ColorApp.colorGrey2,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
