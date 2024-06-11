import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../configs/configs.dart';
import '../../../models/home_models/delivery_address.dart';
import '../../../models/request/request_data.dart';
import '../../../services/repository/access_server_repository.dart';
import '../../../services/response/api_response.dart';
import '../../../utils/helper.dart';
import '../../controllers/user_controller.dart';
import 'bag_tab_viewmodel.dart';

class PayController extends GetxController {
  final UserController _userController = Get.find<UserController>();
  final BagTabViewmodel _bagTabViewmodel = Get.find<BagTabViewmodel>();
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();
  final Rx<ApiResponse<DeliveryAddress>> deliveryAddressRes =
      ApiResponse<DeliveryAddress>.loading().obs;

  final Rx<ApiResponse<bool>> addOrderRes =
      ApiResponse<bool>.completed(null).obs;

  void setDeliveryAddressRes(ApiResponse<DeliveryAddress> res) {
    deliveryAddressRes.value = res;
  }

  void setAddOrderRes(ApiResponse<bool> res) {
    addOrderRes.value = res;
  }

  // final Rx<DeliveryAddress>? deliveryAddress = Rx<DeliveryAddress>(null).obs;

  Future<void> _fetchData(RequestData req) async {
    try {
      setDeliveryAddressRes(ApiResponse.loading());
      final Map<String, dynamic> res =
          await _accessServerRepository.getData(req);
      DeliveryAddress data = DeliveryAddress.fromMap(res);

      setDeliveryAddressRes(ApiResponse.completed(data));
    } catch (e, s) {
      s.printError();
      setDeliveryAddressRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> _handleLoad() async {
    Map<String, dynamic> data = {
      //
    };

    RequestData resquestData = RequestData(
      query: Configs.getDeliveryAddress(
        is_select: 1,
      ),
      data: Helper.toMapString(data),
    );

    await _fetchData(resquestData);
  }

  Future<void> _fetchDataAddOrder(RequestData req) async {
    try {
      Map<String, dynamic> map = await _accessServerRepository.postData(req);

      setAddOrderRes(ApiResponse.completed(true));
      Get.snackbar(
        'Thông báo',
        '${map['msg']}',
        // icon: const Icon(Icons.check, color: Colors.green),
        colorText: Colors.white,
        backgroundColor: Colors.black,
      );
      Get.offAllNamed(Routes.paySuccess);
    } catch (e, s) {
      s.printError();
      setAddOrderRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoadAddOrder() async {
    String deliveryAddress =
        '${deliveryAddressRes.value.data!.address}, ${deliveryAddressRes.value.data!.city}';

    List orderProducts =
        _bagTabViewmodel.listCart.map((cart) => cart.toOrderProduct()).toList();

    Map<String, dynamic> data = {
      'delivery_address': deliveryAddress,
      'user_id': _userController.userRes.value.data!.id,
      'order_products': json.encode(orderProducts),
      'price_off': _bagTabViewmodel.discount.value,
    };

    RequestData resquestData = RequestData(
      query: Configs.addOrder,
      data: Helper.toMapString(data),
    );

    await _fetchDataAddOrder(resquestData);
  }

  Future<void> initData() async {
    await _handleLoad();
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }
}
