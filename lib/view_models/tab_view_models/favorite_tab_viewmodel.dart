import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../configs/configs.dart';
import '../../models/home_models/product.dart';
import '../../models/request/request_data.dart';
import '../../services/repository/access_server_repository.dart';
import '../../services/response/api_response.dart';
import '../../utils/helper.dart';
import '../controllers/user_controller.dart';

class FavoriteTabViewmodel extends GetxController {
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();
  final UserController _userController = Get.find<UserController>();
  final RxList<Product> listFavorite = <Product>[].obs;

  final Rx<ApiResponse<List<Product>>> favoritesRes =
      ApiResponse<List<Product>>.loading().obs;

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final Rx<ApiResponse<bool>> deleteFavoriteRes =
      ApiResponse<bool>.loading().obs;

  int _page = 1;

  void setFavoritesRes(ApiResponse<List<Product>> res) {
    favoritesRes.value = res;
  }

  void setDeleteFavoriteRes(ApiResponse<bool> res) {
    deleteFavoriteRes.value = res;
  }

  Future<void> _fetchData(RequestData req) async {
    try {
      // setFavoritesRes(ApiResponse.loading());
      final List res = await _accessServerRepository.getData(req);
      List<Product> data = res.map((item) => Product.fromMap(item)).toList();

      setFavoritesRes(ApiResponse.completed(data));
      listFavorite.addAll(data);
      listFavorite.refresh();
    } catch (e, s) {
      s.printError();
      setFavoritesRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> _handleLoad() async {
    Map<String, dynamic> data = {
      //
    };

    RequestData resquestData = RequestData(
      query: Configs.getFavorite(
        page: _page,
        limit: 6,
      ),
      data: Helper.toMapString(data),
    );

    await _fetchData(resquestData);
  }

  Future<void> _fetchDataDeleteFavorite(RequestData req, int productId) async {
    try {
      setDeleteFavoriteRes(ApiResponse.loading());
      Map<String, dynamic> map = await _accessServerRepository.postData(req);
      // isFavorite.value = !isFavorite.value;

      listFavorite.removeWhere((favorite) => favorite.id == productId);
      listFavorite.refresh();

      setDeleteFavoriteRes(ApiResponse.completed(true));
      Get.snackbar(
        'Thông báo',
        '${map['msg']}',
        icon: const Icon(Icons.check, color: Colors.green),
        colorText: Colors.white,
        backgroundColor: Colors.black87,
      );
      // await onRefresh();
    } catch (e, s) {
      s.printError();
      setDeleteFavoriteRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoadDeleteFavorite(int productId) async {
    Map<String, dynamic> data = {
      'product_id': productId,
      'user_id': _userController.userRes.value.data!.id,
    };

    RequestData resquestData = RequestData(
      query: Configs.addFavoriteProduct,
      data: Helper.toMapString(data),
    );

    await _fetchDataDeleteFavorite(resquestData, productId);
  }

  Future<void> onRefresh() async {
    _page = 1;
    listFavorite.value = [];
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
