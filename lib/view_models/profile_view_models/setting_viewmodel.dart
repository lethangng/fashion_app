import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/configs.dart';
import '../../models/request/request_data.dart';
import '../../models/request/user.dart';
import '../../models/uploads/upload_file.dart';
import '../../services/repository/access_server_repository.dart';
import '../../services/response/api_response.dart';
import '../../utils/helper.dart';
import '../controllers/user_controller.dart';

class SettingViewmodel extends GetxController {
  final UserController _userController = Get.find<UserController>();
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  final Rx<ApiResponse<User>> updateInfoRes =
      ApiResponse<User>.completed(null).obs;

  final Rx<ApiResponse<bool>> uploadImageRes =
      ApiResponse<bool>.completed(null).obs;

  final Rx<File?> selectedImage = Rx<File?>(null);

  String? imageUrl;

  void setUpdateInfoRes(ApiResponse<User> res) {
    updateInfoRes.value = res;
  }

  void setSelectImage(File value) {
    selectedImage.value = value;
  }

  void setUploadImageRes(ApiResponse<bool> res) {
    uploadImageRes.value = res;
  }

  Future<void> _fetchDataUpdateImage(UploadFile req) async {
    try {
      setUploadImageRes(ApiResponse.loading());
      final String data = await _accessServerRepository.uploadFile(req);

      imageUrl = data;

      setUploadImageRes(ApiResponse.completed(true));
    } catch (e) {
      setUploadImageRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleUpdateImage() async {
    Map<String, dynamic> data = {
      //
    };

    UploadFile resquestData = UploadFile(
      query: Configs.uploadImage,
      data: Helper.toMapString(data),
      file: selectedImage.value!,
    );

    await _fetchDataUpdateImage(resquestData);
  }

  Future<void> _fetchDataUpdateInfo(RequestData req) async {
    try {
      final Map<String, dynamic> data =
          await _accessServerRepository.postData(req);

      User user = User.fromMap(data);
      _userController.setUserRes(ApiResponse.completed(user));
      printInfo(info: user.toString());

      setUpdateInfoRes(ApiResponse.completed(user));

      Get.snackbar(
        'Thông báo',
        'Cập nhật thành công',
        colorText: Colors.white,
        backgroundColor: Colors.black87,
      );
    } catch (e) {
      setUpdateInfoRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleUpdate({
    required String fullname,
    required String phoneNumber,
  }) async {
    setUpdateInfoRes(ApiResponse.loading());
    Map<String, dynamic> data = {
      'user_id': _userController.userRes.value.data!.id,
      'fullname': fullname,
      'phone_number': phoneNumber,
    };

    if (selectedImage.value != null) {
      await handleUpdateImage();
      data['image'] = imageUrl;
    }

    RequestData resquestData = RequestData(
      query: Configs.updateInfo,
      data: Helper.toMapString(data),
    );

    await _fetchDataUpdateInfo(resquestData);
  }
}
