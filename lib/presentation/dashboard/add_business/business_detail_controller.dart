import 'dart:async';
import 'dart:io';

import 'package:postervibe/core/local_storage.dart';
import 'package:postervibe/core/utils/app_config.dart';
import 'package:postervibe/core/utils/loader.dart';
import 'package:postervibe/data/model/add_and_update_business_model.dart';
import 'package:postervibe/data/model/my_business_list_model.dart';
import 'package:postervibe/routes/app_routes.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/core/network/network_info.dart';
import 'package:postervibe/core/utils/global.dart';
import 'package:postervibe/data/model/get_business_category_list_model.dart';
import 'package:postervibe/data/repository/business_repo.dart';
import 'package:postervibe/di/service_locator.dart';

import 'package:image_picker/image_picker.dart';

class BusinessDetailController extends GetxController {
  ConnectivityManager connectivityManager = Get.find<ConnectivityManager>();
  final _repository = getIt.get<BusinessRepository>();
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

  RxBool noInternet = false.obs;

  @override
  void onClose() {
    DialogueHelper.hideLoading();
    super.onClose();
    dispose();
  }

  Rx<TextEditingController> bNameController =
      TextEditingController(text: "").obs;
  Rx<TextEditingController> bemailController =
      TextEditingController(text: "").obs;
  Rx<TextEditingController> balternativePhoneNumberController =
      TextEditingController(text: "").obs;
  Rx<TextEditingController> bphoneNumberController =
      TextEditingController(text: "").obs;
  Rx<TextEditingController> bwebsiteController =
      TextEditingController(text: "").obs;
  Rx<TextEditingController> baddressController =
      TextEditingController(text: "").obs;
  Rx<TextEditingController> selectedCategoryController =
      TextEditingController(text: "").obs;

  RxString businessCategoryError = "".obs;
  RxString businessNameError = "".obs;
  RxString alternativePhoneError = "".obs;
  RxString bEmailError = "".obs;
  RxString websiteError = "".obs;
  RxString mobileNumberError = "".obs;
  RxString addressError = "".obs;
  RxString codeError = "".obs;

  RxBool isCategoryListLoading = false.obs;

  Rx<Map?> selectedCategory = Rx(null);
  String selectedCategoryId = '';
  RxString selectedCategoryError = "".obs;
  RxList<Map<String, dynamic>> businessCategoryList = RxList([]);

  myBusinessData? myBusinessModel;

  var data = Get.arguments[0];
  var isEdit = Get.arguments[1];

  RxBool isLoading = false.obs;
  RxBool isSkip = false.obs;

  Rx<File> profileImage = File("").obs;
  final ImagePicker picker = ImagePicker();
  Rx<Map?> countryCode = Rx(null);
  RxString logoUrl = "".obs;
  RxString previousRoute = ''.obs;
  @override
  void onInit() async {
    connectivityManager.isConnected.listen((isConnected) {
      if (isConnected) {
        noInternet.value = false;
      } else {
        isConnected = true;
      }
    });
    previousRoute.value = Get.previousRoute;
    isSkip.value = Get.arguments[2];
    if (isEdit == true) {
      myBusinessModel = data;
      bNameController.value.text = myBusinessModel!.businessName ?? "";
      bemailController.value.text = myBusinessModel!.email ?? "";
      bwebsiteController.value.text = myBusinessModel!.website ?? "";
      baddressController.value.text = myBusinessModel!.address ?? "";
      logoUrl.value = myBusinessModel!.logo ?? "";
      bphoneNumberController.value.text = myBusinessModel!.phoneNumber1 ?? '';
      balternativePhoneNumberController.value.text =
          myBusinessModel!.phoneNumber2 ?? '';
      selectedCategoryController.value.text =
          myBusinessModel!.businessCategoryName ?? '';
      selectedCategoryId = myBusinessModel!.businessCategoryId ?? '';
    } else {
      bphoneNumberController.value.text = LocalStorage.userMobile;
      bemailController.value.text = LocalStorage.userEmail;
    }
    super.onInit();
  }

  bool isValid() {
    bool isValid = true;
    businessCategoryError.value = "";
    businessNameError.value = "";
    mobileNumberError.value = "";
    alternativePhoneError.value = "";
    bEmailError.value = "";
    websiteError.value = '';
    addressError.value = '';

    if (bNameController.value.text.isEmpty) {
      businessNameError.value = "Please Enter Company Name".tr;
      isValid = false;
    }
    if (selectedCategoryController.value.text.isEmpty) {
      selectedCategoryError.value = "Please Select Category Name".tr;
      isValid = false;
    }
    if (bemailController.value.text.isEmpty) {
      bEmailError.value = "Please Enter Company Email".tr;
      isValid = false;
    } else if (!bemailController.value.text.isEmail) {
      bEmailError.value = "entervalidemail".tr;
      isValid = false;
    }
    if (bphoneNumberController.value.text.isEmpty) {
      mobileNumberError.value = "pleaseenteryourphonenumber".tr;
      isValid = false;
    } else if (!Helper.isPhoneNumber(bphoneNumberController.value.text)) {
      mobileNumberError.value = "pleaseentervalidphonenumber".tr;
      isValid = false;
    }
    if (balternativePhoneNumberController.value.text.isNotEmpty &&
        !Helper.isPhoneNumber(balternativePhoneNumberController.value.text)) {
      alternativePhoneError.value = "Please Enter a Valid Phone Number".tr;
      isValid = false;
    }
    if (bwebsiteController.value.text.isEmpty) {
      websiteError.value = "Please Enter Company Website".tr;
      isValid = false;
    } else if (!Helper.isValidURL(bwebsiteController.value.text)) {
      websiteError.value = "Please Enter a Valid Website URL".tr;
      isValid = false;
    }
    if (baddressController.value.text.isEmpty) {
      addressError.value = "Please Enter Company Address".tr;
      isValid = false;
    }
    return isValid;
  }

