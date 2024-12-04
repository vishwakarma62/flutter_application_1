import 'dart:typed_data';

import 'package:postervibe/core/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:postervibe/core/network/network_info.dart';
import 'package:postervibe/core/utils/app_config.dart';
import 'package:postervibe/core/utils/app_version_checker.dart';
import 'package:postervibe/core/utils/loader.dart';

import '../../core/app_export.dart';

class BottomBarController extends GetxController {
  final appVersionChecker = AppVersionChecker();
  ConnectivityManager connectivityManager = Get.find();
  Rx<bool> isDisplayAd = false.obs;
  bool get shouldShowAdAvailable => isDisplayAd.value;
  @override
  void onInit() {
    selectIndex.value = Get.arguments;
    userName.value = LocalStorage.firstName;
    userEmail.value = LocalStorage.userEmail;
    userProfile.value = LocalStorage.userProfile!;
    mobileNumber.value = LocalStorage.userMobile;
    countryCode.value = LocalStorage.countryCode;
    userProfileImage.value = LocalStorage.profileImage;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showUpdateDialogIfNeeded();
    });
    super.onInit();
  }

  RxString userName = "".obs;
  RxString userProfileImage = "".obs;
  RxString userEmail = "".obs;
  RxString userProfile = "".obs;
  RxString mobileNumber = "".obs;
  RxString countryCode = "".obs;

  Rx<Uint8List?> bytesImage = Rx(null);

  RxInt selectIndex = 0.obs;

  // final scaffoldKey = GlobalKey<ScaffoldState>();

  List list = [
    {
      'image': AppImage.bottom1,
    },
    {
      'image': AppImage.bottom2,
    },
    {
      'image': AppImage.bottom3,
    },
    {
      'image': AppImage.bottom4,
    },
  ];

  void _showUpdateDialogIfNeeded() async {
    await appVersionChecker.checkUpdate().then(
      (value) {
        if (value.canUpdate) {
          DialogueHelper.showConfirmationDialog(
              canPop: false,
              barrierDismissible: false,
              context: Get.context!,
              dialogTitle: AppConfig.updateTitle,
              dialogContent: AppConfig.updateContent,
              confirmButton: const MaterialButton(
                onPressed: null,
                child: Text(AppConfig.updateText),
              ),
              errorMsg: value.errorMessage ?? '',
              newVersion: value.newVersion ?? '',
              currentVersion: value.currentVersion);
        }
        isDisplayAd.value = value.isDisplayAd;
      },
    );
  }
}
