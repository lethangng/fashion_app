import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../models/home_models/product_detail.dart';
import '../../../services/response/api_status.dart';
import '../../../utils/color_app.dart';
import '../../../utils/validate.dart';
import '../../../view_models/home_viewmodel.dart';
import '../../../view_models/tab_view_models/shop_tab_view_models/product_detail_viewmodel.dart';
import '../../widgets/button_primary.dart';
import '../../widgets/button_second.dart';
import '../../widgets/image_container.dart';
import '../../widgets/product_container.dart';
import '../../widgets/show_dialog_error.dart';

final staticAnchorKey = GlobalKey();

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({super.key});
  final ProductDetailViewmodel _productDetailViewModel =
      Get.put(ProductDetailViewmodel());
  final HomeController _homeViewModel = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: const Text(
          'Chi tiết sản phẩm',
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
      body: Obx(() {
        if (_productDetailViewModel.productDetailRes.value.status ==
            Status.error) {
          showDialogError(
              error: _productDetailViewModel.productDetailRes.value.message!);
        }

        if (_productDetailViewModel.productDetailRes.value.status ==
            Status.completed) {
          return RefreshIndicator(
            onRefresh: () => _productDetailViewModel.handleLoad(),
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
    ProductDetail productDetail =
        _productDetailViewModel.productDetailRes.value.data!;
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  CarouselSlider(
                    carouselController: _productDetailViewModel.controller,
                    options: CarouselOptions(
                      height: Get.height * 0.5,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      onPageChanged: (index, reason) =>
                          _productDetailViewModel.handleOnPageChange(index),
                    ),
                    items: productDetail.list_image_url.map((item) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: const BoxDecoration(
                              color: Color(0xFF9B9B9B),
                            ),
                            child: ImageContainer(
                              image: item,
                              replaceImage:
                                  'assets/images/product-detail-1.png',
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
                        children: productDetail.list_image_url
                            .mapIndexed((key, value) {
                          return Obx(
                            () => GestureDetector(
                              onTap: () => _productDetailViewModel.controller
                                  .animateToPage(key),
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
                                      _productDetailViewModel.current.value ==
                                              key
                                          ? const Color(0xFFDB3022)
                                          : Colors.white,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              Validate.formatMonney(productDetail.price),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: ColorApp.primary,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Visibility(
                              visible: productDetail.sell_off != null,
                              child: Row(
                                children: [
                                  Text(
                                    Validate.formatMonney(
                                        productDetail.price_off ?? 0),
                                    style: const TextStyle(
                                      color: Color(0xFF9B9B9B),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.yellow,
                                    ),
                                    padding: const EdgeInsets.all(3),
                                    child: Text(
                                      '${productDetail.sell_off}',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                        color: ColorApp.primary,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          productDetail.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF222222),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productDetail.brand,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF9B9B9B),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/icons/star-full.svg'),
                                      const SizedBox(width: 5),
                                      Text(
                                          '${productDetail.average_evaluate} / 5'),
                                      const SizedBox(width: 10),
                                      const Text('|'),
                                      const SizedBox(width: 10),
                                      Text('Đã bán ${productDetail.sold} sp'),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _productDetailViewModel
                                  .handleLoadAddFavorite(),
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
                                child:
                                    SvgPicture.asset('assets/icons/heart.svg'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 12,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Mô tả sản phẩm',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF222222),
                          ),
                        ),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: SizedBox(
                            height: _productDetailViewModel.isShow.value
                                ? null
                                : Get.height * 0.4,
                            child: Html(
                              anchorKey: staticAnchorKey,
                              data: productDetail.desc,
                              style: {
                                "table": Style(
                                  backgroundColor: const Color.fromARGB(
                                      0x50, 0xee, 0xee, 0xee),
                                ),
                                "th": Style(
                                  padding: HtmlPaddings.all(6),
                                  backgroundColor: Colors.grey,
                                ),
                                "td": Style(
                                  padding: HtmlPaddings.all(6),
                                  border: const Border(
                                    bottom: BorderSide(color: Colors.grey),
                                  ),
                                ),
                                // 'img': Style(
                                //   width: Width(double.infinity),
                                // ),
                              },
                              extensions: [
                                TagWrapExtension(
                                  tagsToWrap: {"table"},
                                  builder: (child) {
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: child,
                                    );
                                  },
                                ),
                              ],
                              onLinkTap: (url, _, __) {
                                debugPrint("Opening $url...");
                              },
                              onCssParseError: (css, messages) {
                                debugPrint("css that errored: $css");
                                debugPrint("error messages:");
                                for (var element in messages) {
                                  debugPrint(element.toString());
                                }
                                return '';
                              },
                            ),
                          ),
                        ),
                        const Divider(
                          height: 1,
                          color: ColorApp.gray,
                        ),
                        Container(
                          alignment: Alignment.center,
                          // width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          color: Colors.white,
                          child: GestureDetector(
                            onTap: () => _productDetailViewModel.setIsShow(),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  _productDetailViewModel.isShow.value
                                      ? 'Thu gọn'
                                      : 'Xem thêm',
                                  style: const TextStyle(
                                    color: Color(0xFFDB3022),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                SvgPicture.asset(
                                  'assets/icons/${_productDetailViewModel.isShow.value ? 'dropdown-2' : 'dropdown'}.svg',
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  // const SizedBox(height: 30),
                  Container(
                    height: 12,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Đánh giá sản phẩm',
                          style: TextStyle(
                            fontSize: 24,
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
                                      'assets/icons/${(i < productDetail.average_evaluate) ? 'star-full' : 'star-empty'}.svg'),
                                  const SizedBox(width: 2),
                                ],
                              ),
                            const SizedBox(width: 5),
                            Text(
                              '${productDetail.average_evaluate}/5',
                              style: const TextStyle(
                                fontSize: 13,
                                color: ColorApp.primary,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '(${productDetail.count_evaluate} đánh giá)',
                              style: const TextStyle(
                                color: Color(0xFF9B9B9B),
                                fontSize: 13,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        ListView.builder(
                          itemCount: 2,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(bottom: index != 1 ? 20 : 0),
                              child: reviewsContainer(
                                id: 1,
                                image: 'assets/images/avatar-review.png',
                                name: 'Helene Moore',
                                star: 4,
                                time: '05/03/2024',
                                content:
                                    '''The dress is great! Very classy and comfortable. It fit perfectly! I'm 5'7" and 130 pounds. I am a 34B chest. This dress would be too long for those who are shorter but could be hemmed. I wouldn't recommend it for those big chested as I am smaller chested and it fit me perfectly. The underarms were not too wide and the dress was made well.''',
                              ),
                            );
                          },
                        ),
                        const Divider(
                          height: 1,
                          color: ColorApp.gray,
                        ),
                        Container(
                          alignment: Alignment.center,
                          // width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          color: Colors.white,
                          child: GestureDetector(
                            onTap: () => Get.toNamed(Routes.reviews),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Xem tất cả',
                                  style: TextStyle(
                                    color: Color(0xFFDB3022),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                SvgPicture.asset(
                                  'assets/icons/dropdown.svg',
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    height: 12,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            children: _homeViewModel.listProductSale
                                .map(
                                  (item) => Container(
                                    margin: const EdgeInsets.only(right: 12),
                                    width: Get.width * 0.4,
                                    child: ProductContainer(
                                      product: item,
                                      productType: ProductType.product,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: Get.height * 0.1),
                ],
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
    return Container(
      padding: const EdgeInsets.all(16),
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(image),
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
                            Padding(
                              padding: const EdgeInsets.only(right: 2),
                              child: SvgPicture.asset(
                                  'assets/icons/${(i < star) ? 'star-full' : 'star-empty'}.svg'),
                            ),
                        ],
                      )
                    ],
                  ),
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
