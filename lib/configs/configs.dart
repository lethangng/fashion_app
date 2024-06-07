class Configs {
  static String baseUrl = 'http://192.168.0.16:8000/api';
  static String checkLogin = '/check-login';
  static String getUserInfo = '/user-info';
  // static String getListProduct = '/product';

  static String getListProduct({
    required int page,
    required int user_id,
    required int limit,
    required bool sale,
    required bool newest,
  }) {
    return '/product?page=$page&user_id=$user_id&limit=$limit&newest=$newest';
  }
}
