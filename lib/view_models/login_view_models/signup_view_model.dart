import 'package:get/get.dart';

import '../../models/login_models/form_data_error.dart';
import '../../utils/validate.dart';

class SignUpViewModel extends GetxController {
  final Rx<FormDataError> formError = FormDataError(
    name: '',
    email: '',
    password: '',
  ).obs;
  final RxBool showPassword = false.obs;

  void handleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void validate(
    String name,
    String email,
    String password,
  ) {
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
    } else if (Validate.validatePassword(password) == PasswordError.format) {
      formError.value.password =
          'Vui lòng nhập mật khẩu chứa ít nhất 1 chữ hoa và 1 ký tự đặc biệt';
    } else {
      formError.value.password = '';
    }

    formError.refresh();
    if (formError.value ==
        FormDataError(
          name: '',
          email: '',
          password: '',
        )) {
      //
    }
  }
}
