import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'shop_tab_models/search_view_model.dart';

class ShopTabViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final List<Tab> listTap = <Tab>[
    const Tab(text: 'Phụ nữ'),
    const Tab(text: 'Đàn ông'),
    const Tab(text: 'Trẻ em'),
  ];

  @override
  void onInit() {
    tabController = TabController(
      initialIndex: 0,
      length: listTap.length,
      vsync: this,
    );
    tabController.animateTo(0);
    Get.put(SearchViewModel());
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
