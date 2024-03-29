// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../models/shop_models/filters_model.dart';
import '../../view_models/tab_view_models/shop_tab_models/category_detail_view_model.dart';

class ProductContainer extends StatefulWidget {
  const ProductContainer({
    super.key,
    required this.id,
    required this.image,
    required this.name,
    required this.star,
    required this.typeProduct,
    required this.price,
    this.salePrice,
    this.percent,
    this.event,
  });

  final int id;
  final String image;
  final String name;
  final int star;
  final String typeProduct;
  final int price;
  final int? salePrice;
  final int? percent;
  final void Function()? event;

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  final CategoryDetailViewModel categoryDetailViewModel =
      Get.put(CategoryDetailViewModel());

  List<FiltersModel> listSize = [
    FiltersModel(id: 1, title: 'XS', isSelect: true, event: () {}),
    FiltersModel(id: 2, title: 'S', isSelect: false, event: () {}),
    FiltersModel(id: 3, title: 'M', isSelect: false, event: () {}),
    FiltersModel(id: 4, title: 'L', isSelect: false, event: () {}),
    FiltersModel(id: 5, title: 'XL', isSelect: false, event: () {}),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Image.asset(
              widget.image,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Visibility(
              visible: widget.percent != null,
              child: Positioned(
                top: 8,
                left: 8,
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
                    '-${widget.percent.toString()}%',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: -20,
              child: GestureDetector(
                onTap: () {
                  onFavarite();
                },
                child: Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        color: Color(0xFF9B9B9B),
                      ),
                    ],
                  ),
                  child: SvgPicture.asset('assets/icons/heart.svg'),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Row(
            children: [
              SvgPicture.asset('assets/icons/full-star.svg'),
              const SizedBox(width: 2),
              SvgPicture.asset('assets/icons/full-star.svg'),
              const SizedBox(width: 2),
              SvgPicture.asset('assets/icons/full-star.svg'),
              const SizedBox(width: 2),
              SvgPicture.asset('assets/icons/full-star.svg'),
              const SizedBox(width: 2),
              SvgPicture.asset('assets/icons/full-star.svg'),
              const SizedBox(width: 2),
              const Text(
                '(10)',
                style: TextStyle(
                  color: Color(0xFF9B9B9B),
                  fontSize: 10,
                ),
              )
            ],
          ),
        ),
        Text(
          widget.name,
          style: const TextStyle(
            color: Color(0xFF9B9B9B),
            fontSize: 11,
          ),
        ),
        Text(
          widget.name,
          style: const TextStyle(
            color: Color(0xFF222222),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Text(
              '${widget.price.toString()}\$',
              style: const TextStyle(
                color: Color(0xFF9B9B9B),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(width: 5),
            Visibility(
              visible: widget.salePrice != null,
              child: Text(
                '${widget.salePrice.toString()}\$',
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
    );
  }

  void onFavarite() {
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
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: listSize
                    .map(
                      (item) => SizedBox(
                        width: Get.width * 0.27,
                        child: OutlinedButton(
                          onPressed: () {
                            // filtersViewModel.handleSelect(id, type);
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
                  'Áp dụng',
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
