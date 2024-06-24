// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../models/home_models/cart.dart';
import '../../models/shop_models/filters.dart';
import '../../utils/color_app.dart';
import '../../utils/helper.dart';
import '../../view_models/tab_view_models/bag_tab_view_models/bag_tab_viewmodel.dart';
import 'button_primary.dart';
import 'image_container.dart';

// ignore: must_be_immutable
class ProductBagContainer extends StatelessWidget {
  ProductBagContainer({
    super.key,
    required this.cart,
    this.isPay = false,
  });
  final Cart cart;
  bool isPay;
  final BagTabViewmodel _bagTabViewModel = Get.find<BagTabViewmodel>();
  // final RxBool isShowDelete = false.obs;
  // final controller = SlidableController();

  // void onShowDelete() {
  //   isShowDelete.value = !isShowDelete.value;
  // }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (_) async =>
                await _bagTabViewModel.handleLoadDeleteCart(cart.id),
            backgroundColor: ColorApp.primary,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Xóa',
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageContainer(
                image: cart.image_url,
                width: Get.width * 0.3,
                height: Get.width * 0.3,
                replaceImage: '',
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    cart.name,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: ColorApp.black,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => isPay == false
                                      ? onShowSelect(idProduct: cart.id)
                                      : null,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    color: ColorApp.gray.withOpacity(0.1),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
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
                                                text: cart.color.name,
                                              ),
                                              const TextSpan(text: ', '),
                                              TextSpan(
                                                text: cart.size.size,
                                              ),
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
                          ),
                          // Visibility(
                          //   visible: isPay == false,
                          //   child: IconButton(
                          //     onPressed: () {},
                          //     style: IconButton.styleFrom(
                          //       minimumSize: Size.zero,
                          //       padding: EdgeInsets.zero,
                          //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          //     ),
                          //     icon:
                          //         SvgPicture.asset('assets/icons/dot-menu.svg'),
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      isPay == false
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        onPressed: () => _bagTabViewModel
                                            .handleCount(id: cart.id, type: ''),
                                        icon: SvgPicture.asset(
                                            'assets/icons/minus.svg'),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Text(
                                      cart.quantity.toString(),
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
                                            _bagTabViewModel.handleCount(
                                          id: cart.id,
                                          type: 'add',
                                        ),
                                        icon: SvgPicture.asset(
                                            'assets/icons/add.svg'),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  Helper.formatMonney(cart.price),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: ColorApp.primary,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  Helper.formatMonney(
                                      cart.price * cart.quantity),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: ColorApp.primary,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'x${cart.quantity}',
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
    );
  }

  Future<void> onShowSelect({required int idProduct}) async {
    int idColor = cart.color.id;
    int idSize = cart.size.id;

    RxList<Filters> listSize = <Filters>[
      ...cart.sizes.map(
        (item) => Filters(
          id: item.id,
          title: item.size,
          isSelect: (idSize == item.id),
        ),
      )
    ].obs;

    RxList<Filters> listColor = <Filters>[
      ...cart.colors.map(
        (item) => Filters(
          id: item.id,
          title: item.name,
          colorValue: item.color,
          isSelect: idColor == item.id,
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
      _bagTabViewModel.handleSelect(
        id: idProduct,
        idColor: idColor,
        idSize: idSize,
      );
      Get.back();
    }

    await Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                Container(
                                  width: 15,
                                  height: 15,
                                  color: Helper.hexToColor(item.colorValue!),
                                ),
                                const SizedBox(width: 5),
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
                'Chọn kích thước',
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
