import 'dart:ui';
import 'package:flutter/material.dart';

class AppColors {
// color
  static Color darkShadeBlue = const Color(0xff5D54B3);
  static Color darkShadeLightBlue = const Color(0xff7E7BA9);
  static Color startGradientColor = const Color(0xFF5D54B3);
  static Color endGradientColor = const Color(0xFF857FCF);
  static Color middleGradientColor = const Color(0xFFA59AE4);
  static Color blueShade = const Color(0xFF4B6CB7);

// hex
  static Color darkBlueBlack = fromHex('#111526');
  static Color primaryColor = fromHex('#89DEE2');
  static Color secondaryColor = fromHex('#F8F8F8');
  static Color appIconColor = fromHex('#797F7E');
  static Color backgroundColor = fromHex('#FFFFFF');
  static Color textGreyColor = fromHex('#7D7D7D');
  static Color appTextFeildColor = fromHex('#EBF0F3');
  static Color darkModeBackgroundColor = fromHex('#1b1d26');
  static Color appBluePurple = fromHex('#5D54B3');
  static Color bottombarBlue = fromHex('#0000FF');
  static Color appTextBlack = fromHex('#000000');
  static Color screenlightBlue = fromHex('#EFF3FF');
  static Color carouselSLiderVoilet = fromHex('#322C6A');
  static Color carouselSLiderMercury = fromHex('#ffE1E1E1');
  static Color grey97 = fromHex('#F7F7F7');
  static Color deleteIconRed = fromHex('#ED1C24');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
