import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../view_models/tab_view_models/shop_tab_models/brand_view_model.dart';
import '../../../view_models/tab_view_models/shop_tab_models/filters_view_model.dart';

class FiltersScreen extends StatelessWidget {
  FiltersScreen({super.key});
  final FiltersViewModel filtersViewModel = Get.put(FiltersViewModel());
  final BrandViewModel brandViewModel = Get.put(BrandViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Lọc',
          style: TextStyle(
            color: Color(0xFF222222),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textContainer(title: 'Giá:'),
                containerSelect(
                  widget: Obx(
                    () => Wrap(
                      spacing: 16,
                      runSpacing: 10,
                      children: filtersViewModel.listPrice
                          .map((item) => chip(
                                id: item.id,
                                title: item.title,
                                isSelect: item.isSelect,
                                event: item.event,
                                type: 'price',
                              ))
                          .toList(),
                    ),
                  ),
                ),
                textContainer(title: 'Màu sắc:'),
                containerSelect(
                  widget: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Obx(
                      () => Wrap(
                        spacing: 20,
                        children: filtersViewModel.listColor
                            .map((item) => chipColor(
                                  id: item.id,
                                  color: item.color,
                                  isSelect: item.isSelect,
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ),
                textContainer(title: 'Cỡ:'),
                containerSelect(
                  widget: Obx(
                    () => Wrap(
                      spacing: 16,
                      runSpacing: 10,
                      children: filtersViewModel.listSize
                          .map((item) => chip(
                                id: item.id,
                                title: item.title,
                                isSelect: item.isSelect,
                                event: item.event,
                                type: 'size',
                              ))
                          .toList(),
                    ),
                  ),
                ),
                textContainer(title: 'Danh mục:'),
                containerSelect(
                  widget: Obx(
                    () => Wrap(
                      spacing: 16,
                      runSpacing: 10,
                      children: filtersViewModel.listCategory
                          .map((item) => chip(
                                id: item.id,
                                title: item.title,
                                isSelect: item.isSelect,
                                event: item.event,
                                type: 'category',
                              ))
                          .toList(),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.brand),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Hãng',
                                style: TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Obx(
                                () => Wrap(
                                  children: brandViewModel.listData
                                      .map(
                                        (item) => item.isChecked
                                            ? textBrand(
                                                title: item.title,
                                                isLast: (item ==
                                                    brandViewModel
                                                        .listData.last),
                                              )
                                            : const SizedBox(),
                                      )
                                      .toList(),
                                ),
                              )
                            ],
                          ),
                        ),
                        SvgPicture.asset('assets/icons/to-brand.svg'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 150),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  offset: const Offset(0, -4),
                  color: const Color(0xFF000000).withOpacity(0.1),
                )
              ]),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        filtersViewModel.handleDiscard();
                        brandViewModel.handleDiscard();
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xFF222222),
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        foregroundColor: const Color(0xFF222222),
                      ),
                      child: const Text(
                        'Loại bỏ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 25),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          width: 0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFFDB3022),
                      ),
                      child: const Text(
                        'Áp dụng',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget textBrand({required String title, bool? isLast}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF9B9B9B),
          ),
        ),
        Text(
          isLast == true ? '' : ', ',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF9B9B9B),
          ),
        ),
      ],
    );
  }

  Widget textContainer({required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF222222),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget containerSelect({required Widget widget}) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 26,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            offset: const Offset(0, 2),
            color: const Color(0xFF000000).withOpacity(0.05),
          ),
        ],
      ),
      child: widget,
    );
  }

  Widget chipColor({
    required int id,
    required Color color,
    required bool isSelect,
  }) {
    return OutlinedButton(
      onPressed: () => filtersViewModel.handleSelectColor(id),
      style: IconButton.styleFrom(
        minimumSize: Size.zero,
        padding: const EdgeInsets.all(4),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        side: BorderSide(
          color: isSelect ? const Color(0xFFDB3022) : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }

  Widget chip({
    required int id,
    required String title,
    required bool isSelect,
    required event,
    required String type,
  }) {
    return OutlinedButton(
      onPressed: () => filtersViewModel.handleSelect(id, type),
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
        backgroundColor:
            isSelect ? const Color(0xFFDB3022) : Colors.transparent,
        side: BorderSide(
          color: isSelect ? const Color(0xFFDB3022) : const Color(0xFF9B9B9B),
          width: 1,
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isSelect ? Colors.white : const Color(0xFF222222),
        ),
      ),
    );
  }
}
