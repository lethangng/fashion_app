import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

import '../../services/auth/auth_service.dart';
import '../../utils/color_app.dart';
import '../../view_models/tab_view_models/bag_tab_view_models/bag_tab_viewmodel.dart';
import '../../view_models/tab_view_models/favorite_tab_viewmodel.dart';
import '../../view_models/tab_view_models/tab_controller.dart';
import '../widgets/login_empty.dart';
import 'bag_tab_views/bag_tab_view.dart';
import 'favorites_tab_view.dart';
import 'home_tab_view.dart';
import 'profile_tab_view.dart';
import 'shop_tab_view.dart';

class MainWrapper extends StatelessWidget {
  MainWrapper({super.key});
  final TabViewModel _tabViewModel = Get.put(TabViewModel());
  final BagTabViewmodel _bagTabViewmodel = Get.put(BagTabViewmodel());
  final FavoriteTabViewmodel _favoriteTabViewmodel =
      Get.put(FavoriteTabViewmodel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf9f9f9),
      body: PageView(
        onPageChanged: _tabViewModel.animateToTab,
        controller: _tabViewModel.pageController,
        physics: const NeverScrollableScrollPhysics(),
        // physics: null,
        children: [
          HomeTabView(),
          ShopTabView(),
          AuthService.user != null ? BagTabView() : const LoginEmpty(),
          AuthService.user != null ? FavoritesTabView() : const LoginEmpty(),
          AuthService.user != null ? ProfileTabView() : const LoginEmpty(),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                _tabViewModel.currentPage.value == 0
                    ? Icons.home
                    : Icons.home_outlined,
              ),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _tabViewModel.currentPage.value == 1
                    ? Icons.shopping_cart
                    : Icons.shopping_cart_outlined,
              ),
              label: 'Cửa hàng',
            ),
            BottomNavigationBarItem(
              icon: badges.Badge(
                badgeContent: Text(
                  '${_bagTabViewmodel.listCart.length}',
                  style: const TextStyle(color: Colors.white),
                ),
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Colors.blue,
                ),
                child: Icon(
                  _tabViewModel.currentPage.value == 2
                      ? Icons.shopping_bag
                      : Icons.shopping_bag_outlined,
                ),
              ),
              label: 'Giỏ hàng',
            ),
            BottomNavigationBarItem(
              icon: badges.Badge(
                badgeContent: Text(
                  '${_favoriteTabViewmodel.listFavorite.length}',
                  style: const TextStyle(color: Colors.white),
                ),
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Colors.blue,
                ),
                child: Icon(
                  _tabViewModel.currentPage.value == 3
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
              ),
              label: 'Yêu thích',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _tabViewModel.currentPage.value == 4
                    ? Icons.person
                    : Icons.person_outline,
              ),
              label: 'Tôi',
            ),
          ],
          currentIndex: _tabViewModel.currentPage.value,
          selectedItemColor: ColorApp.primary,
          unselectedItemColor: ColorApp.black,
          showUnselectedLabels: true,
          onTap: (page) => _tabViewModel.goToTab(page),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
