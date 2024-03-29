import 'package:get/get.dart';

import '../../models/login_models/form_data_error.dart';

class ForgotPasswordViewModel extends GetxController {
  final Rx<FormDataError> formError = FormDataError(
    name: '',
    email: '',
    password: '',
  ).obs;

  void validate(String email) {
    if (email.isEmpty) {
      formError.value.email = 'Email không được để trống';
    } else if (!email.isEmail) {
      formError.value.email = 'Vui lòng nhập đúng định dạng email';
    } else {
      formError.value.email = '';
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
