import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'history_tabs/cancelled_tab_viewmodel.dart';
import 'history_tabs/delivered_tab_viewmodel.dart';
import 'history_tabs/processing_tab_viewmodel.dart';

class HistoryViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final DeliveredTabViewmodel _deliveredTabViewmodel =
      Get.put(DeliveredTabViewmodel());
  final ProcessingTabViewmodel _processingTabViewmodel =
      Get.put(ProcessingTabViewmodel());
  final CancelledTabViewmodel _cancelledTabViewmodel =
      Get.put(CancelledTabViewmodel());

  final List<Tab> listTap = <Tab>[
    const Tab(text: 'Đã giao'),
    const Tab(text: 'Đang xử lý'),
    const Tab(text: 'Đã hủy'),
  ];

  Future<void> refreshData() async {
    _deliveredTabViewmodel.onRefresh();
    _processingTabViewmodel.onRefresh();
    _cancelledTabViewmodel.onRefresh();
  }

  @override
  void onInit() {
    tabController = TabController(
      initialIndex: 0,
      length: listTap.length,
      vsync: this,
    );
    tabController.animateTo(0);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
