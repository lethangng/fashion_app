import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../app/routes.dart';
import '../../utils/color_app.dart';
import '../../view_models/tab_view_models/shop_tab_view_models/search_view_controller.dart';
import '../../view_models/tab_view_models/shop_tab_controller.dart';
import 'shop_tab_view/kid_tab.dart';
import 'shop_tab_view/men_tab.dart';
import 'shop_tab_view/women_tab.dart';

class ShopTabView extends StatelessWidget {
  ShopTabView({super.key});
  final ShopTabViewModel shopTabViewModel = Get.put(ShopTabViewModel());
  final SearchViewController searchViewModel = Get.put(SearchViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorApp.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Danh mục',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: const SizedBox(),
          actions: [
            IconButton(
              onPressed: () => Get.toNamed(Routes.search),
              icon: SvgPicture.asset('assets/icons/search.svg'),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              decoration: const BoxDecoration(color: Color(0xFFFFFFFF)),
              child: TabBar(
                controller: shopTabViewModel.tabController,
                isScrollable: false,
                tabs: shopTabViewModel.listTap,
                physics: const BouncingScrollPhysics(),
                labelColor: const Color(0xFFDB3022),
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: const Color(0xFFDB3022),
                unselectedLabelColor: Colors.black,
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: shopTabViewModel.tabController,
                children: [
                  WomenTab(),
                  MenTab(),
                  KidTab(),
                ],
              ),
            ),
          ],
        ));
  }
}
