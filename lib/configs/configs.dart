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
    return '/product?page=$page&user_id=${_user?.id ?? ''}&limit=${limit ?? ''}&newest=${newest ?? ''}&category_id=${category_id ?? ''}';
  }

  static String getDetailProduct({
    required int id,
    // int? user_id,
  }) {
    return '/product/detail?id=$id&user_id=${_user?.id ?? ''}';
  }
}
