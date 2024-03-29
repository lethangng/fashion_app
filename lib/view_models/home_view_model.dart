import 'package:get/get.dart';

import '../models/home_models/product_model.dart';

class HomeViewModel extends GetxController {
  RxList<ProductModel> listProductNew = [
    ProductModel(
      id: 0,
      image: 'assets/images/product.png',
      name: 'T-Shirt SPANISH',
      star: 4,
      typeProduct: 'Mango',
      price: 9,
    ),
    ProductModel(
      id: 1,
      image: 'assets/images/product-2.png',
      name: 'Sport Dress',
      star: 5,
      typeProduct: 'Sitlly',
      price: 22,
      salePrice: 19,
    ),
    ProductModel(
      id: 2,
      image: 'assets/images/product-3.png',
      name: 'Sport',
      star: 5,
      typeProduct: 'Dorothy',
      price: 14,
      salePrice: 10,
    ),
  ].obs;
}
