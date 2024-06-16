import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../configs/configs.dart';
import '../../../models/profile_models/order.dart';
import '../../../models/request/request_data.dart';
import '../../../services/repository/access_server_repository.dart';
import '../../../services/response/api_response.dart';
import '../../../utils/helper.dart';
import '../../controllers/user_controller.dart';

class CancelledTabViewmodel extends GetxController {
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();
  final UserController _userController = Get.find<UserController>();
  final RxList<Order> listData = <Order>[].obs;

  final Rx<ApiResponse<List<Order>>> orderRes =
      ApiResponse<List<Order>>.loading().obs;

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  int _page = 1;

  void setOrderRes(ApiResponse<List<Order>> res) {
    orderRes.value = res;
  }

  Future<void> _fetchData(RequestData req) async {
    try {
      final List res = await _accessServerRepository.getData(req);
      List<Order> data = res.map((item) => Order.fromMap(item)).toList();

      setOrderRes(ApiResponse.completed(data));
      listData.addAll(data);
      listData.refresh();
    } catch (e, s) {
      s.printError();
      setOrderRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> _handleLoad() async {
    Map<String, dynamic> data = {
      //
    };

    RequestData resquestData = RequestData(
      query: Configs.getOrder(
        page: _page,
        user_id: _userController.userRes.value.data!.id,
        status: 2,
        limit: 3,
      ),
      data: Helper.toMapString(data),
    );

    await _fetchData(resquestData);
  }

  Future<void> onRefresh() async {
    _page = 1;
    listData.value = [];
    await _handleLoad();
    refreshController.refreshCompleted();
  }

  Future<void> onLoading() async {
    _page++;
    await _handleLoad();
    refreshController.loadComplete();
  }

  @override
  void onInit() {
    _handleLoad();
    super.onInit();
  }
}
