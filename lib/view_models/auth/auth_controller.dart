// import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../app/routes.dart';
import '../../configs/configs.dart';
import '../../models/request/request_data.dart';
import '../../models/request/user.dart';
import '../../services/auth/auth_service.dart';
import '../../services/repository/access_server_repository.dart';
import '../../services/response/api_response.dart';
import '../../utils/helper.dart';
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
    try {
      // setLoginRes(ApiResponse.loading());
      final Map<String, dynamic> data =
          await _accessServerRepository.postData(req);

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
      'email': AuthService.user!.providerData[0].email,
      'fullname': AuthService.user!.providerData[0].displayName,
      'image': AuthService.user!.providerData[0].photoURL,
      // 'login_type': AuthService.user!.providerData[0].providerId,
      'login_type': loginType,
    };

    RequestData resquestData = RequestData(
      query: Configs.checkLogin,
      data: Helper.toMapString(data),
    );

    await _fetchData(resquestData);
  }

  Future<void> authenticationWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      setLoginRes(ApiResponse.loading());
      await AuthService.loginWithPassword(email: email, password: password);
      printInfo(info: AuthService.user!.toString());

      await handleLogin('password');

      // Tới màn hình Home
      Get.offAllNamed(Routes.home);
    } catch (e) {
      printError(info: e.toString());
      rethrow;
    }
  }

  Future<void> authenticationWithGoogle() async {
    try {
      setLoginRes(ApiResponse.loading());
      await AuthService.signInWithGoogle();
      printInfo(info: AuthService.user!.toString());

      await handleLogin('google');

      // Tới màn hình Home
      Get.offAllNamed(Routes.home);
    } catch (e) {
      printError(info: e.toString());
    }
  }

  Future<void> authenticationWithFacebook() async {
    try {
      setLoginRes(ApiResponse.loading());
      await AuthService.signInWithFacebook();
      printInfo(info: AuthService.user!.toString());

      await handleLogin('facebook');

      // Tới màn hình Home
      Get.offAllNamed(Routes.home);
    } catch (e) {
      printError(info: e.toString());
    }
  }
}
