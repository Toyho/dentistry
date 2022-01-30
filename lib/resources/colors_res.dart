import 'dart:ui';

class ColorsRes {

  static String primaryColor = "#6f94fe";
  static String whiteColor = "#FFFFFF";
  static String eerieBlackColor = "#1a1a1a";
  static String codBlackColor = "#0a0a0a";

  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}