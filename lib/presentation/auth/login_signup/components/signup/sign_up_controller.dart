import 'dart:io';

import 'package:postervibe/core/utils/app_config.dart';
import 'package:postervibe/core/utils/global.dart';
import 'package:postervibe/data/model/login_model.dart';
import 'package:postervibe/data/model/profile_update_model.dart';

import 'package:postervibe/data/repository/user_repo.dart';
import 'package:postervibe/presentation/bottom_bar/bottom_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:dio/dio.dart' as dio;

import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/core/network/network_info.dart';
import 'package:postervibe/data/model/user_register_model.dart';
import 'package:postervibe/data/repository/auth_repository.dart';
import 'package:postervibe/di/service_locator.dart';
import 'package:postervibe/model/user_model.dart';
import 'package:postervibe/presentation/widget/bottom_sheet_widget.dart';
import 'package:postervibe/routes/app_routes.dart';

import 'package:flutter/foundation.dart';

import '../../../../../core/local_storage.dart';

class SignUpController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _authRepository = getIt.get<AuthRepository>();
  final _userRepo = getIt.get<USerRespository>();

  ConnectivityManager connectivityManager = Get.find();

  @override
  void onInit() async {
    if (isEdit == true) {
      rlastName.value.text = LocalStorage.lasttName;
      rfirstName.value.text = LocalStorage.firstName;
      rEmail.value.text = LocalStorage.userEmail;
      rphoneNomber.value.text = LocalStorage.userMobile;
    } else {
      rphoneNomber.value.text = phoneNO;
    }
    deviceToken.value = LocalStorage.deviceToken;
    loginMode.value = LocalStorage.deviceType;

    super.onInit();
  }

  var phoneNO = Get.arguments[0];
  var isEdit = Get.arguments[1];

  Rx<TabController?> tabController = Rx(null);

  RxBool isRemember = false.obs;
  RxBool isLoading = false.obs;
  RxBool isEditLoading = false.obs;

  Uint8List? bytesImage;
  Rx<File> profileImage = File("").obs;
  final ImagePicker picker = ImagePicker();
  // dio.MultipartFile? multipartFile;

  /// myprofile
  Rx<TextEditingController> rEmail = TextEditingController(text: "").obs;
  Rx<TextEditingController> rPassword = TextEditingController(text: "").obs;
  Rx<TextEditingController> rphoneNomber = TextEditingController(text: "").obs;
  Rx<TextEditingController> rfirstName = TextEditingController(text: "").obs;
  Rx<TextEditingController> rlastName = TextEditingController(text: "").obs;

  RxString rEmailError = "".obs;
  RxString rPasswordError = "".obs;
  RxString rphoneNoError = "".obs;
  RxString firstNameError = "".obs;
  RxString lastNameError = "".obs;

  RxString firebaseAuthToken = "".obs;
  RxString deviceToken = "".obs;
  RxString loginMode = "".obs;

  RxList<UserModel?> userList = RxList([]);
  Rx<Map?> countryCode = Rx(null);
  @override
  void onClose() {
    super.onClose();
    dispose();
  }

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

  bool validMYProfile() {
    RxBool isValid = true.obs;
    rEmailError.value = '';
    rPasswordError.value = '';
    firstNameError.value = "";
    lastNameError.value = "";
    lastNameError.value = "";

    if (rfirstName.value.text.isEmpty) {
      firstNameError.value = "enterfirstname".tr;
      isValid.value = false;
    }

    if (rlastName.value.text.isEmpty) {
      lastNameError.value = "enterlastname".tr;
      isValid.value = false;
    }

    if (rEmail.value.text.isEmpty) {
      rEmailError.value = "enteryouremail".tr;
      isValid.value = false;
    } else if (!rEmail.value.text.isEmail) {
      rEmailError.value = "entervalidemail".tr;
      isValid.value = false;
    }

    if (rphoneNomber.value.text.isEmpty) {
      rphoneNoError.value = "pleaseenteryourphonenumber".tr;
      isValid.value = false;
    } else if (!Helper.isPhoneNumber(rphoneNomber.value.text)) {
      rphoneNoError.value = "pleaseentervalidphonenumber".tr;
      isValid.value = false;
    }

    return isValid.value;
  }

  updatProfile() async {
    final formData = dio.FormData.fromMap({
      "FirstName": rfirstName.value.text,
      "LastName": rlastName.value.text,
      "CountrCode": countryCode.value != null
          ? generateCode(countryCode.value!['dial_code'].toString())
          : '+91',
      "PhoneNumber": rphoneNomber.value.text,
      if (profileImage.value.path.isNotEmpty)
        "ProfileImage": await dio.MultipartFile.fromFile(
          profileImage.value.path,
        )
    });

    if (isEdit) {
      BottomBarController bottomBarController = Get.find();
      if (validMYProfile()) {
        try {
          isLoading.value = true;
          ProfileUpdate response = await _userRepo.updateProfile(formData);
          if (response.isSuccess == true) {
            final Map<String, dynamic> profileData = {
              'id': response.result!.id as String,
              'firstName': response.result!.firstName as String,
              'lastName': response.result!.lastName as String,
              'countryCode': response.result!.countryCode as String,
              'profileImage': response.result!.profileImage as String,
            };
            LocalStorage.storeProfileInfo(profileData);
            bottomBarController.userName.value =
                response.result!.firstName ?? '';
            bottomBarController.userProfileImage.value =
                response.result!.profileImage ?? '';
            toast('Profile Updated');
            Get.back();
          } else {
            Get.snackbar(AppConfig.snackbarErrorTitle, response.message.toString());
          }
        } catch (e) {
          Get.snackbar("Error", e.toString());
        } finally {
          isLoading.value = false;
        }
      }
    }
  }

  onSignUp() async {
    if (validMYProfile()) {
      final Map<String, dynamic> requestParameter = {
        'firstName': rfirstName.value.text,
        'lastName': rlastName.value.text,
        'countryCode': countryCode.value != null
            ? generateCode(countryCode.value!['dial_code'].toString())
            : '+91',
        'phoneNumber': rphoneNomber.value.text,
        'email': rEmail.value.text,
        'deviceToken': deviceToken.value,
        'firebaseAuthToken': "123",
        'loginMode': loginMode.value,
        'meta': 'Android',
      };

      try {
        isLoading.value = true;
        UserRegisterModel response =
            await _authRepository.signUpUser(requestParameter);
        if (response.isSuccess == true) {
          login(response.result!.phoneNumber!);
        } else {
          Get.snackbar(AppConfig.snackbarErrorTitle, response.message.toString());
        }
      } catch (e) {
        Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.userRegisterErrorMessage);
      } finally {
        isLoading.value = false;
      }
    }
  }

  //
  login(String phone) async {
    final Map<String, dynamic> requestParameter = {
      'phoneNumber': phone,
      'deviceToken': deviceToken.value,
      'firebaseAuthToken': "123",
      'loginMode': loginMode.value,
      'meta': 'Android'
    };
    try {
      LoginModel response = await _authRepository.loginUser(requestParameter);
      if (response.isSuccess == true) {
        final Map<String, dynamic> loginData = {
          'id': response.result!.id as String,
          'firstName': response.result!.firstName as String,
          'lastName': response.result!.lastName as String,
          'countryCode': response.result!.countryCode as String,
          'phoneNumber': response.result!.phoneNumber as String,
          'email': response.result!.email as String,
          'profileImage': response.result!.profileImage as String,
          'jwtToken': response.result!.jwtToken,
          'refreshToken': response.result!.refreshToken,
          'login_status': true
        };
        LocalStorage.storeDataInfo(loginData);
        Get.toNamed(AppRoute.businessDetail,
            arguments: ['', false, true, 'myprofile']);
      } else {
        Get.snackbar(AppConfig.snackbarErrorTitle, response.message.toString());
      }
    } catch (e) {
      Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.userLoginErrorMessage);
    }
  }
  //

// ...

// ...

  void pickProfileFile(context) async {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 10),
              // Remove the Text widget
              CustomListTile(
                icon: Icons.camera_alt,
                color: Colors.blue,
                text: "Take a photo",
                onTap: () async {
                  Navigator.pop(context);
                  await picImage(false);
                },
              ),
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              CustomListTile(
                icon: Icons.photo_library,
                color: Colors.green,
                text: "Choose from gallery",
                onTap: () async {
                  Navigator.pop(context);
                  await picImage(true);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Future picImage(bool fromGallery) async {
    XFile? pickedFile;
    try {
      pickedFile = await picker.pickImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera,
        maxHeight: 500,
        maxWidth: 500,
      );
    } catch (e) {
      Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.anErrorOccurred);
    }
    if (pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          compressQuality: 50,
          aspectRatioPresets: [
            CropAspectRatioPreset.square
          ],
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: "edit".tr,
              statusBarColor: AppColors.darkBlueBlack,
              toolbarColor: Colors.black, // Change toolbar color to black
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: true,
            ),
            IOSUiSettings(
              title: "edit".tr,
            ),
          ]);
      if (croppedFile != null) {
        profileImage.value = File(croppedFile.path);
      }
    } else {
      return;
    }
  }
}
