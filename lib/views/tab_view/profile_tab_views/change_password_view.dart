import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../utils/color_app.dart';
import '../../../view_models/profile_view_models/change_password_controller.dart';
import '../../widgets/button_primary.dart';
import '../../widgets/text_input_container.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({super.key});

  final ChangePasswordController changePasswordViewModel =
      Get.put(ChangePasswordController());

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Obx(
              () => TextInputContainer(
                textController: oldPasswordController,
                title: 'Mật khẩu cũ',
                des: 'Nhập mật khẩu cũ',
                isLast: changePasswordViewModel.isLast.value,
                isPassword: true,
                event: () => changePasswordViewModel.handleShowPassword(
                    passwordType: PasswordType.oldPassword),
                showPassword:
                    changePasswordViewModel.passwordShow['oldPassword'],
                errorString:
                    changePasswordViewModel.formError.value.oldPassword,
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
                textController: newPasswordController,
                title: 'Mật khẩu mới',
                des: 'Nhập mật khẩu mới',
                isLast: changePasswordViewModel.isLast.value,
                isPassword: true,
                event: () => changePasswordViewModel.handleShowPassword(
                    passwordType: PasswordType.newPassword),
                showPassword:
                    changePasswordViewModel.passwordShow['newPassword'],
                errorString:
                    changePasswordViewModel.formError.value.newPassword,
              ),
            ),
            const SizedBox(height: 24),
            Obx(
              () => TextInputContainer(
                textController: confirmPasswordController,
                title: 'Nhập lại mật khẩu',
                des: 'Nhập lại mật khẩu',
                isLast: changePasswordViewModel.isLast.value,
                isPassword: true,
                event: () => changePasswordViewModel.handleShowPassword(
                    passwordType: PasswordType.confirmPassword),
                showPassword:
                    changePasswordViewModel.passwordShow['confirmPassword'],
                errorString:
                    changePasswordViewModel.formError.value.confirmPassword,
              ),
            ),
            const SizedBox(height: 24),
            ButtonPrimary(
              title: 'Lưu',
              isUpperCase: true,
              event: () => changePasswordViewModel.validate(
                oldPasswordController.text,
                newPasswordController.text,
                confirmPasswordController.text,
              ),
            ),
          ],
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
