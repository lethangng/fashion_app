import 'package:get/get.dart';

import '../configs/configs.dart';
import '../models/home_models/product.dart';
import '../models/request/request_data.dart';
import '../services/repository/access_server_repository.dart';
import '../services/response/api_response.dart';
import '../utils/helper.dart';
import 'controllers/user_controller.dart';

class HomeController extends GetxController {
  final UserController _userController = Get.find<UserController>();
  final RxList<Product> listProductSale = <Product>[].obs;
  final RxList<Product> listProductNewest = <Product>[].obs;

  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();
  final Rx<ApiResponse<List<Product>>> productSaleRes =
      ApiResponse<List<Product>>.loading().obs;
  final Rx<ApiResponse<List<Product>>> productNewestRes =
      ApiResponse<List<Product>>.loading().obs;

  void setProductSaleRes(ApiResponse<List<Product>> res) {
    productSaleRes.value = res;
  }

  void setProductNewestRes(ApiResponse<List<Product>> res) {
    productNewestRes.value = res;
  }

  Future<void> _fetchDataProductNewest(RequestData req) async {
    try {
      setProductNewestRes(ApiResponse.loading());
      final List res = await _accessServerRepository.getData(req);
      List<Product> data = res.map((item) => Product.fromMap(item)).toList();

      setProductNewestRes(ApiResponse.completed(data));
      listProductNewest.addAll(data);
      listProductNewest.refresh();
    } catch (e, s) {
      s.printError();
      setProductNewestRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> _handleLoadProductNewest() async {
    Map<String, dynamic> data = {
      //
    };

    RequestData resquestData = RequestData(
      query: Configs.getListProduct(
        page: 1,
        limit: 6,
        newest: true,
        user_id: _userController.userRes.value.data!.id,
      ),
      data: Helper.toMapString(data),
    );

    await _fetchDataProductNewest(resquestData);
  }

  Future<void> _fetchDataProductSale(RequestData req) async {
    try {
      setProductSaleRes(ApiResponse.loading());
      final List res = await _accessServerRepository.getData(req);
      List<Product> data = res.map((item) => Product.fromMap(item)).toList();

      setProductSaleRes(ApiResponse.completed(data));
      listProductSale.addAll(data);
      listProductSale.refresh();
    } catch (e, s) {
      s.printError();
      setProductSaleRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> _handleLoadProductSale() async {
    Map<String, dynamic> data = {
      //
    };

    RequestData resquestData = RequestData(
      query: Configs.getListProduct(
        page: 1,
        limit: 6,
        sale: true,
        user_id: _userController.userRes.value.data!.id,
      ),
      data: Helper.toMapString(data),
    );

    await _fetchDataProductSale(resquestData);
  }

  Future<void> onRefresh() async {
    listProductSale.value = [];
    listProductNewest.value = [];
    await _handleLoadProductSale();
    await _handleLoadProductNewest();
  }

  Future<void> initData() async {
    await _handleLoadProductSale();
    await _handleLoadProductNewest();
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }
}
