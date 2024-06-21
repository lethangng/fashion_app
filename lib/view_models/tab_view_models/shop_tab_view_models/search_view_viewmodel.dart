import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../database/tables/search_history_table.dart';
import '../../../models/home_models/search_history.dart';

class SearchViewViewmodel extends GetxController {
  final TextEditingController searchController = TextEditingController();

  final RxList<SearchHistory> listSearchHistory = <SearchHistory>[].obs;

  Future<void> initData() async {
    final List<SearchHistory>? listData = await SearchHistoryTable.getList();
    listSearchHistory.clear();
    if (listData != null) {
      listSearchHistory.addAll(listData);
    }
    listSearchHistory.refresh();
  }

  Future<void> insert() async {
    SearchHistory searchHistory = SearchHistory(content: searchController.text);
    await SearchHistoryTable.insert(searchHistory);
    await initData();
  }

  Future<void> delete(int id) async {
    await SearchHistoryTable.delete(id);
    await initData();
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
