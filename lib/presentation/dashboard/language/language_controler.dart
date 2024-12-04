import 'package:postervibe/core/app_export.dart';
import 'package:flutter/widgets.dart';

class LanguageController extends GetxController {
  RxInt index = 0.obs;
  RxInt selectIndex = 0.obs;

  List catagoryImage = [
    {
      'image': AppImage.india1,
      'title': 'India',
      "locale": const Locale('en'),
      "lang": "English",
    },
    {
      'image': AppImage.England,
      'title': 'Spanish',
      "locale": const Locale('gu'),
      "lang": "Gujarati",
    },
    {
      'image': AppImage.Germany,
      'title': 'Germany',
      "locale": const Locale('hi'),
      "lang": "Hindi",
    },
    {
      'image': AppImage.italian,
      'title': 'Italian',
      "locale": const Locale('en'),
      "lang": "English",
    },
    {
      'image': AppImage.England,
      'title': 'England',
      "locale": const Locale('gu'),
      "lang": "Gujarati",
    },
    {
      'image': AppImage.Bulgaria,
      'title': 'Bulgaria',
      "locale": const Locale('hi'),
      "lang": "Hindi",
    },
  ];
}
