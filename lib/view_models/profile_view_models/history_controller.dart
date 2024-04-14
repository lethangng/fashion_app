import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/bag_models/bag_item.dart';
import '../../models/bag_models/product.dart';
import '../../models/profile_models/order.dart';

class HistoryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final List<Tab> listTap = <Tab>[
    const Tab(text: 'Đã giao hàng'),
    const Tab(text: 'Đang xử lý'),
    const Tab(text: 'Đã hủy'),
  ];

  final List<Order> listOrderDelivered = <Order>[
    Order(
      id: 0,
      idOrder: 'IW3475453455',
      listBagItem: [
        BagItem(
          id: 0,
          product: Product(
            id: 0,
            name: 'Pullover',
            listImage: ['assets/images/product-bag-1.png', ''],
            desc: '',
            price: 51,
            priceSale: 45,
            listBrand: [Brand(id: 0, brand: 'Mango')],
            isOutOfStock: false,
            listColor: [
              ProductColor(
                  id: 0,
                  color: 'Xanh',
                  image: 'assets/images/product-bag-1.png'),
              ProductColor(
                  id: 1,
                  color: 'Xám',
                  image: 'assets/images/product-bag-2.png'),
            ],
            listSize: [
              ProductSize(id: 0, size: 'M'),
              ProductSize(id: 1, size: 'L'),
              ProductSize(id: 2, size: 'XL'),
            ],
          ),
          selectColor: ProductColor(id: 0, color: 'Xanh'),
          selectSize: ProductSize(id: 1, size: 'L'),
          count: 1,
        ),
        BagItem(
          id: 1,
          product: Product(
            id: 0,
            name: 'T-Shirt',
            listImage: ['assets/images/product-bag-2.png', ''],
            desc: '',
            price: 30,
            listBrand: [Brand(id: 0, brand: 'Mango')],
            isOutOfStock: false,
            listColor: [
              ProductColor(
                  id: 0,
                  color: 'Xanh',
                  image: 'assets/images/product-bag-1.png'),
              ProductColor(id: 1, color: 'Xám'),
            ],
            listSize: [
              ProductSize(id: 0, size: 'M'),
              ProductSize(id: 1, size: 'L'),
              ProductSize(id: 2, size: 'XL'),
            ],
          ),
          selectColor: ProductColor(id: 0, color: 'Xanh'),
          selectSize: ProductSize(id: 1, size: 'L'),
          count: 1,
        ),
      ],
      time: '05-12-2019',
      count: 3,
      totalPrice: 112,
      orderType: OrderType.delivered,
    )
  ];

  @override
  void onInit() {
    tabController = TabController(
      initialIndex: 0,
      length: listTap.length,
      vsync: this,
    );
    tabController.animateTo(0);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
