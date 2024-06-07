import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/configs.dart';
import '../../models/request/request_data.dart';
import '../../models/request/user.dart';
import '../../services/auth/auth_service.dart';
import '../../services/repository/access_server_repository.dart';
import '../../services/response/api_response.dart';

class UserController extends GetxController {
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  final Rx<ApiResponse<User>> userRes = ApiResponse<User>.loading().obs;

  void setUserRes(ApiResponse<User> res) {
    userRes.value = res;
  }

  Future<void> _fetchUserDetail(RequestData req) async {
    setUserRes(ApiResponse.loading());
    try {
      final Map<String, dynamic> data =
          await _accessServerRepository.postData(req);

      User user = User.fromMap(data);
      debugPrint(user.toString());

      setUserRes(ApiResponse.completed(user));
    } catch (e) {
      setUserRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleGetUser({String? uId}) async {
    Map<String, dynamic> data = {
      'u_id': uId ?? AuthService.user?.uid ?? 'KKOAW8GqDRXGAvjPZ4biVrWpzho2',
      // 'u_id': uId ?? 'KKOAW8GqDRXGAvjPZ4biVrWpzho2',
    };

    RequestData resquestData = RequestData(
      query: Configs.getUserInfo,
      data: data,
    );

    await _fetchUserDetail(resquestData);
  }
}
