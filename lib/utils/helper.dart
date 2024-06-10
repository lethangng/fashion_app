import 'dart:ui';
import 'package:intl/intl.dart';

class Helper {
  static Map<String, String> toMapString(Map<String, dynamic> data) {
    return data.map(
      (key, value) => MapEntry(key, value.toString()),
    );
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
