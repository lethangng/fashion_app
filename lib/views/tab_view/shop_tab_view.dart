import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../app/routes.dart';
import '../../utils/color_app.dart';
import '../../view_models/tab_view_models/shop_tab_view_models/search_view_controller.dart';
import '../../view_models/tab_view_models/shop_tab_viewmodel.dart';
import 'shop_tab_view/tabs/accessory_tab.dart';
import 'shop_tab_view/tabs/kid_tab.dart';
import 'shop_tab_view/tabs/men_tab.dart';
import 'shop_tab_view/tabs/women_tab.dart';

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
          // title: const Text(
          //   'Danh mục',
          //   style: TextStyle(
          //     fontSize: 18,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          title: Container(
            padding: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(57),
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                  color: const Color(0xFF000000).withOpacity(0.08),
                )
              ],
            ),
            child: TextField(
              // controller: _searchViewModel.searchController,
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              onTap: () => Get.toNamed(Routes.search),
              readOnly: true,
              cursorColor: ColorApp.black,
              style: const TextStyle(color: ColorApp.black),
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                isDense: true, // Cho chu can giua theo chieu doc
                hintText: 'Tìm kiếm...',
                hintStyle: const TextStyle(
                  color: ColorApp.colorGrey2,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                suffixIcon: Container(
                  width: 24,
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/icons/search.svg',
                    width: 24,
                  ),
                ),
              ),
              // onSubmitted: (_) => Get.toNamed(Routes.categryDetail),
            ),
          ),
          // centerTitle: true,
          // leading: const SizedBox(),
          // actions: [
          //   IconButton(
          //     onPressed: () => Get.toNamed(Routes.search),
          //     icon: SvgPicture.asset('assets/icons/search.svg'),
          //   ),
          // ],
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
                  AccessoryTab(),
                ],
              ),
            ),
          ],
        ));
  }
}
