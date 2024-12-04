import 'package:postervibe/core/app_export.dart';

class PremiumController extends GetxController {
  RxList selectPremiumAccess = [].obs;
  RxInt selectPremium = 0.obs;

  List durationlist = [
    {
      'duration': ' 1 ${"year".tr}',
      'price': '\$39.99/${"yearly".tr}',
    },
    {
      'duration': ' 1 ${"week".tr}',
      'price': '\$9.99/${"weekly".tr}',
    },
    {
      'duration': ' 1 ${"month".tr}',
      'price': '\$19.99/${"monthly".tr}',
    },
  ];

  List accesslist = [
    {'title': 'umlimitedpostandvideos'.tr},
    {'title': 'sharemanagepostvideos'.tr},
    {'title': 'automaticdownload'.tr}
  ];
}
