import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../view_models/home_viewmodel.dart';
import '../../view_models/tab_view_models/shop_tab_view_models/category_detail_controller.dart';
import '../widgets/product_container.dart';

class FavoritesTabView extends StatelessWidget {
  FavoritesTabView({super.key});
  final CategoryDetailController categoryDetailViewModel =
      Get.put(CategoryDetailController());
  final HomeController homeViewModel = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: const Text(
          'Yêu thích',
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF222222),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: MasonryGridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
              itemCount: homeViewModel.listProductNew.length,
              itemBuilder: (context, index) {
                return ProductContainer(
                  id: homeViewModel.listProductNew[index].id,
                  image: homeViewModel.listProductNew[index].image,
                  name: homeViewModel.listProductNew[index].name,
                  star: homeViewModel.listProductNew[index].star,
                  evaluate: homeViewModel.listProductNew[index].evaluate,
                  typeProduct: homeViewModel.listProductNew[index].typeProduct,
                  price: homeViewModel.listProductNew[index].price,
                  percent: homeViewModel.listProductNew[index].percent,
                  salePrice: homeViewModel.listProductNew[index].salePrice,
                  isNew: homeViewModel.listProductNew[index].isNew,
                  isOutOfStock:
                      homeViewModel.listProductNew[index].isOutOfStock,
                  typeContainer: 'favorite',
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void onPressSort() {
    Get.bottomSheet(
      Container(
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
              'Sắp xếp theo',
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
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: categoryDetailViewModel.listSort
                      .map(
                        (item) => SizedBox(
                          width: Get.width,
                          child: TextButton(
                            onPressed: () {
                              categoryDetailViewModel.handleSelectSort(item.id);
                              Get.back();
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: item.isSelect
                                  ? const Color(0xFFDB3022)
                                  : Colors.transparent,
                              foregroundColor: item.isSelect
                                  ? Colors.white
                                  : const Color(0xFF222222),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      // isDismissible: true,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(16),
      // ),
    );
  }

  Widget chip({
    required String title,
    required event,
  }) {
    return TextButton(
      onPressed: event,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: const Color(0xFF222222),
        foregroundColor: Colors.white,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
