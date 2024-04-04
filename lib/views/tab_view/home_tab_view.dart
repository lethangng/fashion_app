import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view_models/home_view_model.dart';
import '../../view_models/tab_view_models/tab_view_model.dart';
import '../widgets/product_container.dart';

class HomeTabView extends StatelessWidget {
  HomeTabView({super.key});

  final TabViewModel tabViewModel = Get.find<TabViewModel>();
  final HomeViewModel homeViewModel = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/banner.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            text: 'Fashion\n',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w700,
                            ),
                            children: [TextSpan(text: 'sale')],
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.4,
                          child: TextButton(
                            onPressed: () => tabViewModel.goToTab(1),
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFFDB3022),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text(
                              'Khám phá',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                Row(
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mới nhất',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Bạn chưa bao giờ nhìn thấy nó trước đây!',
                          style: TextStyle(
                            color: Color(0xFF9B9B9B),
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.symmetric(
                          // horizontal: 12,
                          vertical: 6,
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        foregroundColor: const Color(0xFF222222),
                      ),
                      child: const Text('Xem tất cả'),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: homeViewModel.listProductNew
                        .map(
                          (item) => Container(
                            margin: const EdgeInsets.only(right: 12),
                            width: size.width * 0.4,
                            child: ProductContainer(
                              id: item.id,
                              image: item.image,
                              name: item.name,
                              star: item.star,
                              evaluate: item.evaluate,
                              typeProduct: item.typeProduct,
                              price: item.price,
                              salePrice: item.salePrice,
                              percent: item.percent,
                              isNew: item.isNew,
                              isOutOfStock: item.isOutOfStock,
                              typeContainer: '',
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
