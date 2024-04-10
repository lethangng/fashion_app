import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/shop_models/category.dart';
import 'shop_tab_view_models/search_view_controller.dart';

class ShopTabViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final List<Tab> listTap = <Tab>[
    const Tab(text: 'Phụ nữ'),
    const Tab(text: 'Đàn ông'),
    const Tab(text: 'Trẻ em'),
  ];

  List<Category> listDataWomen = [
    Category(title: 'Mới nhất', image: 'assets/images/category-1.png'),
    Category(title: 'Quần áo', image: 'assets/images/category-2.png'),
    Category(title: 'Giày', image: 'assets/images/category-3.png'),
    Category(title: 'Trang sức', image: 'assets/images/category-4.png'),
  ];
  List<Category> listDataMen = [
    Category(title: 'Mới nhất', image: 'assets/images/danh-muc-new-nam.jpg'),
    Category(title: 'Quần áo', image: 'assets/images/danh-muc-quan-ao-nam.jpg'),
    Category(title: 'Giày', image: 'assets/images/danh-muc-giay-nam.jpg'),
    Category(
        title: 'Trang sức', image: 'assets/images/danh-muc-trang-suc-nam.jpg'),
  ];
  List<Category> listDataKid = [
    Category(title: 'Mới nhất', image: 'assets/images/danh-muc-new-tre-em.jpg'),
    Category(
        title: 'Quần áo', image: 'assets/images/danh-muc-quan-ao-tre-em.jpg'),
    Category(title: 'Giày', image: 'assets/images/danh-muc-giay-tre-em.jpg'),
    Category(
        title: 'Trang sức',
        image: 'assets/images/danh-muc-trang-suc-tre-em.jpg'),
  ];

  @override
  void onInit() {
    tabController = TabController(
      initialIndex: 0,
      length: listTap.length,
      vsync: this,
    );
    tabController.animateTo(0);
    Get.put(SearchViewController());
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
