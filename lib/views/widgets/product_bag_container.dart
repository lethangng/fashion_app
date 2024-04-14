// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../models/bag_models/bag_item.dart';
import '../../models/shop_models/filters.dart';
import '../../utils/color_app.dart';
import '../../view_models/tab_view_models/bag_tab_view_models/bag_tab_controller.dart';
import 'button_primary.dart';

// ignore: must_be_immutable
class ProductBagContainer extends StatelessWidget {
  ProductBagContainer({
    super.key,
    required this.bagModel,
    this.isPay = false,
  });
  final BagItem bagModel;
  bool isPay;
  final BagTabController bagTabViewModel = Get.find<BagTabController>();
  final RxBool isShowDelete = false.obs;

  void onShowDelete() {
    isShowDelete.value = !isShowDelete.value;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  bagModel.product.listImage.first,
                  width: Get.width * 0.3,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(11),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  bagModel.product.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: ColorApp.black,
                                  ),
                                ),
                                InkWell(
                                  onTap: () =>
                                      onShowSelect(idProduct: bagModel.id),
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    color: ColorApp.gray.withOpacity(0.1),
                                    child: Row(
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: 'Phân loại: ',
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                              color: ColorApp.black,
                                            ),
                                            children: [
                                              TextSpan(
                                                  text: bagModel
                                                      .selectColor.color),
                                              const TextSpan(text: ', '),
                                              TextSpan(
                                                  text:
                                                      bagModel.selectSize.size),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        SvgPicture.asset(
                                            'assets/icons/arrow-down.svg'),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Visibility(
                              visible: isPay == false,
                              child: IconButton(
                                onPressed: () => onShowDelete(),
                                style: IconButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                icon: SvgPicture.asset(
                                    'assets/icons/dot-menu.svg'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        isPay == false
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 36,
                                        height: 36,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 8,
                                              offset: const Offset(0, 4),
                                              color: const Color(0xFF000000)
                                                  .withOpacity(0.1),
                                            ),
                                          ],
                                        ),
                                        child: IconButton(
                                          onPressed: () =>
                                              bagTabViewModel.handleCount(
                                                  id: bagModel.id, type: ''),
                                          icon: SvgPicture.asset(
                                              'assets/icons/minus.svg'),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Text(
                                        bagModel.count.toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: ColorApp.black,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Container(
                                        width: 36,
                                        height: 36,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 8,
                                              offset: const Offset(0, 4),
                                              color: const Color(0xFF000000)
                                                  .withOpacity(0.1),
                                            ),
                                          ],
                                        ),
                                        child: IconButton(
                                          onPressed: () =>
                                              bagTabViewModel.handleCount(
                                            id: bagModel.id,
                                            type: 'add',
                                          ),
                                          icon: SvgPicture.asset(
                                              'assets/icons/add.svg'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${bagModel.product.price}\$',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: ColorApp.black,
                                    ),
                                  )
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'x${bagModel.count}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: ColorApp.black,
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Obx(
          () => Visibility(
            visible: isShowDelete.value,
            child: Positioned(
              top: 10,
              right: 35,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 25,
                      offset: const Offset(0, 1),
                      color: const Color(0xFF000000).withOpacity(0.14),
                    )
                  ],
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 34,
                      vertical: 17,
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Xóa khỏi giỏ hàng',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: ColorApp.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void onShowSelect({required int idProduct}) {
    int idColor = bagModel.selectColor.id;
    int idSize = bagModel.selectSize.id;

    RxList<Filters> listSize = <Filters>[
      ...bagModel.product.listSize.map(
        (item) => Filters(
          id: item.id,
          title: item.size,
          isSelect: (bagModel.selectSize.id == item.id),
        ),
      )
    ].obs;

    RxList<Filters> listColor = <Filters>[
      ...bagModel.product.listColor.map(
        (item) => Filters(
          id: item.id,
          title: item.color,
          image: item.image,
          isSelect: bagModel.selectColor.id == item.id,
        ),
      )
    ].obs;

    void handleSelectSize(int id) {
      for (var item in listSize) {
        item.isSelect = (item.id == id);
      }
      idSize = id;
      listSize.refresh();
    }

    void handleSelectColor(int id) {
      for (var item in listColor) {
        item.isSelect = (item.id == id);
      }
      idColor = id;
      listColor.refresh();
    }

    void handleSubmit() {
      bagTabViewModel.handleSelect(
        id: idProduct,
        idColor: idColor,
        idSize: idSize,
      );
      Get.back();
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
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Chọn màu sắc',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: Get.width,
              child: Obx(
                () => Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: listColor
                      .map(
                        (item) => InkWell(
                          onTap: () => handleSelectColor(item.id),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            // width: Get.width * 0.27,
                            constraints:
                                BoxConstraints(minWidth: Get.width * 0.25),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  width: 1,
                                  color: item.isSelect
                                      ? ColorApp.primary
                                      : ColorApp.gray),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Visibility(
                                  visible: item.image != null,
                                  maintainSize: false,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 4),
                                    child: Image.asset(
                                      '${item.image}',
                                      width: Get.width * 0.05,
                                      height: Get.width * 0.05,
                                      // fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(
                                  item.title,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: item.isSelect
                                        ? ColorApp.primary
                                        : const Color(0xFF222222),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Chọn cỡ',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 10),
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
            ButtonPrimary(
              title: 'Đồng ý',
              isUpperCase: true,
              event: () => handleSubmit(),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
