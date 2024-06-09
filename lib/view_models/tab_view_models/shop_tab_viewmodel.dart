import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../../models/home_models/product.dart';
// import '../../models/shop_models/category.dart';
import 'shop_tab_view_models/search_view_controller.dart';

class ShopTabViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final List<Tab> listTap = <Tab>[
    const Tab(text: 'Phụ nữ'),
    const Tab(text: 'Đàn ông'),
    const Tab(text: 'Trẻ em'),
    const Tab(text: 'Phụ kiện'),
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
