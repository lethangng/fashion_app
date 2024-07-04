import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/configs.dart';
import '../../models/login_models/password_data_error.dart';
import '../../models/request/request_data.dart';
import '../../services/repository/access_server_repository.dart';
import '../../services/response/api_response.dart';
import '../../utils/helper.dart';
import '../../utils/validate.dart';
import '../controllers/user_controller.dart';

enum PasswordType {
  oldPassword,
  newPassword,
  confirmPassword,
}

class ChangePasswordViewModel extends GetxController {
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  final UserController _userController = Get.find<UserController>();

  final Rx<ApiResponse<bool>> changePasswordRes =
      ApiResponse<bool>.completed(null).obs;
  final Rx<PasswordDataError> formError = PasswordDataError().obs;
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

  void setChangePasswordRes(ApiResponse<bool> res) {
    changePasswordRes.value = res;
  }

  Future<void> _fetchData(RequestData req) async {
    try {
      setChangePasswordRes(ApiResponse.loading());

      await _accessServerRepository.postData(req);

      setChangePasswordRes(ApiResponse.completed(true));

      Get.snackbar(
        'Thông báo',
        'Cập nhật thành công',
        icon: const Icon(Icons.check, color: Colors.green),
        colorText: Colors.white,
        backgroundColor: Colors.black87,
      );
    } catch (e, s) {
      s.printError();
      formError.value.oldPassword = e.toString();
      formError.refresh();
      setChangePasswordRes(ApiResponse.completed(null));
    }
  }

  Future<void> handleLoad({
    required String oldPassword,
    required String newPassword,
  }) async {
    Map<String, dynamic> data = {
      'u_id': _userController.userRes.value.data!.u_id,
      'old_password': oldPassword,
      'new_password': newPassword,
    };

    RequestData resquestData = RequestData(
      query: Configs.changePassword,
      data: Helper.toMapString(data),
    );

    await _fetchData(resquestData);
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
      formError.value.oldPassword = '';
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
    } else {
      formError.value.confirmPassword = '';
    }

    formError.refresh();
    if (formError.value == PasswordDataError()) {
      handleLoad(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
    }
  }
}
