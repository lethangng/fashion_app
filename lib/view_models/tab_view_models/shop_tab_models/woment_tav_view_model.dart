import 'package:get/get.dart';

import '../../../models/shop_models/category_model.dart';

class WomentTavViewModel extends GetxController {
  List<CategoryModel> listData = [
    CategoryModel(title: 'Mới nhất', image: 'assets/images/category-1.png'),
    CategoryModel(title: 'Quần áo', image: 'assets/images/category-2.png'),
    CategoryModel(title: 'Giày', image: 'assets/images/category-3.png'),
    CategoryModel(title: 'Trang sức', image: 'assets/images/category-4.png'),
  ];
}
