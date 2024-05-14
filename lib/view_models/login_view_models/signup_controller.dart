import 'package:get/get.dart';

import '../../models/login_models/form_data_error.dart';
import '../../utils/validate.dart';

enum PasswordType {
  password,
  confirmPassword,
}

class SignUpController extends GetxController {
  final Rx<FormDataError> formError = FormDataError(
    name: '',
    email: '',
    password: '',
    confirmPassword: '',
  ).obs;

  final RxBool isLast = true.obs;

  final RxMap<String, dynamic> passwordShow = {
    'password': false,
    'confirmPassword': false,
  }.obs;

  void handleShowPassword({required PasswordType passwordType}) {
    if (passwordType == PasswordType.password) {
      passwordShow['password'] = !passwordShow['password'];
    } else if (passwordType == PasswordType.confirmPassword) {
      passwordShow['confirmPassword'] = !passwordShow['confirmPassword'];
    }
    passwordShow.refresh();
  }

  void validate(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) {
    isLast.value = false;
    if (name.isEmpty) {
      formError.value.name = 'Họ và tên không được để trống';
    } else {
      formError.value.name = '';
    }

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
      // } else if (Validate.validatePassword(password) == PasswordError.format) {
      //   formError.value.password =
      //       'Vui lòng nhập mật khẩu chứa ít nhất 1 chữ hoa và 1 ký tự đặc biệt';
    } else {
      formError.value.password = '';
    }

    if (confirmPassword.isEmpty) {
      formError.value.confirmPassword = 'Mật khẩu nhập lại không được để trống';
    } else if (!Validate.validateConfirmPassword(password, confirmPassword)) {
      formError.value.confirmPassword = 'Mật khẩu nhập lại không đúng';
    }

    formError.refresh();
    if (formError.value ==
        FormDataError(
          name: '',
          email: '',
          password: '',
          confirmPassword: '',
        )) {
      //
    }
  }
}
