import 'package:get/get.dart';

import '../../../models/shop_models/brand.dart';

class BrandController extends GetxController {
  RxList<Brand> listData = [
    Brand(id: 0, title: 'adidas', isChecked: false),
    Brand(id: 1, title: 'adidas Originals', isChecked: true),
    Brand(id: 2, title: 'Blend', isChecked: false),
    Brand(id: 3, title: 'Boutique Moschino', isChecked: false),
    Brand(id: 4, title: 'Champion', isChecked: false),
    Brand(id: 5, title: 'Diesel', isChecked: false),
    Brand(id: 6, title: 'Jack & Jones', isChecked: true),
    Brand(id: 7, title: 'Naf Naf', isChecked: false),
    Brand(id: 8, title: 'Red Valentino', isChecked: false),
    Brand(id: 9, title: 's.Oliver', isChecked: true),
  ].obs;

  void handleOnCheck(int id) {
    for (var item in listData) {
      if (item.id == id) {
        item.isChecked = !item.isChecked;
      }
    }
    listData.refresh();
  }

  void handleDiscard() {
    for (var item in listData) {
      item.isChecked = false;
    }
    listData.first.isChecked = true;
    listData.refresh();
  }
}
