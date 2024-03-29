import 'package:get/get.dart';

import '../../../models/shop_models/brand_model.dart';

class BrandViewModel extends GetxController {
  RxList<BrandModel> listData = [
    BrandModel(id: 0, title: 'adidas', isChecked: false),
    BrandModel(id: 1, title: 'adidas Originals', isChecked: true),
    BrandModel(id: 2, title: 'Blend', isChecked: false),
    BrandModel(id: 3, title: 'Boutique Moschino', isChecked: false),
    BrandModel(id: 4, title: 'Champion', isChecked: false),
    BrandModel(id: 5, title: 'Diesel', isChecked: false),
    BrandModel(id: 6, title: 'Jack & Jones', isChecked: true),
    BrandModel(id: 7, title: 'Naf Naf', isChecked: false),
    BrandModel(id: 8, title: 'Red Valentino', isChecked: false),
    BrandModel(id: 9, title: 's.Oliver', isChecked: true),
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
