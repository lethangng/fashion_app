import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../configs/configs.dart';
import '../../../models/home_models/cart.dart';
import '../../../models/home_models/coupon.dart';
import '../../../models/request/request_data.dart';
import '../../../services/repository/access_server_repository.dart';
import '../../../services/response/api_response.dart';

import '../../../utils/helper.dart';

class BagTabViewmodel extends GetxController {
  final RxInt totalPrice = 0.obs;
  final RxInt discount = 0.obs;
  int totalPriceValue = 0;

  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();
  final RxList<Cart> listCart = <Cart>[].obs;
  final RxList<Coupon> listCoupon = <Coupon>[].obs;

  final Rx<ApiResponse<List<Cart>>> cartRes =
      ApiResponse<List<Cart>>.loading().obs;

  final Rx<ApiResponse<List<Coupon>>> couponRes =
      ApiResponse<List<Coupon>>.loading().obs;

  final Rx<ApiResponse<bool>> deleteCartRes = ApiResponse<bool>.loading().obs;

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  int _page = 1;
  int _pageCoupon = 1;

  final Rx<Coupon?> selectCoupon = Rx<Coupon?>(null);

  void handlePrice() {}

  void handleSetCoupon(Coupon? value) {
    if (value != null) {
      // discountCodeController.text = value.code;
      discount.value = value.coupon_type == 0
          ? value.price
          : (totalPrice.value * (value.price / 100)).round();
    } else {
      discount.value = 0;
    }
    selectCoupon.value = value;
  }

  void setCartRes(ApiResponse<List<Cart>> res) {
    cartRes.value = res;
  }

  void setDeleteCartRes(ApiResponse<bool> res) {
    deleteCartRes.value = res;
  }

  void setCouponRes(ApiResponse<List<Coupon>> res) {
    couponRes.value = res;
  }

  Future<void> _fetchData(RequestData req) async {
    try {
      // setCartRes(ApiResponse.loading());
      final List res = await _accessServerRepository.getData(req);
      List<Cart> data = res.map((item) => Cart.fromMap(item)).toList();

      setCartRes(ApiResponse.completed(data));
      listCart.addAll(data);
      listCart.refresh();

      handleTotalPrice();
    } catch (e, s) {
      s.printError();
      setCartRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> _handleLoad() async {
    Map<String, dynamic> data = {
      //
    };

    RequestData resquestData = RequestData(
      query: Configs.getCart(
        page: _page,
        // limit: '',
      ),
      data: Helper.toMapString(data),
    );

    await _fetchData(resquestData);
  }

  Future<void> _fetchDataDeteleCart(RequestData req) async {
    try {
      setDeleteCartRes(ApiResponse.loading());
      final Map<String, dynamic> map =
          await _accessServerRepository.postData(req);

      setDeleteCartRes(ApiResponse.completed(true));

      Get.snackbar(
        'Thông báo',
        '${map['msg']}',
        // icon: const Icon(Icons.check, color: Colors.green),
        colorText: Colors.white,
        backgroundColor: Colors.black,
      );

      await onRefresh();
    } catch (e, s) {
      s.printError();
      setDeleteCartRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoadDeleteCart(int cartId) async {
    Map<String, dynamic> data = {
      'id': cartId,
    };

    RequestData resquestData = RequestData(
      query: Configs.deleteCart,
      data: Helper.toMapString(data),
    );

    await _fetchDataDeteleCart(resquestData);
  }

  Future<void> _fetchDataCoupon(RequestData req) async {
    try {
      setCouponRes(ApiResponse.loading());
      final List res = await _accessServerRepository.getData(req);
      List<Coupon> data = res.map((item) => Coupon.fromMap(item)).toList();

      setCouponRes(ApiResponse.completed(data));
      listCoupon.addAll(data);
      listCoupon.refresh();
    } catch (e, s) {
      s.printError();
      setCouponRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> _handleLoadCoupon() async {
    Map<String, dynamic> data = {
      //
    };

    RequestData resquestData = RequestData(
      query: Configs.getCoupons(
        page: _pageCoupon,
        limit: 4,
      ),
      data: Helper.toMapString(data),
    );

    await _fetchDataCoupon(resquestData);
  }

  Future<void> onRefreshCoupon() async {
    _pageCoupon = 1;
    listCoupon.value = [];
    await _handleLoadCoupon();
  }

  Future<void> onRefresh() async {
    _page = 1;
    listCart.value = [];
    await _handleLoad();
    refreshController.refreshCompleted();
  }

  Future<void> onLoading() async {
    _page++;
    await _handleLoad();
    refreshController.loadComplete();
  }

  Future<void> initData() async {
    await _handleLoad();
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  void handleTotalPrice() {
    totalPriceValue = 0;
    for (var item in listCart) {
      totalPriceValue += item.quantity * item.price;
    }
    if (selectCoupon.value != null) {
      if (totalPriceValue < selectCoupon.value!.for_sum) {
        handleSetCoupon(null);
      }
    }
    totalPrice.value = totalPriceValue - discount.value;
  }

  void handleCount({required int id, required String type}) {
    for (var item in listCart) {
      if (item.id == id) {
        if (type == 'add') {
          if (item.quantity == 99) return;
          item.quantity++;
        } else {
          if (item.quantity == 1) return;
          item.quantity--;
        }
      }
    }
    listCart.refresh();
    handleTotalPrice();
  }

  void handleSelect({
    required int id,
    required int idColor,
    required int idSize,
  }) {
    for (var item in listCart) {
      if (item.id == id) {
        for (var itemSize in item.sizes) {
          if (itemSize.id == idSize) {
            item.size = itemSize;
          }
        }
        for (var itemColor in item.colors) {
          if (itemColor.id == idColor) {
            item.color = itemColor;
          }
        }
      }
    }
    listCart.refresh();
  }
}
