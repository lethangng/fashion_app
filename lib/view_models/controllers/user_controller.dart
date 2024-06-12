import 'package:get/get.dart';

import '../../configs/configs.dart';
import '../../models/request/request_data.dart';
import '../../models/request/user.dart';
import '../../services/auth/auth_service.dart';
import '../../services/repository/access_server_repository.dart';
import '../../services/response/api_response.dart';
import '../../utils/helper.dart';

class UserController extends GetxController {
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  final Rx<ApiResponse<User>> userRes = ApiResponse<User>.loading().obs;

  void setUserRes(ApiResponse<User> res) {
    userRes.value = res;
  }

  Future<void> _fetchUserDetail(RequestData req) async {
    try {
      setUserRes(ApiResponse.loading());
      final Map<String, dynamic> data =
          await _accessServerRepository.postData(req);

      User user = User.fromMap(data);
      printInfo(info: user.toString());

      setUserRes(ApiResponse.completed(user));
    } catch (e) {
      setUserRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleGetUser() async {
    if (AuthService.user == null) {
      setUserRes(ApiResponse.completed(null));
      return;
    }

    Map<String, dynamic> data = {
      'u_id': AuthService.user!.uid,
      // 'u_id': uId ?? 'KKOAW8GqDRXGAvjPZ4biVrWpzho2',
    };

    RequestData resquestData = RequestData(
      query: Configs.getUserInfo,
      data: Helper.toMapString(data),
    );

    await _fetchUserDetail(resquestData);
  }
}
