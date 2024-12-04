import 'package:postervibe/core/app_export.dart';

class SettingController extends GetxController {
  RxBool isNotification = false.obs;
  RxBool isTouchId = false.obs;
  RxBool isDark = false.obs;

  RxString selectLanguage = "English".obs;
}
