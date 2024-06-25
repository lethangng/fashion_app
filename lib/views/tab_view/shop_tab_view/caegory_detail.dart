import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../services/response/api_status.dart';
import '../../../utils/color_app.dart';
import '../../../view_models/tab_view_models/shop_tab_view_models/filters_viewmodel.dart';
import '../../../view_models/tab_view_models/shop_tab_view_models/search_view_viewmodel.dart';
import '../../widgets/list_empty.dart';
import '../../widgets/loadmore.dart';
import '../../widgets/product_container.dart';
import '../../widgets/show_dialog_error.dart';

class CaegoryDetail extends StatelessWidget {
  CaegoryDetail({super.key});
  final SearchViewViewmodel _searchViewModel = Get.find<SearchViewViewmodel>();
  final FiltersViewmodel _filtersViewmodel = Get.put(FiltersViewmodel());

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
            onTap: () => Get.back(),
            controller: _searchViewModel.searchController,
            // onTapOutside: (event) =>
            //     FocusManager.instance.primaryFocus?.unfocus(),
            cursorColor: ColorApp.black,
            style: const TextStyle(color: ColorApp.black),
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              isDense: true, // Cho chu can giua theo chieu doc
              hintText: 'Tìm kiếm....',
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
            // onSubmitted: (_) {},
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
                              _filtersViewmodel.sortValue.value,
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
            child: Obx(() {
              if (_filtersViewmodel.loadDataRes.value.status == Status.error) {
                showDialogError(
                    error: _filtersViewmodel.loadDataRes.value.message!);
              }

              if (_filtersViewmodel.loadDataRes.value.status ==
                  Status.completed) {
                return Loadmore(
                  refreshController: _filtersViewmodel.refreshController,
                  onLoading: _filtersViewmodel.onLoading,
                  onRefresh: _filtersViewmodel.onRefresh,
                  widget: _filtersViewmodel.listData.isEmpty
                      ? const ListEmpty()
                      : MasonryGridView.count(
                          padding: const EdgeInsets.all(16),
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 16,
                          itemCount: _filtersViewmodel.listData.length,
                          itemBuilder: (context, index) {
                            return ProductContainer(
                              product: _filtersViewmodel.listData[index],
                              productType: ProductType.product,
                            );
                          },
                        ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorApp.primary,
                ),
              );
            }),
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
            const SizedBox(height: 10),
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
            const SizedBox(height: 16),
            const Divider(
              height: 1,
              color: Color(0xFF979797),
            ),
            SizedBox(
              width: Get.width,
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _filtersViewmodel.listSort
                      .map(
                        (item) => SizedBox(
                          width: Get.width,
                          child: TextButton(
                            onPressed: () {
                              _filtersViewmodel.handleSelectSort(item.id);
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
