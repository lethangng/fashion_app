import 'package:get/get.dart';

import '../views/login_view/forgot_password_screen.dart';
import '../views/login_view/login_screen.dart';
import '../views/login_view/signup_screen.dart';
import '../views/login_view/splash_screen.dart';
import '../views/tab_view/main_wrapper.dart';
import '../views/tab_view/shop_tab_view/brand_screen.dart';
import '../views/tab_view/shop_tab_view/caegory_detail.dart';
import '../views/tab_view/shop_tab_view/filters_screen.dart';

class Routes {
  static const splashScreen = '/';
  static const home = '/home';
  static const signup = '/signup';
  static const login = '/login';
  static const forgotPassword = '/forgot_password';
  static const categryDetail = '/category-detal';
  static const filters = '/filters';
  static const brand = '/brand';

  static final routes = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: home, page: () => MainWrapper()),
    GetPage(name: signup, page: () => SignUpScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: forgotPassword, page: () => ForgotPasswordScreen()),
    GetPage(name: categryDetail, page: () => CaegoryDetail()),
    GetPage(name: filters, page: () => FiltersScreen()),
    GetPage(name: brand, page: () => BrandScreen()),
  ];
}
