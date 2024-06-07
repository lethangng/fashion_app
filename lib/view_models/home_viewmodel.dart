import 'package:get/get.dart';

import '../configs/configs.dart';
import '../models/home_models/product.dart';
import '../models/request/request_data.dart';
import '../services/repository/access_server_repository.dart';
import '../services/response/api_response.dart';
import 'controllers/user_controller.dart';

class HomeController extends GetxController {
  final UserController _userController = Get.find<UserController>();
  final RxList<Product> listProductSale = <Product>[].obs;

  int _page = 1;

  final Rx<ApiResponse<List<Product>>> productSaleRes =
      ApiResponse<List<Product>>.loading().obs;
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  void setProductSaleRes(ApiResponse<List<Product>> res) {
    productSaleRes.value = res;
  }

  Future<void> _fetchDataProductSale(RequestData req) async {
    try {
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

  Future<void> handleLoadProductSale() async {
    Map<String, dynamic> data = {
      //
    };

    RequestData resquestData = RequestData(
      query: Configs.getListProduct(
        page: _page,
        limit: 6,
        newest: false,
        sale: true,
        user_id: _userController.userRes.value.data!.id,
      ),
      data: data,
    );

    await _fetchDataProductSale(resquestData);
  }

  Future<void> onRefresh() async {
    _page = 1;
    listProductSale.value = [];
    await handleLoadProductSale();
  }

  @override
  void onInit() {
    handleLoadProductSale();
    super.onInit();
  }
}
