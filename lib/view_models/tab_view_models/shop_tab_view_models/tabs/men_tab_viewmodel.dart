import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../configs/configs.dart';
import '../../../../models/home_models/product.dart';
import '../../../../models/request/request_data.dart';
import '../../../../services/repository/access_server_repository.dart';
import '../../../../services/response/api_response.dart';
import '../../../controllers/user_controller.dart';

class MenTabViewmodel extends GetxController {
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();
  final UserController _userController = Get.find<UserController>();
  final RxList<Product> listProduct = <Product>[].obs;

  final Rx<ApiResponse<List<Product>>> productRes =
      ApiResponse<List<Product>>.loading().obs;

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  int _page = 1;

  void setProductRes(ApiResponse<List<Product>> res) {
    productRes.value = res;
  }

  Future<void> _fetchData(RequestData req) async {
    try {
      final List res = await _accessServerRepository.getData(req);
      List<Product> data = res.map((item) => Product.fromMap(item)).toList();

      setProductRes(ApiResponse.completed(data));
      listProduct.addAll(data);
      listProduct.refresh();
    } catch (e, s) {
      s.printError();
      setProductRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> _handleLoad() async {
    Map<String, dynamic> data = {
      //
    };

    RequestData resquestData = RequestData(
      query: Configs.getListProduct(
        page: _page,
        user_id: _userController.userRes.value.data!.id,
        category_id: 1,
      ),
      data: data,
    );

    await _fetchData(resquestData);
  }

  Future<void> onRefresh() async {
    _page = 1;
    listProduct.value = [];
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
