import 'package:get/get.dart';

import '../../../models/bag_models/bag_model.dart';
import '../../../models/bag_models/discount_code_model.dart';
import '../../../utils/color_app.dart';

class BagTabViewModel extends GetxController {
  RxList<BagModel> listDataBag = <BagModel>[
    BagModel(
      id: 0,
      image: 'assets/images/product-bag-1.png',
      name: 'Pullover',
      productType: 'Mango',
      color: 'Black',
      size: 'L',
      price: 51,
      count: 1,
    ),
    BagModel(
      id: 1,
      image: 'assets/images/product-bag-2.png',
      name: 'T-Shirt',
      productType: 'Mango',
      color: 'Gray',
      size: 'L',
      price: 30,
      count: 1,
    ),
    BagModel(
      id: 2,
      image: 'assets/images/product-bag-3.png',
      name: 'Sport Dress',
      productType: 'Mango',
      color: 'Black',
      size: 'M',
      price: 43,
      count: 1,
    ),
  ].obs;

  RxList<DiscountCodeModel> listDiscountCode = <DiscountCodeModel>[
    DiscountCodeModel(
      id: 0,
      sale: 10,
      backgroundColor: ColorApp.primary,
      saleColor: ColorApp.white,
      name: 'Ưu đãi cá nhân',
      code: 'mypromocode2020',
      time: 'còn 6 ngày',
    ),
    DiscountCodeModel(
      id: 1,
      sale: 15,
      backgroundColor: ColorApp.black,
      saleColor: ColorApp.white,
      name: 'Giảm giá mùa hè',
      code: 'summer2020',
      time: 'còn 23 ngày',
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
