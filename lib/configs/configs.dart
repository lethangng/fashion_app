class Configs {
  static String baseUrl = 'http://192.168.1.9:8000/api';
  static String checkLogin = '/check-login';
  static String getUserInfo = '/user-info';
  static String addFavoriteProduct = '/favorite/add';

  static String getListProduct({
    required int page,
    int? user_id,
    int? limit,
    bool? sale,
    bool? newest,
    int? category_id,
  }) {
    return '/product?page=$page&user_id=${user_id ?? ''}&limit=${limit ?? ''}&newest=${newest ?? ''}&category_id=${category_id ?? ''}';
  }

  static String getDetailProduct({
    required int id,
    int? user_id,
  }) {
    return '/product/detail?id=$id&user_id=${user_id ?? ''}';
  }
}
