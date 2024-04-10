import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/shop_models/filters.dart';

class SelectSize {
  static void onFavarite() {
    RxList<Filters> listSize = [
      Filters(id: 1, title: 'XS', isSelect: true),
      Filters(id: 2, title: 'S', isSelect: false),
      Filters(id: 3, title: 'M', isSelect: false),
      Filters(id: 4, title: 'L', isSelect: false),
      Filters(id: 5, title: 'XL', isSelect: false),
    ].obs;

    void handleSelectSize(int id) {
      for (var item in listSize) {
        item.isSelect = item.id == id;
      }
      listSize.refresh();
    }

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 5),
            Container(
              width: Get.width * 0.2,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: const Color(0xFF979797),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Chọn cỡ',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 33),
            SizedBox(
              width: Get.width,
              child: Obx(
                () => Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: listSize
                      .map(
                        (item) => SizedBox(
                          width: Get.width * 0.27,
                          child: OutlinedButton(
                            onPressed: () {
                              handleSelectSize(item.id);
                            },
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: item.isSelect
                                  ? const Color(0xFFDB3022)
                                  : Colors.transparent,
                              side: BorderSide(
                                color: item.isSelect
                                    ? const Color(0xFFDB3022)
                                    : const Color(0xFF9B9B9B),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              item.title,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: item.isSelect
                                    ? Colors.white
                                    : const Color(0xFF222222),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: Get.width * 0.9,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    width: 0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFFDB3022),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Thêm vào yêu thích',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
