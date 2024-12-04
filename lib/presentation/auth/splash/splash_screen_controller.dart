import 'dart:async';
import 'dart:io';


import 'package:postervibe/routes/app_routes.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../../../core/local_storage.dart';


class SplashController extends GetxController {
  @override
  void onInit() async {
    getMessage();
    super.onInit();
  }



  getMessage() {
    FirebaseMessaging.instance.getToken().then((token) {
      storeDeviceInfo(token, "");
    });
    Timer(const Duration(seconds: 2), () async {
      LocalStorage.loginStatus == true
          ? Get.offAllNamed(AppRoute.bottom, arguments: 0)
          : LocalStorage.userId.isNotEmpty
              ? Get.offAllNamed(AppRoute.bottom, arguments: 0)
              : Get.offAllNamed(AppRoute.verifyPhoneNumber);
    });
  }

  void storeDeviceInfo(fcmToken, String supportNo) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      // unique ID on iOS
      LocalStorage.storeDeviceInfo(
        iosDeviceInfo.identifierForVendor.toString(),
        fcmToken,
        "ios",
        supportNo,
      );
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      // unique ID on Android
      LocalStorage.storeDeviceInfo(
        androidDeviceInfo.id.toString(),
        fcmToken,
        "android",
        supportNo,
      );
    }
  }
}
