import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/configs.dart';
import '../../models/profile_models/order_detail.dart';
import '../../models/request/request_data.dart';
import '../../services/repository/access_server_repository.dart';
import '../../services/response/api_response.dart';
import '../../utils/helper.dart';
import '../controllers/user_controller.dart';
import 'history_viewmodel.dart';

class OrderDetailViewmodel extends GetxController {
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  final HistoryViewModel _historyViewModel = Get.find<HistoryViewModel>();
  final UserController _userController = Get.find<UserController>();

  final Rx<ApiResponse<OrderDetail>> orderDetailRes =
      ApiResponse<OrderDetail>.loading().obs;

  final Rx<ApiResponse<bool>> updateStatusRes =
      ApiResponse<bool>.completed(null).obs;

  final Rx<ApiResponse<bool>> addEvaluatesRes =
      ApiResponse<bool>.completed(null).obs;

  final Rx<ApiResponse<bool>> cancelOrderRes =
      ApiResponse<bool>.completed(null).obs;

  late final int orderId;

  void setOrderDetailRes(ApiResponse<OrderDetail> res) {
    orderDetailRes.value = res;
  }

  void setUpdateStatusRes(ApiResponse<bool> res) {
    updateStatusRes.value = res;
  }

  void setAddEvaluatesRes(ApiResponse<bool> res) {
    addEvaluatesRes.value = res;
  }

  void setCancelOrderRes(ApiResponse<bool> res) {
    cancelOrderRes.value = res;
  }

  Future<void> _fetchDataCancelOrderRes(RequestData req) async {
    try {
      setCancelOrderRes(ApiResponse.loading());
      final Map<String, dynamic> map =
          await _accessServerRepository.postData(req);

      setCancelOrderRes(ApiResponse.completed(true));

      Get.snackbar(
        'Thông báo',
        '${map['msg']}',
        icon: const Icon(Icons.check, color: Colors.green),
        colorText: Colors.white,
        backgroundColor: Colors.black87,
      );
      await handleLoad();
      await _historyViewModel.refreshData();
    } catch (e, s) {
      s.printError();
      setCancelOrderRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleCancelOrderRes(String description) async {
    Map<String, dynamic> data = {
      'id': orderId,
      'description': description,
    };

    RequestData resquestData = RequestData(
      query: Configs.cancelOrder,
      data: Helper.toMapString(data),
    );

    await _fetchDataCancelOrderRes(resquestData);
  }

  Future<void> _fetchDataAddEvaluatesRes(RequestData req) async {
    try {
      setAddEvaluatesRes(ApiResponse.loading());
      final Map<String, dynamic> map =
          await _accessServerRepository.postData(req);

      setAddEvaluatesRes(ApiResponse.completed(true));

      Get.snackbar(
        'Thông báo',
        '${map['msg']}',
        icon: const Icon(Icons.check, color: Colors.green),
        colorText: Colors.white,
        backgroundColor: Colors.black87,
      );
    } catch (e, s) {
      s.printError();
      setAddEvaluatesRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleAddEvaluatesRes({
    required int starNumber,
    required String content,
  }) async {
    Map<String, dynamic> data = {
      'user_id': _userController.userRes.value.data!.id,
      'order_id': orderId,
      'star_number': starNumber,
      'content': content,
    };

    RequestData resquestData = RequestData(
      query: Configs.addEvaluates,
      data: Helper.toMapString(data),
    );

    await _fetchDataAddEvaluatesRes(resquestData);
  }

  Future<void> _fetchDataUpdateStatus(RequestData req) async {
    try {
      setUpdateStatusRes(ApiResponse.loading());
      final Map<String, dynamic> map =
          await _accessServerRepository.postData(req);

      setUpdateStatusRes(ApiResponse.completed(true));

      Get.snackbar(
        'Thông báo',
        '${map['msg']}',
        icon: const Icon(Icons.check, color: Colors.green),
        colorText: Colors.white,
        backgroundColor: Colors.black87,
      );
      await handleLoad();
      await _historyViewModel.refreshData();
    } catch (e, s) {
      s.printError();
      setUpdateStatusRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleUpdateStatus() async {
    Map<String, dynamic> data = {
      'id': orderId,
    };

    RequestData resquestData = RequestData(
      query: Configs.uploadStatusOrder,
      data: Helper.toMapString(data),
    );

    await _fetchDataUpdateStatus(resquestData);
  }

  Future<void> _fetchData(RequestData req) async {
    try {
      setOrderDetailRes(ApiResponse.loading());
      final Map<String, dynamic> res =
          await _accessServerRepository.getData(req);

      OrderDetail product = OrderDetail.fromMap(res);

      setOrderDetailRes(ApiResponse.completed(product));
    } catch (e, s) {
      s.printError();
      setOrderDetailRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoad() async {
    Map<String, dynamic> data = {
      //
    };

    RequestData resquestData = RequestData(
      query: Configs.getDetailOrder(
        id: orderId,
      ),
      data: Helper.toMapString(data),
    );

    await _fetchData(resquestData);
  }

  Future<void> initData() async {
    await handleLoad();
  }

  @override
  void onInit() {
    orderId = Get.arguments['orderId'];
    initData();
    super.onInit();
  }
}
