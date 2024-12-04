import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/core/utils/app_config.dart';


import 'package:postervibe/data/model/login_model.dart';
import 'package:postervibe/data/repository/auth_repository.dart';
import 'package:postervibe/di/service_locator.dart';
import 'package:postervibe/model/user_model.dart';
import 'package:postervibe/routes/app_routes.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../core/local_storage.dart';

class LoginController extends GetxController
    with GetSingleTickerProviderStateMixin {
  @override
  void onInit() {
    getdeviceInfo();
    super.onInit();
  }

  getdeviceInfo() {
    deviceToken.value = LocalStorage.deviceToken;
    loginMode.value = LocalStorage.deviceType;
  }

  final _repository = getIt.get<AuthRepository>();
  Rx<TabController?> tabController = Rx(null);

  RxInt index = 0.obs;

  RxBool isRemember = false.obs;
  RxBool isLoginLoading = false.obs;
  RxBool isSignUpLoading = false.obs;
  RxBool isLoginPassword = true.obs;
  RxBool isSignUpPassword = true.obs;

  RxString lPhoneNO = "".obs;
  RxString lPassword = "".obs;

  RxString lPhoneNoError = "".obs;
  RxString lPasswordError = "".obs;

  UserCredential? userCredential;

  RxString firebaseAuthToken = "".obs;
  RxString deviceToken = "".obs;
  RxString loginMode = "".obs;

  RxList<UserModel?> userList = RxList([]);
  Rx<Map?> countryCode = Rx(null);

  String generateFlagEmojiUnicode(String countryCode) {
    return countryCode.codeUnits
        .map((e) => String.fromCharCode(127397 + e))
        .toList()
        .reduce((value, element) => value + element)
        .toString();
  }

  String generateCode(String countryCode) {
    return countryCode.codeUnits
        .map((e) => String.fromCharCode(e))
        .toList()
        .reduce((value, element) => value + element)
        .toString();
  }

  bool validLogin() {
    RxBool isValid = true.obs;
    lPhoneNoError.value = '';
    lPasswordError.value = '';

    if (lPhoneNO.isEmpty) {
      lPhoneNoError.value = "pleaseenteryourphonenumber".tr;
      isValid.value = false;
    } else if (!Helper.isPhoneNumber(lPhoneNO.value)) {
      lPhoneNoError.value = "pleaseentervalidphonenumber".tr;
      isValid.value = false;
    }

    return isValid.value;
  }

  onLogin() async {
    if (validLogin()) {
      final Map<String, dynamic> requestParameter = {
        'phoneNumber': lPhoneNO.value,
        'deviceToken': deviceToken.value,
        'firebaseAuthToken': "123",
        'loginMode': loginMode.value,
        'meta': 'Android'
      };
      try {
        isLoginLoading.value = true;
        LoginModel response = await _repository.loginUser(requestParameter);
        if (response.isSuccess == true) {
          final Map<String, dynamic> loginData = {
            'id': response.result!.id as String,
            'firstName': response.result!.firstName as String,
            'lastName': response.result!.lastName as String,
            'countryCode': response.result!.countryCode as String,
            'phoneNumber': response.result!.phoneNumber as String,
            'email': response.result!.email as String,
            'jwtToken': response.result!.jwtToken,
            'refreshToken': response.result!.refreshToken,
            'login_status': true
          };
          LocalStorage.storeDataInfo(loginData);
          Get.offAllNamed(AppRoute.bottom,arguments: 0);
        } else {
          Get.snackbar(AppConfig.snackbarErrorTitle, response.message.toString());
        }
      } catch (e) {
        debugPrint(e.toString());
        Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.userLoginErrorMessage);
      } finally {
        isLoginLoading.value = false;
      }
    } else {
   
    }
  }
}
