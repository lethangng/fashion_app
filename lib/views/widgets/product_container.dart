// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../app/routes.dart';
import '../../models/home_models/product.dart';
import '../../utils/color_app.dart';
import '../../utils/helper.dart';
import 'image_container.dart';

enum ProductType {
  favarite,
  product,
}

class ProductContainer extends StatelessWidget {
  const ProductContainer({
    super.key,
    required this.product,
    required this.productType,
    this.eventDelete,
  });

  final Product product;
  final ProductType productType;
  final void Function()? eventDelete;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Get.toNamed(
            Routes.productDetail,
            arguments: {'productId': product.id},
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                Opacity(
                  opacity: product.status == 0 ? 0.5 : 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Column(
                            children: [
                              Stack(
                                children: [
                                  ImageContainer(
                                    image: product.image_url,
                                    height: size.height * 0.25,
                                    replaceImage: 'assets/images/product-2.png',
                                  ),
                                  Positioned(
                                    top: 8,
                                    left: 8,
                                    child: Row(
                                      children: [
                                        Visibility(
                                          visible: product.newest != 0,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 7,
                                              vertical: 3,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(29),
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
                                          visible: product.sell_off != null,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 5,
                                              vertical: 3,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(29),
                                              color: const Color(0xFFDB3022),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              '${product.sell_off}',
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
                            ],
                          ),
                          Visibility(
                            visible: product.favorite &&
                                productType == ProductType.product,
                            child: Positioned(
                              right: 15,
                              bottom: 15,
                              child: Container(
                                width: 36,
                                height: 36,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: product.favorite
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
                                    'assets/icons/${product.favorite ? 'heart-2' : 'heart'}.svg'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              const SizedBox(height: 7),
                              Row(
                                children: [
                                  for (int i = 0; i < 5; i++)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 2),
                                      child: SvgPicture.asset(
                                          'assets/icons/${(i < product.average_evaluate) ? 'star-full' : 'star-empty'}.svg'),
                                    ),
                                  Text(
                                    '(${product.count_evaluate})',
                                    style: const TextStyle(
                                      color: Color(0xFF9B9B9B),
                                      fontSize: 10,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 7),
                              Text(
                                '${product.name}\n',
                                maxLines: 2,
                                style: const TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Row(
                                children: [
                                  Visibility(
                                    visible: product.sell_off != null,
                                    child: Row(
                                      children: [
                                        Text(
                                          Helper.formatMonney(
                                              product.price_off ?? 0),
                                          style: const TextStyle(
                                            color: Color(0xFF9B9B9B),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    Helper.formatMonney(product.price),
                                    style: const TextStyle(
                                      color: Color(0xFFDB3022),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 7),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: product.status == 0,
                  child: Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 5,
                        ),
                        child: const Text(
                          'Xin lỗi, sản phẩm này đã hết hàng',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: productType == ProductType.favarite,
          child: Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              onPressed: eventDelete,
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
      ],
    );
  }
}
