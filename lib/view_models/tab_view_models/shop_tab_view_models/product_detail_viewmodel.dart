import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/configs.dart';
import '../../../models/home_models/evaluate.dart';
import '../../../models/home_models/product.dart';
import '../../../models/home_models/product_detail.dart';
import '../../../models/request/request_data.dart';
import '../../../services/repository/access_server_repository.dart';
import '../../../services/response/api_response.dart';
import '../../../utils/helper.dart';
import '../../controllers/user_controller.dart';
import '../favorite_tab_viewmodel.dart';

class ProductDetailViewmodel extends GetxController {
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();
  final UserController _userController = Get.find<UserController>();
  final FavoriteTabViewmodel _favoriteTabViewmodel =
      Get.find<FavoriteTabViewmodel>();

  final Rx<ApiResponse<ProductDetail>> productDetailRes =
      ApiResponse<ProductDetail>.loading().obs;

  final Rx<ApiResponse<bool>> addFavoriteRes = ApiResponse<bool>.loading().obs;
  final Rx<ApiResponse<bool>> addCartRes = ApiResponse<bool>.loading().obs;
  final Rx<ApiResponse<List<Evaluate>>> evaluateRes =
      ApiResponse<List<Evaluate>>.loading().obs;

  final Rx<ApiResponse<List<Product>>> productRes =
      ApiResponse<List<Product>>.loading().obs;

  final RxList<Product> listProduct = <Product>[].obs;

  final RxList<Evaluate> listEvaluate = <Evaluate>[].obs;

  final RxBool isShow = false.obs;
  final RxBool isFavorite = false.obs;

  late final int productId;

  final RxInt current = 0.obs;
  final CarouselController controller = CarouselController();

  void handleOnPageChange(int value) {
    current.value = value;
  }

  void setIsShow() {
    isShow.value = !isShow.value;
  }

  void setProductRes(ApiResponse<List<Product>> res) {
    productRes.value = res;
  }

  void setProductDetailRes(ApiResponse<ProductDetail> res) {
    productDetailRes.value = res;
  }

  void setAddFavoriteRes(ApiResponse<bool> res) {
    addFavoriteRes.value = res;
  }

  void setAddCartRes(ApiResponse<bool> res) {
    addCartRes.value = res;
  }

  void setEvaluateRes(ApiResponse<List<Evaluate>> res) {
    evaluateRes.value = res;
  }

  Future<void> _fetchDataRecommendations(RequestData req) async {
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

  Future<void> _handleLoadRecommendations() async {
    Map<String, dynamic> data = {
      //
    };

    RequestData resquestData = RequestData(
      query: Configs.getRecommendationsProduct(
        product_id: productId,
      ),
      data: Helper.toMapString(data),
    );

    await _fetchDataRecommendations(resquestData);
  }

  Future<void> _fetchData(RequestData req) async {
    try {
      setProductDetailRes(ApiResponse.loading());
      final Map<String, dynamic> res =
          await _accessServerRepository.getData(req);

      ProductDetail product = ProductDetail.fromMap(res);
      if (product.favorite) isFavorite.value = true;
      // idColor = product.colors.first.id;
      // idSize = product.sizes.first.id;

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
        // user_id: _userController.userRes.value.data!.id,
      ),
      data: Helper.toMapString(data),
    );

    await _fetchData(resquestData);
  }

  Future<void> _fetchDataEvaluate(RequestData req) async {
    try {
      setEvaluateRes(ApiResponse.loading());
      final List res = await _accessServerRepository.getData(req);
      List<Evaluate> data = res.map((item) => Evaluate.fromMap(item)).toList();

      listEvaluate.addAll(data);
      listEvaluate.refresh();

      setEvaluateRes(ApiResponse.completed(data));
    } catch (e, s) {
      s.printError();
      setEvaluateRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> _handleLoadEvaluate() async {
    Map<String, dynamic> data = {
      //
    };

    RequestData resquestData = RequestData(
      query: Configs.getEvaluate(
        page: 1,
        product_id: productId,
      ),
      data: Helper.toMapString(data),
    );

    await _fetchDataEvaluate(resquestData);
  }

  Future<void> _fetchDataAddFavorite(RequestData req) async {
    try {
      setAddFavoriteRes(ApiResponse.loading());
      final Map<String, dynamic> map =
          await _accessServerRepository.postData(req);
      isFavorite.value = !isFavorite.value;

      setAddFavoriteRes(ApiResponse.completed(true));
      Get.snackbar(
        'Thông báo',
        '${map['msg']}',
        icon: const Icon(Icons.check, color: Colors.green),
        colorText: Colors.white,
        backgroundColor: Colors.black87,
      );
      await _favoriteTabViewmodel.onRefresh();
    } catch (e, s) {
      s.printError();
      setAddFavoriteRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoadAddFavorite() async {
    Map<String, dynamic> data = {
      'product_id': productId,
      'user_id': _userController.userRes.value.data!.id,
    };

    RequestData resquestData = RequestData(
      query: Configs.addFavoriteProduct,
      data: Helper.toMapString(data),
    );

    await _fetchDataAddFavorite(resquestData);
  }

  Future<void> _fetchDataAddCart(RequestData req) async {
    try {
      setAddCartRes(ApiResponse.loading());
      Map<String, dynamic> map = await _accessServerRepository.postData(req);

      setAddCartRes(ApiResponse.completed(true));
      Get.snackbar(
        'Thông báo',
        '${map['msg']}',
        // icon: const Icon(Icons.check, color: Colors.green),
        colorText: Colors.white,
        backgroundColor: Colors.black87,
      );
    } catch (e, s) {
      s.printError();
      setAddCartRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoadAddCart({
    required int idSize,
    required int idColor,
  }) async {
    Map<String, dynamic> data = {
      'product_id': productId,
      'user_id': _userController.userRes.value.data!.id,
      'quantity': 1,
      'extra_product': json.encode({
        'size': idSize,
        'color': idColor,
      }),
    };

    RequestData resquestData = RequestData(
      query: Configs.addCart,
      data: Helper.toMapString(data),
    );

    await _fetchDataAddCart(resquestData);
  }

  Future<void> initData() async {
    // await Future.wait([
    //   handleLoad(),
    //   _handleLoadEvaluate(),
    //   _handleLoadRecommendations(),
    // ]);
    await handleLoad();
    await _handleLoadEvaluate();
    await _handleLoadRecommendations();
  }

  @override
  void onInit() {
    productId = Get.arguments['productId'];

    initData();
    super.onInit();
  }
}
