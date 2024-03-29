import 'package:get/get.dart';

import '../../app/routes.dart';
import '../../models/login_models/form_data_error.dart';
// import '../../utils/validate.dart';

class LoginViewModel extends GetxController {
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
    String email,
    String password,
  ) {
    Get.toNamed(Routes.home);
    // if (email.isEmpty) {
    //   formError.value.email = 'Tên đăng nhập không được để trống';
    // } else if (!email.isEmail) {
    //   formError.value.email = 'Vui lòng nhập đúng định dạng email';
    // } else {
    //   formError.value.email = '';
    // }

    // if (password.isEmpty) {
    //   formError.value.password = 'Mật khẩu không được để trống';
    // } else if (!Validate.validatePassword(password)) {
    //   formError.value.password = 'Vui lòng nhập mật khẩu lớn hơn 6 ký tự';
    // } else {
    //   formError.value.password = '';
    // }

    // formError.refresh();
    // if (formError.value ==
    //     FormDataError(
    //       name: '',
    //       email: '',
    //       password: '',
    //     )) {
    //   //
    // }
  }
}
