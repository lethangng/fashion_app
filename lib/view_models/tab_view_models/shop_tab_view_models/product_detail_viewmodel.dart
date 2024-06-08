import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

import '../../../configs/configs.dart';
import '../../../models/home_models/product_detail.dart';
import '../../../models/request/request_data.dart';
import '../../../services/repository/access_server_repository.dart';
import '../../../services/response/api_response.dart';
import '../../controllers/user_controller.dart';

class ProductDetailViewmodel extends GetxController {
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();
  final UserController _userController = Get.find<UserController>();
  final Rx<ApiResponse<ProductDetail>> productDetailRes =
      ApiResponse<ProductDetail>.loading().obs;

  final Rx<ApiResponse<bool>> addFavoriteRes = ApiResponse<bool>.loading().obs;

  final RxBool isShow = false.obs;

  void setIsShow() {
    isShow.value = !isShow.value;
  }

  void setProductDetailRes(ApiResponse<ProductDetail> res) {
    productDetailRes.value = res;
  }

  void setAddFavoriteRes(ApiResponse<bool> res) {
    addFavoriteRes.value = res;
  }

  Future<void> _fetchData(RequestData req) async {
    try {
      setProductDetailRes(ApiResponse.loading());
      final Map<String, dynamic> res =
          await _accessServerRepository.getData(req);

      ProductDetail product = ProductDetail.fromMap(res);

      setProductDetailRes(ApiResponse.completed(product));
    } catch (e, s) {
      s.printError();
      setProductDetailRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoad() async {
    Map<String, dynamic> data = {
      //
    };

    RequestData resquestData = RequestData(
      query: Configs.getDetailProduct(
        id: productId,
        user_id: _userController.userRes.value.data!.id,
      ),
      data: data,
    );

    await _fetchData(resquestData);
  }

  Future<void> _fetchDataAddFavorite(RequestData req) async {
    try {
      setProductDetailRes(ApiResponse.loading());
      final Map<String, dynamic> res =
          await _accessServerRepository.postData(req);

      ProductDetail product = ProductDetail.fromMap(res);

      setProductDetailRes(ApiResponse.completed(product));
    } catch (e, s) {
      s.printError();
      setProductDetailRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoadAddFavorite() async {
    Map<String, dynamic> data = {
      'product_id': productId,
      'user_id': _userController.userRes.value.data!.id,
    };

    RequestData resquestData = RequestData(
      query: Configs.addFavoriteProduct,
      data: data,
    );

    await _fetchDataAddFavorite(resquestData);
  }

  // final List<String> imgList = [
  //   'assets/images/product-detail-1.png',
  //   'assets/images/product-detail-2.png',
  //   'assets/images/product-detail-1.png',
  // ];

  late final int productId;

  final RxInt current = 0.obs;
  final CarouselController controller = CarouselController();

  void handleOnPageChange(int value) {
    current.value = value;
  }

  @override
  void onInit() {
    productId = Get.arguments['productId'];

    handleLoad();
    super.onInit();
  }
}
