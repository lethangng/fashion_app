import 'package:get/get.dart';

import '../../database/fashion_database.dart';

class AppController extends GetxController {
  Future<void> initData() async {
    await FashionDatabase.instance.database;
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }
}
