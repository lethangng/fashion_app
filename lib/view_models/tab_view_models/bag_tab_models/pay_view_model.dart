import 'package:get/get.dart';

import '../../../models/bag_models/address_model.dart';

class PayViewModel extends GetxController {
  Rx<AddressModel> addressData = AddressModel(
    id: 0,
    name: 'Jane Doe',
    address: '3 Newbridge Court',
    city: 'Chino Hills',
    isDefault: true,
  ).obs;
}
