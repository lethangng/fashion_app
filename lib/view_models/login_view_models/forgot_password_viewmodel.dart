import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/configs.dart';
import '../../models/login_models/form_data_error.dart';
import '../../models/request/request_data.dart';
import '../../services/repository/access_server_repository.dart';
import '../../services/response/api_response.dart';
import '../../utils/helper.dart';

class ForgotPasswordViewModel extends GetxController {
  final Rx<FormDataError> formError = FormDataError().obs;

  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();
  final Rx<ApiResponse<bool>> resetPasswordRes =
      ApiResponse<bool>.completed(null).obs;

  void setResetPasswordRes(ApiResponse<bool> res) {
    resetPasswordRes.value = res;
  }

  Future<void> _fetchData(RequestData req) async {
    try {
      setResetPasswordRes(ApiResponse.loading());

      await _accessServerRepository.postData(req);

      setResetPasswordRes(ApiResponse.completed(true));

      Get.snackbar(
        'Thông báo',
        'Mật khẩu đã được gửi vào email của bạn',
        icon: const Icon(Icons.check, color: Colors.green),
        colorText: Colors.white,
        backgroundColor: Colors.black87,
      );
    } catch (e, s) {
      s.printError();
      formError.value.email = e.toString();
      setResetPasswordRes(ApiResponse.completed(null));
    }
  }

  Future<void> handleLoad(String email) async {
    Map<String, dynamic> data = {
      'email': email,
    };

    RequestData resquestData = RequestData(
      query: Configs.resetPassword,
      data: Helper.toMapString(data),
    );

    await _fetchData(resquestData);
  }

  final RxBool isLast = true.obs;

  void validate(String email) {
    isLast.value = false;
    if (email.isEmpty) {
      formError.value.email = 'Email không được để trống';
    } else if (!email.isEmail) {
      formError.value.email = 'Vui lòng nhập đúng định dạng email';
    } else {
      formError.value.email = '';
    }
    formError.refresh();
    if (formError.value == FormDataError()) {
      handleLoad(email);
    }
  }
}
