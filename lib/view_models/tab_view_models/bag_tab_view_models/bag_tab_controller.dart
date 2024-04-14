import 'package:get/get.dart';

import '../../../models/bag_models/bag_item.dart';
import '../../../models/bag_models/discount_code.dart';
import '../../../models/bag_models/product.dart';
import '../../../utils/color_app.dart';

class BagTabController extends GetxController {
  RxDouble totalPrice = 0.0.obs;

  RxList<BagItem> listDataBag = <BagItem>[
    BagItem(
      id: 0,
      product: Product(
        id: 0,
        name: 'Pullover',
        listImage: ['assets/images/product-bag-1.png', ''],
        desc: '',
        price: 51,
        priceSale: 45,
        listBrand: [Brand(id: 0, brand: 'Mango')],
        isOutOfStock: false,
        listColor: [
          ProductColor(
              id: 0, color: 'Xanh', image: 'assets/images/product-bag-1.png'),
          ProductColor(
              id: 1, color: 'Xám', image: 'assets/images/product-bag-2.png'),
        ],
        listSize: [
          ProductSize(id: 0, size: 'M'),
          ProductSize(id: 1, size: 'L'),
          ProductSize(id: 2, size: 'XL'),
        ],
      ),
      selectColor: ProductColor(id: 0, color: 'Xanh'),
      selectSize: ProductSize(id: 1, size: 'L'),
      count: 1,
    ),
    BagItem(
      id: 1,
      product: Product(
        id: 0,
        name: 'T-Shirt',
        listImage: ['assets/images/product-bag-2.png', ''],
        desc: '',
        price: 30,
        listBrand: [Brand(id: 0, brand: 'Mango')],
        isOutOfStock: false,
        listColor: [
          ProductColor(
              id: 0, color: 'Xanh', image: 'assets/images/product-bag-1.png'),
          ProductColor(id: 1, color: 'Xám'),
        ],
        listSize: [
          ProductSize(id: 0, size: 'M'),
          ProductSize(id: 1, size: 'L'),
          ProductSize(id: 2, size: 'XL'),
        ],
      ),
      selectColor: ProductColor(id: 0, color: 'Xanh'),
      selectSize: ProductSize(id: 1, size: 'L'),
      count: 1,
    ),
    BagItem(
      id: 2,
      product: Product(
        id: 0,
        name: 'Pullover',
        listImage: ['assets/images/product-bag-3.png', ''],
        desc: '',
        price: 43,
        listBrand: [Brand(id: 0, brand: 'Mango')],
        isOutOfStock: false,
        listColor: [
          ProductColor(
              id: 0, color: 'Xanh', image: 'assets/images/product-bag-1.png'),
          ProductColor(id: 1, color: 'Xám'),
        ],
        listSize: [
          ProductSize(id: 0, size: 'M'),
          ProductSize(id: 1, size: 'L'),
          ProductSize(id: 2, size: 'XL'),
        ],
      ),
      selectColor: ProductColor(id: 0, color: 'Xanh'),
      selectSize: ProductSize(id: 1, size: 'L'),
      count: 1,
    ),
  ].obs;

  RxList<DiscountCode> listDiscountCode = <DiscountCode>[
    DiscountCode(
      id: 0,
      sale: 10,
      backgroundColor: ColorApp.primary,
      saleColor: ColorApp.white,
      name: 'Ưu đãi cá nhân',
      code: 'mypromocode2020',
      time: 'còn 6 ngày',
    ),
    DiscountCode(
      id: 1,
      sale: 15,
      backgroundColor: ColorApp.black,
      saleColor: ColorApp.white,
      name: 'Giảm giá mùa hè',
      code: 'summer2020',
      time: 'còn 23 ngày',
    ),
  ].obs;

  double handleTotalPrice() {
    double totalPrice = 0;
    for (var item in listDataBag) {
      totalPrice += item.count * item.product.price;
    }
    return totalPrice;
  }

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
    totalPrice.value = handleTotalPrice();
  }

  void handleSelect({
    required int id,
    required int idColor,
    required int idSize,
  }) {
    for (BagItem item in listDataBag) {
      if (item.id == id) {
        for (ProductSize itemSize in item.product.listSize) {
          if (itemSize.id == idSize) {
            item.selectSize = itemSize;
          }
        }
        for (ProductColor itemColor in item.product.listColor) {
          if (itemColor.id == idColor) {
            item.selectColor = itemColor;
          }
        }
      }
    }
    listDataBag.refresh();
  }

  @override
  void onReady() {
    totalPrice.value = handleTotalPrice();
    super.onReady();
  }
}
