import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes.dart';
import '../../services/response/api_status.dart';
import '../../utils/color_app.dart';
import '../../view_models/home_viewmodel.dart';
import '../../view_models/tab_view_models/tab_controller.dart';
import '../widgets/product_container.dart';
import '../widgets/show_dialog_error.dart';

class HomeTabView extends StatelessWidget {
  HomeTabView({super.key});

  final TabViewModel _tabViewModel = Get.find<TabViewModel>();
  final HomeController _homeViewModel = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_homeViewModel.productSaleRes.value.status == Status.error) {
        showDialogError(error: _homeViewModel.productSaleRes.value.message!);
      }
      if (_homeViewModel.productNewestRes.value.status == Status.error) {
        showDialogError(error: _homeViewModel.productNewestRes.value.message!);
      }

      if (_homeViewModel.productSaleRes.value.status == Status.completed &&
          _homeViewModel.productNewestRes.value.status == Status.completed) {
        return screen();
      }
      return const Center(
        child: CircularProgressIndicator(
          color: ColorApp.primary,
        ),
      );
    });
  }

  Widget screen() {
    return RefreshIndicator(
      onRefresh: () => _homeViewModel.onRefresh(),
      color: ColorApp.primary,
      child: SingleChildScrollView(
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
                              children: [TextSpan(text: 'khuyễn mãi')],
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.4,
                            child: TextButton(
                              onPressed: () => _tabViewModel.goToTab(1),
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
            // const SizedBox(height: 10),
            Container(
              height: 10,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  rowInfo(
                    title: 'Mới nhất',
                    subTitle: 'Bạn chưa bao giờ nhìn thấy nó trước đây!',
                    event: () => Get.toNamed(
                      Routes.listProduct,
                      arguments: {'listProductType': 0},
                    ),
                  ),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _homeViewModel.listProductNewest
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
            // const SizedBox(height: 30),
            Container(
              height: 30,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  rowInfo(
                    title: 'Khuyến mãi',
                    subTitle: 'Siêu giảm giá cho bạn!',
                    event: () => Get.toNamed(
                      Routes.listProduct,
                      arguments: {'listProductType': 1},
                    ),
                  ),
                  const SizedBox(height: 20),
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
          ],
        ),
      ),
    );
  }

  Widget rowInfo({
    required String title,
    required String subTitle,
    required void Function() event,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: ColorApp.primary,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: event,
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
        Text(
          subTitle,
          style: const TextStyle(
            color: Color(0xFF9B9B9B),
          ),
        ),
      ],
    );
  }
}
