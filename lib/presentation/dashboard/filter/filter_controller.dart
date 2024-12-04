import 'package:postervibe/core/app_export.dart';

class FilterControler extends GetxController {
  RxInt index = 0.obs;
  List selectKeywords = [
    {'title': 'festival'.tr},
    {'title': 'bussiness'.tr},
    {'title': 'marketing'.tr}
  ];

  List catagorytype = [
    {'title': 'image'.tr},
    {'title': 'video'.tr},
  ];
  List licenseType = ['free'.tr, 'premium'.tr];

  List orientationType = [
    {'title': 'horizontal'.tr},
    {'title': 'vertical'.tr},
    {'title': 'square'.tr},
    {'title': 'panoramic'.tr},
  ];

  List colorList = [
    0xffFCA120,
    0xffFFC0CB,
    0xffFCDB7E,
    0xff4AD295,
    0xff92CDFA,
    0xff1273EB,
    0xff8080F1,
    0xff1D262D,
    0xffFFFFFF,
    0xffBAC8D3
  ];
}
