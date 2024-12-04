import 'package:flutter/material.dart';
import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/core/utils/app_color.dart';

class AppTheme {
  static final light = ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: Color(0xFFFFFFFF),
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF2962FF),
        onPrimary: Color(0xFF2962FF),
        secondary: AppColors.darkBlueBlack,
        onSecondary: Colors.red,
        error: Color(0xFFBA1A1A),
        onError: Color(0xFFFFFFFF),
        background: Color(0xFFFFFFFF),
        onBackground: Color(0xFF201A19),
        surface: Color(0xFFFFFFFF),
        onSurface: Color(0xFF201A19),
      ));
  static final dark = ThemeData(
      useMaterial3: false,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFFFFB4A8),
        onPrimary: Color(0xFF690000),
        secondary: Color(0xFF60D4FE),
        onSecondary: Color(0xFF003545),
        error: Color(0xFFFFB4AB),
        onError: Color(0xFF690005),
        background: Color(0xFF201A19),
        onBackground: Color(0xFFEDE0DD),
        surface: Color(0xFF201A19),
        onSurface: Color(0xFFEDE0DD),
      ));
}
