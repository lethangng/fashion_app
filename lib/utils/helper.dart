import 'dart:ui';
import 'package:intl/intl.dart';
// import 'package:get/get.dart';

// import '../models/request/user.dart';
// import '../view_models/controllers/user_controller.dart';

class Helper {
  // final User? _user = Get.find<UserController>().userRes.value.data;

  static Map<String, String> toMapString(Map<String, dynamic> data) {
    Map<String, String> map = data.map(
      (key, value) => MapEntry(key, value.toString()),
    );
    return {
      // 'user_id': _user != null ? _user!.id.toString() : '',
      ...map,
    };
  }

  static Color hexToColor(String code) {
    code = code.replaceAll("#", "");
    if (code.length == 8) {
      code = "FF$code";
    }
    return Color(int.parse(code, radix: 16));
  }

  static String formatMonney(int amount) {
    final formatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: 'đ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  static String formatNumber(int number) {
    return NumberFormat.compact().format(number);
  }
}
