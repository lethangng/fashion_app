import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/configs.dart';
import '../../../models/bag_models/address.dart';
import '../../../models/home_models/delivery_address.dart';
import '../../../models/request/request_data.dart';
import '../../../services/repository/access_server_repository.dart';
import '../../../services/response/api_response.dart';
import '../../../utils/helper.dart';
import '../../controllers/user_controller.dart';

class AddressController extends GetxController {
  RxList<Address> listDataAddress = <Address>[
    Address(
      id: 0,
      name: 'Jane Doe',
      address: '3 Newbridge Court',
      city: 'Chino Hills',
      isDefault: true,
    ),
    Address(
      id: 1,
      name: 'Jane Doe',
      address: '3 Newbridge Court',
      city: 'Chino Hills',
      isDefault: false,
    ),
    Address(
      id: 2,
      name: 'Jane Doe',
      address: '3 Newbridge Court',
      city: 'Chino Hills',
      isDefault: false,
    ),
  ].obs;

  void onSelectAddress(int id) {
    for (var item in listDataAddress) {
      item.isDefault = false;
      if (item.id == id) {
        item.isDefault = true;
      }
    }
    listDataAddress.refresh();
  }

  final UserController _userController = Get.find<UserController>();

  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  final RxList<DeliveryAddress> listData = <DeliveryAddress>[].obs;

  final Rx<ApiResponse<List<DeliveryAddress>>> deliveryAddressRes =
      ApiResponse<List<DeliveryAddress>>.loading().obs;

  final Rx<ApiResponse<bool>> addAddressRes =
      ApiResponse<bool>.completed(null).obs;

  void setDeliveryAddressRes(ApiResponse<List<DeliveryAddress>> res) {
    deliveryAddressRes.value = res;
  }

  void setAddAddressRes(ApiResponse<bool> res) {
    addAddressRes.value = res;
  }

  Future<void> _fetchData(RequestData req) async {
    try {
      setDeliveryAddressRes(ApiResponse.loading());
      final List res = await _accessServerRepository.getData(req);
      List<DeliveryAddress> data =
          res.map((item) => DeliveryAddress.fromMap(item)).toList();

      setDeliveryAddressRes(ApiResponse.completed(data));
      listData.addAll(data);
      listData.refresh();
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
          // limit: '',
          ),
      data: Helper.toMapString(data),
    );

    await _fetchData(resquestData);
  }

  Future<void> _fetchDataAddAddress(RequestData req) async {
    try {
      setAddAddressRes(ApiResponse.loading());
      Map<String, dynamic> map = await _accessServerRepository.postData(req);

      setAddAddressRes(ApiResponse.completed(true));
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
      setAddAddressRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoadAddAddress({
    required String city,
    required String address,
    required String fullname,
    required String phoneNumber,
  }) async {
    Map<String, dynamic> data = {
      'address': address,
      'fullname': fullname,
      'phone_number': phoneNumber,
      'city': city,
      'user_id': _userController.userRes.value.data!.id,
    };

    RequestData resquestData = RequestData(
      query: Configs.addAddress,
      data: Helper.toMapString(data),
    );

    await _fetchDataAddAddress(resquestData);
  }

  Future<void> onRefresh() async {
    // _page = 1;
    listData.value = [];
    await _handleLoad();
    // refreshController.refreshCompleted();
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
