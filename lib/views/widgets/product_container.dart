// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../models/shop_models/filters_model.dart';
import '../../utils/color_app.dart';

class ProductContainer extends StatelessWidget {
  const ProductContainer({
    super.key,
    required this.id,
    required this.image,
    required this.name,
    required this.star,
    required this.evaluate,
    required this.typeProduct,
    required this.price,
    this.salePrice,
    this.percent,
    this.isNew,
    required this.typeContainer,
    required this.isOutOfStock,
    this.event,
  });

  final int id;
  final String image;
  final String name;
  final int star;
  final int evaluate;
  final String typeProduct;
  final int price;
  final int? salePrice;
  final int? percent;
  final bool? isNew;
  final String typeContainer;
  final bool isOutOfStock;
  final void Function()? event;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isOutOfStock ? 0.5 : 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        image,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Visibility(
                        visible: typeContainer == 'favorite',
                        child: Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            onPressed: () {},
                            style: IconButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 6,
                              ),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            icon: SvgPicture.asset('assets/icons/close.svg'),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Row(
                          children: [
                            Visibility(
                              visible: isNew != null,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 7,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(29),
                                  color: const Color(0xFF222222),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Mới',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Visibility(
                              visible: percent != null,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(29),
                                  color: const Color(0xFFDB3022),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '-${percent.toString()}%',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Row(
                      children: [
                        for (int i = 0; i < 5; i++)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                  'assets/icons/${(i < star) ? 'star-full' : 'star-empty'}.svg'),
                              const SizedBox(width: 2),
                            ],
                          ),
                        Text(
                          '(${evaluate.toString()})',
                          style: const TextStyle(
                            color: Color(0xFF9B9B9B),
                            fontSize: 10,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: isOutOfStock,
                child: Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 5,
                      ),
                      decoration: const BoxDecoration(
                        color: ColorApp.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Xin lỗi, sản phẩm này đã hết hàng',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: ColorApp.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isOutOfStock == false,
                child: Positioned(
                  right: 0,
                  bottom: 15,
                  child: GestureDetector(
                    onTap: () {
                      onFavarite();
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: typeContainer == 'favorite'
                            ? ColorApp.primary
                            : Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            color: Color(0xFF9B9B9B),
                          ),
                        ],
                      ),
                      child: SvgPicture.asset(
                          'assets/icons/${(typeContainer == 'favorite') ? 'bar-2' : 'heart'}.svg'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            typeProduct,
            style: const TextStyle(
              color: Color(0xFF9B9B9B),
              fontSize: 11,
            ),
          ),
          Text(
            name,
            style: const TextStyle(
              color: Color(0xFF222222),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Text(
                '${price.toString()}\$',
                style: const TextStyle(
                  color: Color(0xFF9B9B9B),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 5),
              Visibility(
                visible: salePrice != null,
                child: Text(
                  '${salePrice.toString()}\$',
                  style: const TextStyle(
                    color: Color(0xFFDB3022),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void onFavarite() {
    RxList<FiltersModel> listSize = [
      FiltersModel(id: 1, title: 'XS', isSelect: true, event: () {}),
      FiltersModel(id: 2, title: 'S', isSelect: false, event: () {}),
      FiltersModel(id: 3, title: 'M', isSelect: false, event: () {}),
      FiltersModel(id: 4, title: 'L', isSelect: false, event: () {}),
      FiltersModel(id: 5, title: 'XL', isSelect: false, event: () {}),
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
