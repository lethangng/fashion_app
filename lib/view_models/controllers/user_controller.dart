import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/request/request_data.dart';
import '../../models/request/user.dart';
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
          await _accessServerRepository.postData(req.toMap());

      User user = User.fromMap(data);
      debugPrint(user.toString());

      setUserRes(ApiResponse.completed(user));
    } catch (e) {
      setUserRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleGetUser({String? uId}) async {
    Map<String, dynamic> data = {
      'u_id': uId ?? 'sr7yFfa3IkUqXdQQGJaUyKfNUsq1',
    };

    RequestData resquestData = RequestData(
      query: 'user-info',
      data: json.encode(data),
    );

    await _fetchUserDetail(resquestData);
  }
}
