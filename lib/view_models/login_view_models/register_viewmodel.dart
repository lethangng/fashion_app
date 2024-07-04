import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes.dart';
import '../../configs/configs.dart';
import '../../models/login_models/form_data_error.dart';
import '../../models/request/request_data.dart';
import '../../services/repository/access_server_repository.dart';
import '../../services/response/api_response.dart';
import '../../utils/helper.dart';
import '../../utils/validate.dart';

enum PasswordType {
  password,
  confirmPassword,
}

class RegisterViewModel extends GetxController {
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  final Rx<ApiResponse<bool>> registerRes =
      ApiResponse<bool>.completed(null).obs;

  final Rx<FormDataError> formError = FormDataError().obs;

  final RxBool isLast = true.obs;

  final RxMap<String, dynamic> passwordShow = {
    'password': false,
    'confirmPassword': false,
  }.obs;

  void setRegisterRes(ApiResponse<bool> res) {
    registerRes.value = res;
  }

  Future<void> _fetchData(RequestData req) async {
    try {
      setRegisterRes(ApiResponse.loading());

      await _accessServerRepository.postData(req);

      setRegisterRes(ApiResponse.completed(true));

      Get.snackbar(
        'Thông báo',
        'Đăng ký thành công',
        icon: const Icon(Icons.check, color: Colors.green),
        colorText: Colors.white,
        backgroundColor: Colors.black87,
      );

      // Tới màn hình Login
      Get.offAllNamed(Routes.login);
    } catch (e, s) {
      s.printError();
      formError.value.email = e.toString();
      formError.refresh();
      setRegisterRes(ApiResponse.completed(null));
    }
  }

  Future<void> handleLoad({
    required String fullname,
    required String email,
    required String password,
  }) async {
    Map<String, dynamic> data = {
      'fullname': fullname,
      'email': email,
      'password': password,
    };

    RequestData resquestData = RequestData(
      query: Configs.register,
      data: Helper.toMapString(data),
    );

    await _fetchData(resquestData);
  }

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
    if (formError.value == FormDataError()) {
      handleLoad(
        fullname: name,
        email: email,
        password: password,
      );
    }
  }
}
