import 'package:get/state_manager.dart';
import 'package:postervibe/core/local_storage.dart';
import 'package:postervibe/core/network/network_info.dart';
import 'package:postervibe/core/utils/app_config.dart';
import 'package:postervibe/core/utils/global.dart';
import 'package:postervibe/data/model/check_user_register_model.dart';
import 'package:postervibe/data/model/login_model.dart';
import 'package:postervibe/data/repository/auth_repository.dart';
import 'package:postervibe/di/service_locator.dart';

import 'package:postervibe/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:postervibe/core/app_export.dart';
import 'package:timer_count_down/timer_controller.dart';

class VerificationCodeController extends GetxController {
  final _repository = getIt.get<AuthRepository>();
  ConnectivityManager connectivityManager = Get.find();
  final TextEditingController textEditingController = TextEditingController();
  CountdownController countdownController =
      CountdownController(autoStart: true);
  String currentText = "";
  String verificationId = '';
  String phoneNumber = '';
  RxBool isLoading = false.obs;
  //RxString email = "".obs;
  RxString otp = "".obs;
  RxBool isResend = false.obs;
  @override
  void onInit() async {
    final Map<String, dynamic> args = Get.arguments;
    phoneNumber = args['phoneNumber'];
    verificationId = args['verificationId'];
    currentText = args['currentText'];
    getdeviceInfo();
    super.onInit();
  }

  @override
  void onClose() {
    dispose();
    super.onClose();
  }

  onResendOtp() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: currentText,
          verificationCompleted: (PhoneAuthCredential credential) async {},
          verificationFailed: (FirebaseAuthException e) {
            Get.snackbar(
                AppConfig.snackbarErrorTitle, AppConfig.verificationErrorPhone);
          },
          codeSent: (String verificationId, int? resendToken) {
            verificationId = verificationId;
            countdownController.restart();
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
          timeout: const Duration(seconds: 3));
    } catch (e) {
      Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.userLoginErrorMessage);
    }
  }

  getdeviceInfo() {
    deviceToken.value = LocalStorage.deviceToken;
    loginMode.value = LocalStorage.deviceType;
  }

  hideUnHideReSend(bool value) {
    isResend.value = value;
  }

  RxString firebaseAuthToken = "".obs;
  RxString deviceToken = "".obs;
  RxString loginMode = "".obs;

  onEnterOtpAsync() async {
    if (otp.value.isEmpty || otp.value.length > 6) {
      toast("pleaseentervalidotp".tr);
    } else {
      try {
        isLoading.value = true;
        final PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: otp.value,
        );
        final FirebaseAuth auth = FirebaseAuth.instance;
        await auth.signInWithCredential(credential).then((value) {
          if (value.user!.phoneNumber!.contains(phoneNumber)) {
            checkUserRegister(phoneNumber);
          }
        });
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        _handleFirebaseAuthException(e);
      } catch (e) {
        isLoading.value = false;
        Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.userLoginErrorMessage);
      }
    }
  }

  _handleFirebaseAuthException(FirebaseAuthException e) {
    isLoading.value = false;
    switch (e.code) {
      case 'invalid-verification-code':
        Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.invalidVerificationCode);
        break;
      case 'too-many-requests':
        Get.snackbar(
            AppConfig.snackbarErrorTitle, AppConfig.tooManyRequests);
        break;
      case 'invalid-verification-id':
        Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.invalidVerificationId);
        break;
      case 'session-expired':
        Get.snackbar(AppConfig.snackbarErrorTitle,
            AppConfig.sessionExpired);
        break;
      case 'user-disabled':
        Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.userDisabled);
        break;
      case 'app-not-authorized':
        Get.snackbar(
            AppConfig.snackbarErrorTitle, AppConfig.appNotAuthorized);
        break;
      case 'Network request failed. Check your internet connection.':
        Get.snackbar(
            AppConfig.snackbarErrorTitle, AppConfig.networkRequestFailed);
        break;
      default:
        Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.verificationErrorOtp);
        break;
    }
  }

  checkUserRegister(String phoneNO) async {
    final Map<String, dynamic> requestParam = {'phoneNumber': phoneNO};
    try {
      CheckUserRegisterModel response =
          await _repository.checkUser(requestParam);
      if (response.result!.data == true) {
        login(phoneNO);
      } else {
        isLoading.value = false;
        Get.offNamed(AppRoute.myProfile, arguments: [phoneNO, false]);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.userCheckingError);
    }
  }

  login(String phone) async {
    final Map<String, dynamic> requestParameter = {
      'phoneNumber': phone,
      'deviceToken': deviceToken.value,
      'firebaseAuthToken': "123",
      'loginMode': loginMode.value,
      'meta': 'Android'
    };

    try {
      LoginModel response = await _repository.loginUser(requestParameter);
      if (response.isSuccess == true) {
        final Map<String, dynamic> loginData = {
          'id': response.result!.id as String,
          'firstName': response.result!.firstName as String,
          'lastName': response.result!.lastName as String,
          'countryCode': response.result!.countryCode as String,
          'phoneNumber': response.result!.phoneNumber as String,
          'email': response.result!.email as String,
          'profileImage': response.result!.profileImage as String,
          'jwtToken': response.result!.jwtToken as String,
          'refreshToken': response.result!.refreshToken as String,
          'login_status': true
        };
        LocalStorage.storeDataInfo(loginData);
        Get.offAllNamed(AppRoute.bottom, arguments: 0);
      } else {
        isLoading.value = false;
        Get.snackbar(AppConfig.snackbarErrorTitle, response.message.toString());
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.userLoginErrorMessage);
    }
  }
}
