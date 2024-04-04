import 'package:get/get.dart';

import '../../../models/bag_models/bag_model.dart';

class BagTabViewModel extends GetxController {
  RxList<BagModel> listDataBag = <BagModel>[
    BagModel(
      id: 0,
      image: 'assets/images/product-bag-1.png',
      name: 'Pullover',
      color: 'Black',
      size: 'L',
      price: 51,
      count: 1,
    ),
    BagModel(
      id: 1,
      image: 'assets/images/product-bag-2.png',
      name: 'T-Shirt',
      color: 'Gray',
      size: 'L',
      price: 30,
      count: 1,
    ),
    BagModel(
      id: 2,
      image: 'assets/images/product-bag-3.png',
      name: 'Sport Dress',
      color: 'Black',
      size: 'M',
      price: 43,
      count: 1,
    ),
  ].obs;

  void handleCount({required int id, required String type}) {
    for (var item in listDataBag) {
      if (item.id == id) {
        if (type == 'add') {
          if (item.count == 99) return;
          item.count++;
        } else {
          if (item.count == 1) return;
          item.count--;
        }
      }
    }
    listDataBag.refresh();
  }
}
