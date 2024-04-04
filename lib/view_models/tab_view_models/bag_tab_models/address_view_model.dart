import 'package:get/get.dart';

import '../../../models/bag_models/address_model.dart';

class AddressViewModel extends GetxController {
  RxList<AddressModel> listDataAddress = <AddressModel>[
    AddressModel(
      id: 0,
      name: 'Jane Doe',
      address: '3 Newbridge Court',
      city: 'Chino Hills',
      isDefault: true,
    ),
    AddressModel(
      id: 1,
      name: 'Jane Doe',
      address: '3 Newbridge Court',
      city: 'Chino Hills',
      isDefault: false,
    ),
    AddressModel(
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
