// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    final size = MediaQuery.of(context).size;
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
                        height: size.height * 0.25,
                        fit: BoxFit.fill,
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
                          color: Colors.black,
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
                      // onFavarite();
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
}
