import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/core/network/network_info.dart';
import 'package:postervibe/core/utils/app_config.dart';
import 'package:postervibe/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyPhoneNumberController extends GetxController {
  ConnectivityManager connectivityManager = Get.find();
  Rx<Map?> countryCode = Rx(null);
  RxString phoneNoError = ''.obs;
  RxBool isLoading = false.obs;
  RxString phoneNO = ''.obs;
  @override
  void onClose() {
    dispose();
    super.onClose();
  }

  get updatePhoneNumber => null;
  String generateFlagEmojiUnicode(String countryCode) {
    return countryCode.codeUnits
        .map((e) => String.fromCharCode(127397 + e))
        .toList()
        .reduce((value, element) => value + element)
        .toString();
  }

  String generatecode(String countryCode) {
    return countryCode.codeUnits
        .map((e) => String.fromCharCode(e))
        .toList()
        .reduce((value, element) => value + element)
        .toString();
  }

  String getFormattedPhoneNumber() {
    return countryCode.value != null
        ? '${generatecode(countryCode.value!['dial_code'])}${phoneNO.value}'
        : '+91${phoneNO.value}';
  }

  bool valid() {
    RxBool isValid = true.obs;

    phoneNoError.value = '';

    if (phoneNO.value.isEmpty) {
      phoneNoError.value = "pleaseentervalidmobilenumber".tr;
      isValid.value = false;
    } else if (!Helper.isPhoneNumber(phoneNO.value)) {
      phoneNoError.value = "pleaseentervalidmobilenumber".tr;
      isValid.value = false;
    }

    return isValid.value;
  }

  onVerifyPhoneNumber() async {
    if (valid()) {
      try {
        isLoading.value = true;
        String phoneNumber = getFormattedPhoneNumber();

        await FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: phoneNumber,
            verificationCompleted: (PhoneAuthCredential credential) async {},
            verificationFailed: (FirebaseAuthException e) {
              isLoading.value = false;
              getFirebaseAuthErrorMessage(e);
            },
            codeSent: (String verificationId, int? resendToken) {
              isLoading.value = false;
              Get.toNamed(AppRoute.verificationCode, arguments: {
                'verificationId': verificationId,
                'phoneNumber': phoneNO.value,
                'currentText': phoneNumber
              });
            },
            codeAutoRetrievalTimeout: (String verificationId) {},
            timeout: const Duration(seconds: 3));
      } catch (e) {
        isLoading.value = false;
        Get.snackbar(
            AppConfig.snackbarErrorTitle, AppConfig.verificationErrorPhone);
      }
    }
  }

  getFirebaseAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-phone-number':
        Get.snackbar(
            AppConfig.snackbarErrorTitle, AppConfig.invalidPhoneNumber);
        break;
      case 'quota-exceeded':
        Get.snackbar(AppConfig.snackbarErrorTitle,
            AppConfig.phoneVerificationQuotaExceeded);
        break;
      case 'captcha-check-failed':
        Get.snackbar(
            AppConfig.snackbarErrorTitle, AppConfig.recaptchaCheckFailed);
        break;
      case 'app-not-authorized':
        Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.appNotAuthorized);
        break;
      case 'user-disabled':
        Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.userDisabled);
        break;
      case 'user-not-found':
        Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.userNotFound);
        break;
      case 'too-many-requests':
        Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.tooManyRequests);
        break;
      case 'session-expired':
        Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.sessionExpired);
        break;
      case 'invalid-verification-code':
        Get.snackbar(
            AppConfig.snackbarErrorTitle, AppConfig.invalidVerificationCode);
        break;
      case 'missing-verification-code':
        Get.snackbar(
            AppConfig.snackbarErrorTitle, AppConfig.missingVerificationCode);
        break;
      case 'invalid-verification-id':
        Get.snackbar(
            AppConfig.snackbarErrorTitle, AppConfig.invalidVerificationId);
        break;
      case 'credential-already-in-use':
        Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.phoneAlreadyInUse);
        break;
      case 'network-request-failed':
        Get.snackbar(
            AppConfig.snackbarErrorTitle, AppConfig.networkRequestFailed);
        break;
      case 'invalid-recipient':
        Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.invalidRecipient);
        break;
      default:
        Get.snackbar(AppConfig.firebaseAuthError, '${e.message}');
        break;
    }
  }
}
