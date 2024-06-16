import 'package:get/get.dart';

import '../../../models/home_models/delivery_address.dart';

class EditAddressViewmodel extends GetxController {
  late final DeliveryAddress? address;

  late final String title;

  @override
  void onInit() {
    address = Get.arguments['address'];
    title = address == null ? 'Thêm' : 'Cập nhật';
    super.onInit();
  }
}
