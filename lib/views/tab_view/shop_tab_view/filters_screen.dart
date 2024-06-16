import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../services/response/api_status.dart';
import '../../../utils/color_app.dart';
import '../../../utils/helper.dart';
import '../../../view_models/tab_view_models/shop_tab_view_models/filters_controller.dart';
import '../../widgets/button_primary.dart';
import '../../widgets/button_second.dart';
import '../../widgets/show_dialog_error.dart';

class FiltersScreen extends StatelessWidget {
  FiltersScreen({super.key});
  // final FiltersController _filtersViewModel = Get.put(FiltersController());
  final FiltersController _filtersViewModel = Get.find<FiltersController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        scrolledUnderElevation: 0,
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
      body: Obx(() {
        if (_filtersViewModel.loadRes.value.status == Status.error) {
          showDialogError(error: _filtersViewModel.loadRes.value.message!);
        }

        if (_filtersViewModel.loadRes.value.status == Status.completed) {
          return RefreshIndicator(
            onRefresh: () => _filtersViewModel.handleLoadData(),
            color: ColorApp.primary,
            child: screen(),
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            color: ColorApp.primary,
          ),
        );
      }),
    );
  }

  Widget screen() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textContainer(title: 'Khoảng giá:'),
              containerSelect(
                widget: Obx(
                  () => Wrap(
                    spacing: 16,
                    runSpacing: 10,
                    children: _filtersViewModel.listPrice
                        .map((item) => chip(
                              id: item.id,
                              title: item.title,
                              isSelect: item.isSelect,
                              event: () {},
                              type: FilterType.price,
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
                      children: _filtersViewModel.listColors
                          .map((item) => chipColor(
                                id: item.id,
                                color: Helper.hexToColor(item.colorValue!),
                                isSelect: item.isSelect,
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ),
              textContainer(title: 'Kích thước:'),
              containerSelect(
                widget: Obx(
                  () => Wrap(
                    spacing: 16,
                    runSpacing: 10,
                    children: _filtersViewModel.listSizes
                        .map((item) => chip(
                              id: item.id,
                              title: item.title,
                              isSelect: item.isSelect,
                              event: () {},
                              type: FilterType.size,
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
                    children: _filtersViewModel.listCategory
                        .map((item) => chip(
                              id: item.id,
                              title: item.title,
                              isSelect: item.isSelect,
                              event: () {},
                              type: FilterType.category,
                            ))
                        .toList(),
                  ),
                ),
              ),
              textContainer(title: 'Thương hiệu:'),
              containerSelect(
                widget: Obx(
                  () => Wrap(
                    spacing: 16,
                    runSpacing: 10,
                    children: _filtersViewModel.listBrand
                        .map((item) => chip(
                              id: item.id,
                              title: item.title,
                              isSelect: item.isSelect,
                              event: () {},
                              type: FilterType.brand,
                            ))
                        .toList(),
                  ),
                ),
              ),
              // GestureDetector(
              //   onTap: () => Get.toNamed(Routes.brand),
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 16,
              //       vertical: 14,
              //     ),
              //     child: Row(
              //       children: [
              //         Expanded(
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               const Text(
              //                 'Thương hiệu',
              //                 style: TextStyle(
              //                   color: Color(0xFF222222),
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //               ),
              //               Obx(
              //                 () => Wrap(
              //                   children: _brandViewModel.listData
              //                       .map(
              //                         (item) => item.isChecked
              //                             ? textBrand(
              //                                 title: item.title,
              //                                 isLast: (item ==
              //                                     _brandViewModel
              //                                         .listData.last),
              //                               )
              //                             : const SizedBox(),
              //                       )
              //                       .toList(),
              //                 ),
              //               )
              //             ],
              //           ),
              //         ),
              //         SvgPicture.asset('assets/icons/to-brand.svg'),
              //       ],
              //     ),
              //   ),
              // ),
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
                  child: ButtonSecond(
                    title: 'Thiết lập lại',
                    event: () => _filtersViewModel.handleDiscard(),
                  ),
                ),
                const SizedBox(width: 25),
                const Expanded(
                  child: ButtonPrimary(
                    title: 'Áp dụng',
                    // event: () => _filtersViewModel.handleLoad(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Widget textBrand({required String title, bool? isLast}) {
  //   return Row(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       Text(
  //         title,
  //         style: const TextStyle(
  //           fontSize: 14,
  //           fontWeight: FontWeight.w400,
  //           color: Color(0xFF9B9B9B),
  //         ),
  //       ),
  //       Text(
  //         isLast == true ? '' : ', ',
  //         style: const TextStyle(
  //           fontSize: 14,
  //           fontWeight: FontWeight.w400,
  //           color: Color(0xFF9B9B9B),
  //         ),
  //       ),
  //     ],
  //   );
  // }

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
        horizontal: 16,
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
      onPressed: () => _filtersViewModel.handleSelect(id, FilterType.color),
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
    required FilterType type,
  }) {
    return OutlinedButton(
      onPressed: () => _filtersViewModel.handleSelect(id, type),
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
