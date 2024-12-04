import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/core/network/network_info.dart';
import 'package:postervibe/core/utils/app_config.dart';
import 'package:postervibe/core/utils/loader.dart';
import 'package:postervibe/data/model/get_my_post_model.dart';
import 'package:postervibe/data/repository/my_post_repo.dart';
import 'package:postervibe/di/service_locator.dart';
import 'package:postervibe/routes/app_routes.dart';

class DownloadController extends GetxController
    with GetSingleTickerProviderStateMixin {
  ConnectivityManager connectivityManager = Get.find();
  final _repository = getIt.get<MyPostRepo>();
  RxList<MyDownloadedPost> myPostLists = RxList([]);

  RxBool noInternet = false.obs;
  RxString userID = ''.obs;

  Rx<TabController?> tabController = Rx(null);

  RxList<File> imageFileList = <File>[].obs;

  RxBool isLoading = false.obs;
  RxBool isSharing = false.obs;

  RxInt selectIndex = 0.obs;

  void getMyPost() async {
    try {
      isLoading.value = true;
      final response = await _repository.getMyPost();
      if (response.isSuccess == true) {
        myPostLists.assignAll(response.result!.data!);
      }
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> goToShare(String url, BuildContext context) async {
    bool isLoading = true;
    try {
      DialogueHelper.showLoading(context,
          isDissmiss: isLoading == true ? false : false);

      Map<String, dynamic>? response = await _repository.getbytes(url);
      if (response!['response'] == 200) {
        Uint8List bytes = response['byteData'];
        saveByteDataToFile(bytes);
      } else {
        isLoading = false;
        DialogueHelper.hideLoading();
        throw Exception(AppConfig.failedToLoadImage);
      }
    } catch (e) {
      isLoading = false;
      DialogueHelper.hideLoading();
      Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.cannotShareMessage);
    } finally {
      isLoading = false;
      DialogueHelper.hideLoading();
    }
  }

  saveByteDataToFile(Uint8List byteData) async {
    AppConfig.getLocalDirectoryPath(appName: 'image').then((value) async {
      await File(value).writeAsBytes(byteData);
      Get.toNamed(AppRoute.preview, arguments: [File(value), false]);
    });
  }

  void deleteMyPost(int index, BuildContext context) async {
    final Map<String, dynamic> requestParameter = {"id": myPostLists[index].id};
    try {
      DialogueHelper.showLoading(context);
      final response = await _repository.deleteMyPost(requestParameter);
      if (response.isSuccess == true) {
        getMyPost();
      }
    } catch (e) {
      DialogueHelper.hideLoading();
      Get.snackbar(
          AppConfig.snackbarErrorTitle, AppConfig.snackbarErrorMessage);
    } finally {
      DialogueHelper.hideLoading();
    }
  }
}