  getMyBusinessCategoryNameList() async {
    try {
      isCategoryListLoading.value = true;
      BusinessCategoryNameList response =
          await _repository.getBusinessCategoryList();
      if (response.isSuccess == true) {
        businessCategoryList.assignAll(
            response.result!.data!.map((category) => category.toJson()));
      }
    } catch (e) {
      Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.fetchListErrorMessage);
    } finally {
      isCategoryListLoading.value = false;
    }
  }

  addAndUpdateBusiness() async {
    if (isEdit) {
      if (isValid()) {
        try {
          // for update
          isLoading.value = true;
          final formData = dio.FormData.fromMap({
            if (profileImage.value.path.isNotEmpty)
              'Logo': await dio.MultipartFile.fromFile(
                profileImage.value.path,
              ),
            "BusinessCategoryId": selectedCategoryId,
            "businessName": bNameController.value.text,
            "phoneNumber1": bphoneNumberController.value.text,
            "phoneNumber2": balternativePhoneNumberController.value.text,
            "email": bemailController.value.text,
            "website": bwebsiteController.value.text,
            "address": baddressController.value.text,
            "Id": myBusinessModel!.id,
            "isDefault": true,
          });
          AddAndUpdateBusinessModel response =
              await _repository.addBusiness(formData);
          if (response.isSuccess == true) {
            toast('Update Successfully');

            Get.offNamedUntil(
                AppRoute.myBusinessList, (route) => route.isFirst);
          } else if (response.message == 'Business is already exists') {
            bNameController.value.clear();
            isValid();
            Get.snackbar(AppConfig.snackbarErrorTitle, response.message.toString());
          }
        } catch (e) {
          Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.fetchListErrorMessage);
        } finally {
          isLoading.value = false;
        }
      }
    } else {
      // for add

      if (isValid()) {
        try {
          isLoading.value = true;
          final formData = dio.FormData.fromMap({
            if (profileImage.value.path.isNotEmpty)
              'Logo': await dio.MultipartFile.fromFile(
                profileImage.value.path,
              ),
            "BusinessCategoryId": selectedCategoryId,
            "businessName": bNameController.value.text,
            "phoneNumber1": bphoneNumberController.value.text,
            "phoneNumber2": balternativePhoneNumberController.value.text,
            "email": bemailController.value.text,
            "website": bwebsiteController.value.text,
            "address": baddressController.value.text,
            "isDefault": true,
          });
          AddAndUpdateBusinessModel response =
              await _repository.addBusiness(formData);
          if (response.isSuccess == true) {
            toast('Add Successfully');

            if (previousRoute.value == AppRoute.myBusinessList) {
              Get.offNamedUntil(
                  AppRoute.myBusinessList, (route) => route.isFirst);
            }
            if (previousRoute.value == AppRoute.digitalPost) {
              getSelectedBusiness(response.result!.data.toString());
            }
            if (previousRoute.value == AppRoute.bottom) {
              Get.offAllNamed(AppRoute.bottom, arguments: 0);
            }
            if (previousRoute.value == AppRoute.myProfile) {
              Get.offAllNamed(AppRoute.bottom, arguments: 0);
            }
          } else if (response.message == 'Business is already exists') {
            bNameController.value.clear();
            isValid();
            Get.snackbar(AppConfig.snackbarErrorTitle, response.message.toString());
          }
        } catch (e) {
          Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.fetchListErrorMessage);
        } finally {
          isLoading.value = false;
        }
      }
    }
  }

  getSelectedBusiness(String selectedBusiness) async {
    try {
      final response =
          await _repository.getSelectedBusiness({"id": selectedBusiness});
      if (response.isSuccess == true) {
        if (response.result!.data != null) {
          LocalStorage.selectBusinessIndex(myBusinessData(
              address: response.result!.data!.address,
              businessName: response.result!.data!.businessName,
              email: response.result!.data!.email,
              id: response.result!.data!.id,
              logo: response.result!.data!.logo,
              phoneNumber1: response.result!.data!.phoneNumber1,
              phoneNumber2: response.result!.data!.phoneNumber2,
              website: response.result!.data!.website));
          Get.offNamedUntil(AppRoute.digitalPost, (route) => route.isFirst,
              arguments: [
                data.eventId,
                data.postId,
                data.eventName,
              ]);
        }
      } else {
        Get.snackbar(AppConfig.snackbarErrorTitle, response.message.toString());
      }
    } catch (e) {
      Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.anErrorOccurred);
    } finally {}
  }

  Future<void> picImage() async {
    XFile? pickedFile;
    try {
      pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 500,
        maxWidth: 500,
      );
    } catch (e) {
      Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.anErrorOccurred);
      return;
    }

    if (pickedFile == null) {
      return;
    }

    CroppedFile? croppedFile;
    try {
      croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        compressQuality: 50,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: "edit".tr,
            statusBarColor: AppColors.darkBlueBlack,
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: "edit".tr,
          ),
        ],
      );
    } catch (e) {
      Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.anErrorOccurred);
    }

    if (croppedFile == null) {
      return;
    }

    logoUrl.value = "";
    profileImage.value = File(croppedFile.path);
  }
}
