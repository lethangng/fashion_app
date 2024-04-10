import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../utils/color_app.dart';
import '../../../view_models/home_contronller.dart';
import '../../../view_models/tab_view_models/shop_tab_view_models/category_detail_controller.dart';
import '../../../view_models/tab_view_models/shop_tab_view_models/search_view_controller.dart';
import '../../widgets/product_container.dart';

class CaegoryDetail extends StatelessWidget {
  CaegoryDetail({super.key});
  final CategoryDetailController categoryDetailViewModel =
      Get.put(CategoryDetailController());
  final HomeController homeViewModel = Get.find<HomeController>();
  final SearchViewController searchViewModel = Get.find<SearchViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: Container(
          margin: const EdgeInsets.only(right: 16),
          padding: EdgeInsets.only(left: Get.width * 0.05, right: 10),
          // padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(57),
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                offset: const Offset(0, 4),
                color: const Color(0xFF000000).withOpacity(0.08),
              )
            ],
          ),
          child: TextField(
            readOnly: true,
            onTap: () => Get.toNamed(Routes.search),
            controller: searchViewModel.searchController,
            // focusNode: searchViewViewModel.focus,
            cursorColor: ColorApp.black,
            style: const TextStyle(color: ColorApp.black),
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              isDense: true, // Cho chu can giua theo chieu doc
              hintText: 'Tìm kiếm',
              hintStyle: const TextStyle(
                color: ColorApp.colorGrey2,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              suffixIcon: Container(
                width: 24,
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/icons/search-icon.svg',
                  width: 24,
                ),
              ),
            ),
            onSubmitted: (_) {},
            // => Get.toNamed(Routes.resultSearch),
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 4),
                  color: const Color(0xFF000000).withOpacity(0.12),
                  blurRadius: 12,
                )
              ],
              color: Colors.white,
            ),
            child: Column(
              children: [
                // const SizedBox(height: 10),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: categoryDetailViewModel.listData
                //         .map(
                //           (item) => Padding(
                //             padding: const EdgeInsets.only(right: 10),
                //             child: chip(title: item.title, event: item.event),
                //           ),
                //         )
                //         .toList(),
                //   ),
                // ),
                // const SizedBox(height: 18),
                Container(
                  decoration: const BoxDecoration(color: Color(0xFFF9F9F9)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Get.toNamed(Routes.filters),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icons/filters-2.svg'),
                            const SizedBox(width: 7),
                            const Text(
                              'Lọc',
                              style: TextStyle(
                                color: Color(0xFF222222),
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset('assets/icons/sort.svg'),
                          const SizedBox(width: 6),
                          Obx(
                            () => Text(
                              categoryDetailViewModel.sortValue.value,
                              style: const TextStyle(
                                color: Color(0xFF222222),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => onPressSort(),
                        style: IconButton.styleFrom(
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        icon: SvgPicture.asset('assets/icons/filters.svg'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
                  typeContainer: '',
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
