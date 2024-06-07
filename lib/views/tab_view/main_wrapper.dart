import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

// import '../../app/routes.dart';
import '../../utils/color_app.dart';
import '../../view_models/tab_view_models/home_tab_viewmodel.dart';
import '../../view_models/tab_view_models/tab_controller.dart';
import 'bag_tab_views/bag_tab_view.dart';
import 'favorites_tab_view.dart';
import 'home_tab_view.dart';
import 'profile_tab_view.dart';
import 'shop_tab_view.dart';

class MainWrapper extends StatelessWidget {
  MainWrapper({super.key});
  final TabViewModel tabViewModel = Get.put(TabViewModel());
  final HomeTabController homeTabViewModel = Get.put(HomeTabController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true, // cho mau cua bottomNavigationBar thanh trong suot
      backgroundColor: const Color(0xFFf9f9f9),
      body: PageView(
        onPageChanged: tabViewModel.animateToTab,
        controller: tabViewModel.pageController,
        physics: const BouncingScrollPhysics(),
        children: [
          HomeTabView(),
          ShopTabView(),
          BagTabView(),
          FavoritesTabView(),
          const ProfileTabView(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        padding: EdgeInsets.zero,
        notchMargin: 10,
        elevation: 0.0,
        color: Colors.white,
        child: Container(
          // padding: const EdgeInsets.only(top: 30),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _bottomAppBarItem(
                  context,
                  icon: 'assets/icons/home.svg',
                  iconSelect: 'assets/icons/home-select.svg',
                  page: 0,
                  lable: 'Trang chủ',
                ),
                _bottomAppBarItem(
                  context,
                  icon: 'assets/icons/shop.svg',
                  iconSelect: 'assets/icons/shop-select.svg',
                  page: 1,
                  lable: 'Cửa hàng',
                ),
                _bottomAppBarItem(
                  context,
                  icon: 'assets/icons/bag.svg',
                  iconSelect: 'assets/icons/bag-select.svg',
                  page: 2,
                  lable: 'Giỏ hàng',
                ),
                _bottomAppBarItem(
                  context,
                  icon: 'assets/icons/favorites.svg',
                  iconSelect: 'assets/icons/favorites-select.svg',
                  page: 3,
                  lable: 'Yêu thích',
                ),
                _bottomAppBarItem(
                  context,
                  icon: 'assets/icons/profile.svg',
                  iconSelect: 'assets/icons/profile-select.svg',
                  page: 4,
                  lable: 'Cá nhân',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomAppBarItem(
    BuildContext context, {
    required String icon,
    required String iconSelect,
    required int page,
    required String lable,
  }) {
    return Expanded(
      child: ZoomTapAnimation(
        onTap: () => tabViewModel.goToTab(page),
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.center,
                width: 24,
                height: 24,
                child: SvgPicture.asset(
                  tabViewModel.currentPage.value == page ? iconSelect : icon,
                  colorFilter: ColorFilter.mode(
                    tabViewModel.currentPage.value == page
                        ? const Color(0xFFDB3022)
                        : ColorApp.black,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                lable,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: tabViewModel.currentPage.value == page
                      ? const Color(0xFFDB3022)
                      : ColorApp.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
