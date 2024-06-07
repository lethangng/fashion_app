import 'package:get/get.dart';

import '../../../models/bag_models/address.dart';

class PayController extends GetxController {
  Rx<Address> addressData = Address(
    id: 0,
    name: 'Jane Doe',
    address: '3 Newbridge Court',
    city: 'Chino Hills',
    isDefault: true,
  ).obs;
}
