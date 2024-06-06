import 'dart:convert';

import 'package:get/get.dart';

import '../../app/routes.dart';
import '../../configs/configs.dart';
import '../../models/request/request_data.dart';
import '../../models/request/user.dart';
import '../../services/auth/auth_service.dart';
import '../../services/repository/access_server_repository.dart';
import '../../services/response/api_response.dart';
import '../controllers/user_controller.dart';

class AuthController {
  final Rx<ApiResponse<bool>> loginRes = ApiResponse<bool>.completed(null).obs;
  final UserController _userController = Get.find<UserController>();

  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  void setLoginRes(ApiResponse<bool> res) {
    loginRes.value = res;
  }

  Future<void> _fetchData(RequestData req) async {
    setLoginRes(ApiResponse.loading());
    try {
      final Map<String, dynamic> data =
          await _accessServerRepository.postData(req.toMap());

      User user = User.fromMap(data);

      printInfo(info: user.toString());

      _userController.setUserRes(ApiResponse.completed(user));
      // await _userController.handleGetUser();
      // await appDataController.handleGetAppData();
      setLoginRes(ApiResponse.completed(true));
    } catch (e) {
      setLoginRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLogin(String loginType) async {
    Map<String, dynamic> data = {
      'u_id': AuthService.user!.uid,
      'email': AuthService.user!.email,
      'login_type': loginType,
    };

    RequestData resquestData = RequestData(
      query: Configs.checkLogin,
      data: json.encode(data),
    );

    await _fetchData(resquestData);
  }

  Future<void> authenticationWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      await AuthService.loginWithPassword(email: email, password: password);
      // printInfo(info: AuthService.user!.toString());

      await handleLogin('password');

      // Tới màn hình Home
      Get.toNamed(Routes.home);
    } catch (e) {
      printError(info: e.toString());
      rethrow;
    }
  }

  Future<void> authenticationWithGoogle() async {
    try {
      await AuthService.signInWithGoogle();
      // printInfo(info: AuthService.user!.toString());

      await handleLogin('google');

      // Tới màn hình Home
      Get.toNamed(Routes.home);
    } catch (e) {
      printError(info: e.toString());
    }
  }

  Future<void> authenticationWithFacebook() async {
    try {
      await AuthService.signInWithFacebook();
      // printInfo(info: AuthService.user!.toString());

      await handleLogin('facebook');

      // Tới màn hình Home
      Get.toNamed(Routes.home);
    } catch (e) {
      printError(info: e.toString());
    }
  }
}
