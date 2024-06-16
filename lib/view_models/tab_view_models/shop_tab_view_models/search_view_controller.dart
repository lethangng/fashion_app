import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchViewController extends GetxController {
  // RxList<String> listSearch = <String>[
  //   'Tread',
  //   'Thời trang nam',
  //   'Thời trang nữ',
  //   'Thời trang trẻ em',
  //   'Thời trang hàn quốc',
  //   'Áo phông',
  //   'Áo thun',
  // ].obs;

  final TextEditingController searchController = TextEditingController();

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
