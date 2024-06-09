import 'dart:ui';

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
}
