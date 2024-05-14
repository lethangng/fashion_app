import 'package:get/get.dart';

import '../../models/login_models/password_data_error.dart';
import '../../utils/validate.dart';

enum PasswordType {
  oldPassword,
  newPassword,
  confirmPassword,
}

class ChangePasswordController extends GetxController {
  final Rx<PasswordDataError> formError = PasswordDataError(
    oldPassword: '',
    newPassword: '',
    confirmPassword: '',
  ).obs;
  final RxBool isLast = true.obs;

  final RxMap<String, dynamic> passwordShow = {
    'oldPassword': false,
    'newPassword': false,
    'confirmPassword': false,
  }.obs;

  void handleShowPassword({required PasswordType passwordType}) {
    if (passwordType == PasswordType.oldPassword) {
      passwordShow['oldPassword'] = !passwordShow['oldPassword'];
    } else if (passwordType == PasswordType.newPassword) {
      passwordShow['newPassword'] = !passwordShow['newPassword'];
    } else if (passwordType == PasswordType.confirmPassword) {
      passwordShow['confirmPassword'] = !passwordShow['confirmPassword'];
    }
    passwordShow.refresh();
  }

  void validate(
    String oldPassword,
    String newPassword,
    String confirmPassword,
  ) {
    isLast.value = false;
    if (oldPassword.isEmpty) {
      formError.value.oldPassword = 'Mật khẩu không được để trống';
    } else if (true) {
      // Goi API check password
    }

    if (newPassword.isEmpty) {
      formError.value.newPassword = 'Mật khẩu không được để trống';
    } else if (Validate.validatePassword(newPassword) == PasswordError.sort) {
      formError.value.newPassword = 'Vui lòng nhập mật khẩu lớn hơn 6 ký tự';
    } else if (Validate.validatePassword(newPassword) == PasswordError.long) {
      formError.value.newPassword = 'Vui lòng nhập mật khẩu nhỏ hơn 20 ký tự';
      // } else if (Validate.validatePassword(newPassword) == PasswordError.format) {
      //   formError.value.newPassword =
      //       'Vui lòng nhập mật khẩu chứa ít nhất 1 chữ hoa và 1 ký tự đặc biệt';
    } else {
      formError.value.newPassword = '';
    }

    if (confirmPassword.isEmpty) {
      formError.value.confirmPassword = 'Mật khẩu nhập lại không được để trống';
    } else if (!Validate.validateConfirmPassword(
        newPassword, confirmPassword)) {
      formError.value.confirmPassword = 'Mật khẩu nhập lại không đúng';
    }

    formError.refresh();
    if (formError.value ==
        PasswordDataError(
          oldPassword: '',
          newPassword: '',
          confirmPassword: '',
        )) {
      //
    }
  }
}
