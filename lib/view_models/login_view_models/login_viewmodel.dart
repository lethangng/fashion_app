import 'package:get/get.dart';

import '../../models/login_models/form_data_error.dart';
import '../../services/auth/auth_service.dart';
import '../../utils/validate.dart';
import '../auth/auth_controller.dart';

class LoginViewModel extends GetxController {
  final AuthController _authController = Get.find<AuthController>();
  final Rx<FormDataError> formError = FormDataError().obs;

  final RxBool isLastCheck = true.obs;
  final RxBool showPassword = false.obs;

  void handleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  Future<void> validate(
    String email,
    String password,
  ) async {
    isLastCheck.value = false;

    if (email.isEmpty) {
      formError.value.email = 'Tên đăng nhập không được để trống';
    } else if (!email.isEmail) {
      formError.value.email = 'Vui lòng nhập đúng định dạng email';
    } else {
      formError.value.email = '';
    }

    if (password.isEmpty) {
      formError.value.password = 'Mật khẩu không được để trống';
    } else if (Validate.validatePassword(password) == PasswordError.sort) {
      formError.value.password = 'Vui lòng nhập mật khẩu lớn hơn 6 ký tự';
    } else if (Validate.validatePassword(password) == PasswordError.long) {
      formError.value.password = 'Vui lòng nhập mật khẩu nhỏ hơn 20 ký tự';
    } else {
      formError.value.password = '';
    }

    if (formError.value == FormDataError()) {
      try {
        formError.refresh();
        await _authController.authenticationWithPassword(
          email: email,
          password: password,
        );
      } on AuthException catch (e) {
        formError.value.email = e.toString();
        formError.value.password = e.toString();
      }
    }
    formError.refresh();
  }
}
