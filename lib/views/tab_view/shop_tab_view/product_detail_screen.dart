import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../utils/color_app.dart';
import '../../../view_models/home_viewmodel.dart';
import '../../../view_models/tab_view_models/shop_tab_view_models/product_detail_controller.dart';
import '../../widgets/button_primary.dart';
import '../../widgets/button_second.dart';
import '../../widgets/product_container.dart';
import '../../widgets/select_size.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({super.key});
  final ProductDetailController productDetailViewModel =
      Get.put(ProductDetailController());
  final HomeController homeViewModel = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: const Text(
          'Váy ngắn',
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF222222),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/icons/share.svg'),
          ),
        ],
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    CarouselSlider(
                      carouselController: productDetailViewModel.controller,
                      options: CarouselOptions(
                        height: Get.height * 0.5,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        onPageChanged: (index, reason) =>
                            productDetailViewModel.handleOnPageChange(index),
                      ),
                      items: productDetailViewModel.imgList.map((item) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: const BoxDecoration(
                                color: Color(0xFF9B9B9B),
                              ),
                              child: Image.asset(
                                item,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: productDetailViewModel.imgList
                              .asMap()
                              .entries
                              .map((entry) {
                            return Obx(
                              () => GestureDetector(
                                onTap: () => productDetailViewModel.controller
                                    .animateToPage(entry.key),
                                child: Container(
                                  width: 12.0,
                                  height: 12.0,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 4.0,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        productDetailViewModel.current.value ==
                                                entry.key
                                            ? const Color(0xFFDB3022)
                                            : const Color(0xFF9B9B9B),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: button(
                              title: 'Cỡ',
                              borderColor: const Color(0xFFF01F0E),
                              event: () => SelectSize.onFavarite(),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: button(
                              title: 'Đen',
                              borderColor: const Color(0xFF9B9B9B),
                              event: () {},
                            ),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: () {
                              // onFavarite();
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
                        ],
                      ),
                      const SizedBox(height: 22),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'H&M',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF222222),
                                ),
                              ),
                              const Text(
                                'Short black dress',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF9B9B9B),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  for (int i = 0; i < 5; i++)
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/${(i < 4) ? 'star-full' : 'star-empty'}.svg'),
                                        const SizedBox(width: 2),
                                      ],
                                    ),
                                  Text(
                                    '(${10.toString()})',
                                    style: const TextStyle(
                                      color: Color(0xFF9B9B9B),
                                      fontSize: 10,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const Text(
                            '\$19.99',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF222222),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 26),
                      const Text(
                        'Short dress in soft cotton jersey with decorative buttons down the front and a wide, frill-trimmed square neckline with concealed elastication. Elasticated seam under the bust and short puff sleeves with a small frill trim.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF222222),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '8 bình luận',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF222222),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Stack(
                        children: [
                          SizedBox(
                            height: Get.height * 0.6,
                            child: ListView(
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                const SizedBox(height: 20),
                                reviewsContainer(
                                  id: 1,
                                  image: 'assets/images/avatar-review.png',
                                  name: 'Helene Moore',
                                  star: 4,
                                  time: '05/03/2024',
                                  content:
                                      '''The dress is great! Very classy and comfortable. It fit perfectly! I'm 5'7" and 130 pounds. I am a 34B chest. This dress would be too long for those who are shorter but could be hemmed. I wouldn't recommend it for those big chested as I am smaller chested and it fit me perfectly. The underarms were not too wide and the dress was made well.''',
                                ),
                                const SizedBox(height: 20),
                                reviewsContainer(
                                  id: 2,
                                  image: 'assets/images/avatar-review.png',
                                  name: 'Helene Moore',
                                  star: 4,
                                  time: '05/03/2024',
                                  content:
                                      '''The dress is great! Very classy and comfortable. It fit perfectly! I'm 5'7" and 130 pounds. I am a 34B chest. This dress would be too long for those who are shorter but could be hemmed. I wouldn't recommend it for those big chested as I am smaller chested and it fit me perfectly. The underarms were not too wide and the dress was made well.''',
                                ),
                              ],
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                width: double.infinity,
                                height: Get.height * 0.1,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.white,
                                      Colors.grey,
                                    ],
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () => Get.toNamed(Routes.reviews),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Xem thêm',
                                        style: TextStyle(
                                          color: Color(0xFFDB3022),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      AnimatedBuilder(
                                        animation: productDetailViewModel
                                            .controllerAnimate,
                                        builder: (context, child) {
                                          return Transform.translate(
                                            offset: productDetailViewModel.tween
                                                .evaluate(productDetailViewModel
                                                    .controllerAnimate),
                                            child: SvgPicture.asset(
                                              'assets/icons/double-arrow-down.svg',
                                              height: 20,
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 5),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bạn có thể thích',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF222222),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: homeViewModel.listProductSale
                              .map(
                                (item) => Container(
                                  margin: const EdgeInsets.only(right: 12),
                                  width: size.width * 0.4,
                                  child: ProductContainer(
                                    product: item,
                                    productType: ProductType.product,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 110),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: Get.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(width: 1, color: ColorApp.black),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: ButtonSecond(
                            title: 'Thêm vào giỏ hàng',
                            isUpperCase: true,
                            event: () {},
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ButtonPrimary(
                            title: 'Mua ngay',
                            isUpperCase: true,
                            event: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget reviewsContainer({
    required int id,
    required String image,
    required String name,
    required int star,
    required String time,
    required String content,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  blurRadius: 25,
                  offset: const Offset(0, 1),
                  color: const Color(0xFF000000).withOpacity(0.05),
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF222222),
                          ),
                        ),
                        Row(
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
                          ],
                        )
                      ],
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF9B9B9B),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 11),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF222222),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -20,
          left: 0,
          child: Image.asset(image),
        ),
      ],
    );
  }

  Widget button({
    required String title,
    required Color borderColor,
    required void Function()? event,
  }) {
    return OutlinedButton(
      onPressed: event,
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF222222),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide(
          color: borderColor,
          width: 1,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF222222),
            ),
          ),
          const Spacer(),
          SvgPicture.asset('assets/icons/arrow-down.svg'),
        ],
      ),
    );
  }
}
