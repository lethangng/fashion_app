import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/shop_models/color_model.dart';
import '../../../models/shop_models/filters_model.dart';

class FiltersViewModel extends GetxController {
  RxList<FiltersModel> listPrice = [
    FiltersModel(id: 1, title: '0-100k', isSelect: true, event: () {}),
    FiltersModel(id: 2, title: '100k-200k', isSelect: false, event: () {}),
    FiltersModel(id: 3, title: '200k-300k', isSelect: false, event: () {}),
    FiltersModel(id: 4, title: '300k-500k', isSelect: false, event: () {}),
    FiltersModel(id: 5, title: '500k-1tr', isSelect: false, event: () {}),
    FiltersModel(id: 5, title: '>1tr', isSelect: false, event: () {}),
  ].obs;

  RxList<ColorModel> listColor = [
    ColorModel(id: 1, color: const Color(0xFF020202), isSelect: true),
    ColorModel(id: 2, color: const Color(0xFFF6F6F6), isSelect: false),
    ColorModel(id: 3, color: const Color(0xFFB82222), isSelect: false),
    ColorModel(id: 4, color: const Color(0xFFBEA9A9), isSelect: false),
    ColorModel(id: 5, color: const Color(0xFFE2BB8D), isSelect: true),
    ColorModel(id: 6, color: const Color(0xFF151867), isSelect: false),
  ].obs;

  RxList<FiltersModel> listSize = [
    FiltersModel(id: 1, title: 'XS', isSelect: true, event: () {}),
    FiltersModel(id: 2, title: 'S', isSelect: false, event: () {}),
    FiltersModel(id: 3, title: 'M', isSelect: false, event: () {}),
    FiltersModel(id: 4, title: 'L', isSelect: false, event: () {}),
    FiltersModel(id: 5, title: 'XL', isSelect: false, event: () {}),
  ].obs;

  RxList<FiltersModel> listCategory = [
    FiltersModel(id: 1, title: 'Tất cả', isSelect: true, event: () {}),
    FiltersModel(id: 2, title: 'Phụ nữ', isSelect: false, event: () {}),
    FiltersModel(id: 3, title: 'Đàn ông', isSelect: false, event: () {}),
    FiltersModel(id: 4, title: 'Bé trai', isSelect: false, event: () {}),
    FiltersModel(id: 5, title: 'Bé giá', isSelect: false, event: () {}),
  ].obs;

  void handleSelect(int id, String type) {
    if (type == 'price') {
      for (var item in listPrice) {
        item.isSelect = false;
        if (item.id == id) {
          item.isSelect = !item.isSelect;
        }
      }
      listPrice.refresh();
    } else if (type == 'size') {
      for (var item in listSize) {
        item.isSelect = false;
        if (item.id == id) {
          item.isSelect = !item.isSelect;
        }
      }
      listSize.refresh();
    } else if (type == 'category') {
      for (var item in listCategory) {
        item.isSelect = false;
        if (item.id == id) {
          item.isSelect = !item.isSelect;
        }
      }
      listCategory.refresh();
    }
  }

  void handleSelectColor(int id) {
    for (var item in listColor) {
      if (item.id == id) {
        item.isSelect = !item.isSelect;
      }
    }
    listColor.refresh();
  }

  void handleDiscard() {
    for (var item in listPrice) {
      item.isSelect = false;
    }
    for (var item in listColor) {
      item.isSelect = false;
    }
    for (var item in listSize) {
      item.isSelect = false;
    }
    for (var item in listCategory) {
      item.isSelect = false;
    }

    listPrice.first.isSelect = true;
    listColor.first.isSelect = true;
    listSize.first.isSelect = true;
    listCategory.first.isSelect = true;

    listPrice.refresh();
    listColor.refresh();
    listSize.refresh();
    listCategory.refresh();
  }
}
