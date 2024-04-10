import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<String> imgList = [
    'assets/images/product-detail-1.png',
    'assets/images/product-detail-2.png',
    'assets/images/product-detail-1.png',
  ];

  RxInt current = 0.obs;
  final CarouselController controller = CarouselController();

  late AnimationController controllerAnimate;
  late Tween<Offset> tween;

  @override
  void onInit() {
    controllerAnimate = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    tween = Tween<Offset>(
      begin: const Offset(0, -5),
      end: const Offset(0, 5),
    );

    controllerAnimate.repeat();
    super.onInit();
  }

  @override
  void onClose() {
    controllerAnimate.dispose();
    super.onClose();
  }

  void handleOnPageChange(int value) {
    current.value = value;
  }
}
