import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/routes.dart';
import '../../../models/home_models/product_detail.dart';
import '../../../models/shop_models/filters.dart';
import '../../../services/response/api_status.dart';
import '../../../utils/color_app.dart';
import '../../../utils/helper.dart';
// import '../../../view_models/home_viewmodel.dart';
import '../../../view_models/tab_view_models/shop_tab_view_models/product_detail_viewmodel.dart';
import '../../widgets/button_primary.dart';
// import '../../widgets/button_second.dart';
import '../../widgets/image_container.dart';
import '../../widgets/product_container.dart';
import '../../widgets/review_container.dart';
import '../../widgets/show_dialog_error.dart';

final staticAnchorKey = GlobalKey();

enum AddType {
  cart,
  pay,
}

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({super.key});
  final ProductDetailViewmodel _productDetailViewModel =
      Get.put(ProductDetailViewmodel());
  // final HomeController _homeViewModel = Get.put(HomeController());

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
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
            onPressed: () => _launchUrl(
                Uri.parse('https://www.messenger.com/t/100054196028101')),
            icon: SvgPicture.asset('assets/icons/Vector (2).svg'),
            // icon: SvgPicture.asset('assets/icons/share.svg'),
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
                              Helper.formatMonney(productDetail.price),
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
                                    Helper.formatMonney(
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
                                decoration: BoxDecoration(
                                  color:
                                      _productDetailViewModel.isFavorite.value
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
                                    'assets/icons/${_productDetailViewModel.isFavorite.value ? 'heart-2' : 'heart'}.svg'),
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
                              // anchorKey: staticAnchorKey,
                              data: productDetail.desc,
                              shrinkWrap: true,
                              style: {
                                "table": Style(
                                  height: Height.auto(),
                                  width: Width.auto(),
                                ),
                                "tr": Style(
                                  height: Height.auto(),
                                  width: Width.auto(),
                                ),
                                "th": Style(
                                  padding: HtmlPaddings.all(6),
                                  height: Height.auto(),
                                  border: const Border(
                                    left: BorderSide(
                                        color: Colors.black, width: 0.5),
                                    bottom: BorderSide(
                                        color: Colors.black, width: 0.5),
                                    top: BorderSide(
                                        color: Colors.black, width: 0.5),
                                  ),
                                ),
                                "td": Style(
                                  padding: HtmlPaddings.all(6),
                                  height: Height.auto(),
                                  border: const Border(
                                    left: BorderSide(
                                        color: Colors.black, width: 0.5),
                                    bottom: BorderSide(
                                        color: Colors.black, width: 0.5),
                                    top: BorderSide(
                                        color: Colors.black, width: 0.5),
                                    right: BorderSide(
                                        color: Colors.black, width: 0.5),
                                  ),
                                ),
                                "col": Style(
                                  height: Height.auto(),
                                  width: Width.auto(),
                                ),
                              },
                              extensions: const [TableHtmlExtension()],
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
                        Obx(() {
                          if (_productDetailViewModel
                                  .evaluateRes.value.status ==
                              Status.error) {
                            showDialogError(
                                error: _productDetailViewModel
                                    .evaluateRes.value.message!);
                          }

                          if (_productDetailViewModel
                                  .evaluateRes.value.status ==
                              Status.completed) {
                            return ListView.builder(
                              itemCount:
                                  _productDetailViewModel.listEvaluate.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: index != 1 ? 20 : 0),
                                  child: ReviewContainer(
                                    evaluate: _productDetailViewModel
                                        .listEvaluate[index],
                                  ),
                                );
                              },
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(
                              color: ColorApp.primary,
                            ),
                          );
                        }),
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
                            onTap: () => Get.toNamed(Routes.reviews,
                                arguments: {
                                  'productId': _productDetailViewModel.productId
                                }),
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
                        Obx(() {
                          if (_productDetailViewModel.productRes.value.status ==
                              Status.error) {
                            showDialogError(
                                error: _productDetailViewModel
                                    .productRes.value.message!);
                          }

                          if (_productDetailViewModel.productRes.value.status ==
                              Status.completed) {
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: _productDetailViewModel.listProduct
                                    .map(
                                      (item) => Container(
                                        margin:
                                            const EdgeInsets.only(right: 12),
                                        width: Get.width * 0.4,
                                        child: ProductContainer(
                                          product: item,
                                          productType: ProductType.product,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(
                              color: ColorApp.primary,
                            ),
                          );
                        }),
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
                        child: ButtonPrimary(
                          title: 'Thêm vào giỏ hàng',
                          isUpperCase: true,
                          event: () async => await onShowSelect(AddType.cart),
                        ),
                      ),
                      // const SizedBox(width: 16),
                      // Expanded(
                      //   child: ButtonPrimary(
                      //     title: 'Mua ngay',
                      //     isUpperCase: true,
                      //     event: () async => await onShowSelect(AddType.pay),
                      //   ),
                      // ),
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

  Future<void> onShowSelect(AddType addType) async {
    final ProductDetail productDetail =
        _productDetailViewModel.productDetailRes.value.data!;
    int idColor = productDetail.colors.first.id;
    int idSize = productDetail.sizes.first.id;

    RxList<Filters> listSize = <Filters>[
      ...productDetail.sizes.map(
        (item) => Filters(
          id: item.id,
          title: item.size,
          isSelect: idSize == item.id,
        ),
      )
    ].obs;

    RxList<Filters> listColor = <Filters>[
      ...productDetail.colors.map(
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

    Future<void> handleSubmit() async {
      Get.back();
      if (addType == AddType.cart) {
        await _productDetailViewModel.handleLoadAddCart(
          idColor: idColor,
          idSize: idSize,
        );
      } else {
        //
      }
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
                                // Visibility(
                                //   visible: item.colorValue != null,
                                //   maintainSize: false,
                                //   child: Padding(
                                //     padding: const EdgeInsets.only(right: 4),
                                //     child:
                                //     Image.asset(
                                //       '${item.colorValue}',
                                //       width: Get.width * 0.05,
                                //       height: Get.width * 0.05,
                                //       // fit: BoxFit.cover,
                                //     ),
                                //   ),
                                // ),
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
