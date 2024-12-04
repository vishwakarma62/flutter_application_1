import 'package:flutter/material.dart';
import 'package:postervibe/core/app_export.dart';

Text disc(
  String text, {
  FontWeight? fontWeight,
  Color? color,
  double? fontSize,
}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: color ?? (Get.isDarkMode ? Colors.white : Colors.grey[700]),
      fontSize: fontSize ?? 16,
      fontWeight: fontWeight,
    ),
  );
}

Text subTitle(
  String text, {
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
}) {
  return Text(
    text,
    style: TextStyle(
      color: color ?? (Get.isDarkMode ? Colors.white : AppColors.appTextBlack),
      fontSize: fontSize ?? 16,
      fontWeight: fontWeight ?? FontWeight.bold,
    ),
  );
}

Text title(
  String text, {
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
}) {
  return Text(
    text,
    style: TextStyle(
      color: color ?? (Get.isDarkMode ? Colors.white : Colors.black87),
      fontSize: fontSize ?? 22,
      fontWeight: fontWeight ?? FontWeight.bold,
    ),
  );
}

Text capitalizeWords(
  String text, {
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
}) {
  List<String> words = text.split(" ");

  for (int i = 0; i < words.length; i++) {
    String word = words[i];
    if (word.isNotEmpty) {
      words[i] = word.substring(0, 1).toUpperCase() + word.substring(1);
    }
  }

  String capitalizedText = words.join(" ");

  return Text(
    capitalizedText,
    style: TextStyle(
      fontSize: fontSize ?? 18,
      fontWeight: fontWeight ?? FontWeight.w700,
      color: color,
    ),
  );
}
