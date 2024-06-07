import 'package:get/get.dart';

import '../../../models/bag_models/address.dart';

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
}
