import 'package:get/get.dart';

import '../models/request/user.dart';
import '../view_models/controllers/user_controller.dart';

class Configs {
  static final User? _user = Get.find<UserController>().userRes.value.data;
  static String baseUrl = 'http://192.168.1.9:8000/api';
  static String checkLogin = '/check-login';
  static String getUserInfo = '/user/user-info';
  static String addFavoriteProduct = '/favorite/add';
  static String addCart = '/cart/add';
  static String deleteCart = '/cart/delete';
  static String addAddress = '/delivery-address/add';
  static String addOrder = '/order/add';
  static String updateInfo = '/user/update-info';
  static String uploadImage = '/user/upload-image';
  static String uploadStatusOrder = '/order/update';
  static String cancelOrder = '/order/cancel';
  static String addEvaluates = '/evaluates/add';
  static String updateDeliveryAddress = '/delivery-address/update';
  static String register = '/user/register';
  static String changePassword = '/user/change-password';
  static String resetPassword = '/user/reset-password';

  static String getFilterProduct({
    required int page,
    required int limit,
    required String product_name,
    int? min_price,
    int? max_price,
    required String colors,
    required String sizes,
    required String brands,
    required String categories,
    required int sort,
  }) {
    return '/product/filter?page=$page&limit=$limit&product_name=$product_name&sort=$sort&min_price=${min_price ?? ''}&max_price=${max_price ?? ''}&colors=$colors&sizes=$sizes&brands=$brands&categories=$categories';
  }

  static String getBrand() {
    return '/brands';
  }

  static String getColor() {
    return '/color';
  }

  static String getSize() {
    return '/size';
  }

  static String getCategory() {
    return '/categories';
  }

  static String getFavorite({
    required int page,
    required int limit,
  }) {
    return '/favorite?page=$page&limit=$limit&user_id=${_user?.id ?? ''}';
  }

  static String getDeliveryAddress({int? is_select}) {
    return '/delivery-address?user_id=${_user?.id ?? ''}&is_select=${is_select ?? ''}';
  }

  static String getCoupons({
    required int page,
    required int limit,
  }) {
    return '/coupons?page=$page&limit=$limit';
  }

  static String getCart({
    required int page,
    // required int user_id,
    int? limit,
  }) {
    return '/cart?page=$page&user_id=${_user?.id ?? ''}&limit=${limit ?? ''}';
  }

  static String getEvaluate({
    required int page,
    int? limit,
    required int product_id,
    int? is_sum,
  }) {
    return '/evaluates?page=$page&limit=${limit ?? 2}&product_id=$product_id&is_sum=${is_sum ?? 0}';
  }

  static String getListProduct({
    required int page,
    // int? user_id,
    int? limit,
    bool? sale,
    bool? newest,
    int? category_id,
  }) {
    return '/product?page=$page&user_id=${_user?.id ?? ''}&limit=${limit ?? ''}&newest=${newest ?? ''}&sale=${sale ?? ''}&category_id=${category_id ?? ''}';
  }

  static String getRecommendationsProduct({
    required int product_id,
  }) {
    return '/product?product_id=$product_id&user_id=${_user?.id ?? ''}';
  }

  static String getDetailProduct({
    required int id,
    // int? user_id,
  }) {
    return '/product/detail?id=$id&user_id=${_user?.id ?? ''}';
  }

  static String getOrder({
    required int page,
    required int user_id,
    required int status,
    required int limit,
  }) {
    return '/order?page=$page&user_id=$user_id&status=$status&limit=$limit';
  }

  static String getDetailOrder({required int id}) {
    return '/order/detail?id=$id';
  }
}
