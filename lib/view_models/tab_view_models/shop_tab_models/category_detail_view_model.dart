import 'package:get/get.dart';

import '../../../models/shop_models/category_sort.dart';
import '../../../models/shop_models/category_type.dart';

class CategoryDetailViewModel extends GetxController {
  List<CategoryType> listData = [
    CategoryType(title: 'Áo phông', event: () {}),
    CategoryType(title: 'Áo Crop tops', event: () {}),
    CategoryType(title: 'Áo cánh', event: () {}),
    CategoryType(title: 'Áo sơ mi', event: () {}),
  ];

  RxList<CategorySort> listSort = [
    CategorySort(id: 0, title: 'Phổ biến nhất', isSelect: true),
    CategorySort(id: 1, title: 'Mới nhất', isSelect: false),
    CategorySort(
      id: 2,
      title: 'Giá: Từ cao xuông thấp',
      isSelect: false,
    ),
    CategorySort(
      id: 3,
      title: 'Giá: Từ thấp đến cao',
      isSelect: false,
    ),
  ].obs;

  late RxString sortValue;

  @override
  void onInit() {
    sortValue = listSort.first.title.obs;
    super.onInit();
  }

  void handleSelectSort(int id) {
    for (var item in listSort) {
      item.isSelect = false;
      if (item.id == id) {
        item.isSelect = !item.isSelect;
        sortValue.value = item.title;
      }
    }
    listSort.refresh();
  }
}
