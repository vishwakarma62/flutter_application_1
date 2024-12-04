import 'dart:io';

import 'package:flutter/material.dart';
import 'package:postervibe/core/app_export.dart';
import 'package:dio/dio.dart' as dio;
import 'package:postervibe/core/utils/app_config.dart';
import 'package:postervibe/core/utils/loader.dart';
import 'package:postervibe/data/repository/my_post_repo.dart';
import 'package:postervibe/di/service_locator.dart';
import 'package:postervibe/presentation/ad/ad_controller.dart';
import 'package:postervibe/presentation/ad/ad_type.dart';
import 'package:postervibe/presentation/ad/ad_unit_id.dart';
import 'package:postervibe/presentation/bottom_bar/bottom_bar_controller.dart';
import 'package:postervibe/routes/app_routes.dart';
import 'package:share_plus/share_plus.dart';

class PreviewController extends GetxController {
  late BuildContext context;
  BottomBarController bottomBarController = Get.find();
  final _repository = getIt.get<MyPostRepo>();
  RxBool isDisplayAd = false.obs;
  var data = Get.arguments[0];
  double heightThreshold = 680.0;
  bool downloadImage = Get.arguments[1];
  String? _path;
  RxBool canShare = true.obs;
  RxBool isLoading = false.obs;
  RxString userID = ''.obs;
  bool canDownload = true;

  @override
  void onInit() {
    isDisplayAd.value = bottomBarController.shouldShowAdAvailable;

    super.onInit();
  }

  void setContext(BuildContext context) {
    this.context = context;
  }

  void download() async {
    String imagePath = '';
    try {
      isLoading.value = true;
      await AppConfig.getLocalDirectoryPath().then((value) {
        imagePath = value;
      });
      dio.FormData formData = dio.FormData.fromMap({
        'PostImage': dio.MultipartFile.fromBytes(
          data,
          filename: imagePath,
        ),
      });
      final response = await _repository.downloadPost(formData);
      if (response.isSuccess == true) {
        isDisplayAd.value
            ? interstialLoad(isSharing: false)
            : navigationLogic();
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
          AppConfig.snackbarErrorTitle, AppConfig.imageDownloadSuccessMessage);
    }
  }

  void share(BuildContext context) async {
    if (Get.currentRoute == AppRoute.preview) {
      DialogueHelper.showLoading(context);
    }
    if (downloadImage) {
      isDisplayAd.value
          ? interstialLoad(isSharing: true)
          : fileOPeration(isSharing: true);
    } else {
      _path = data.path;
      shareFile(_path!, context);
    }
  }

  shareFile(String path, BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    if (Get.currentRoute == AppRoute.preview) {
      canShare.value = false;
      if (_path != null) {
        await Share.shareXFiles(
          [XFile(path)],
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
        ).then((value) {
          canShare.value = true;
          DialogueHelper.hideLoading();
        });
      } else {
        canShare.value = true;
        DialogueHelper.hideLoading();
        Get.snackbar(
            AppConfig.snackbarErrorTitle, AppConfig.cannotShareMessage);
      }
    }
  }

  interstialLoad({required bool isSharing}) async {
    await AdController().loadInterstitial(
        onAdLoaded: (ad) {
          ad.show();
          isSharing ? fileOPeration(isSharing: false) : null;
        },
        onAdDismissedFullScreenContent: (ad) {
          isSharing ? shareFile(_path!, context) : navigationLogic();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {},
        onAdFailedToLoad: (error) {
          isSharing ? shareFile(_path!, context) : navigationLogic();
        },
        adUnitId: AdUnitIds.getTestAdUnitId(adType: AdType.interstitial),
        nonPersonalizedAds: false);
  }

  void navigationLogic() async {
    isLoading.value = false;
    await Get.offAllNamed(AppRoute.bottom, arguments: 2);
    if (Get.currentRoute == AppRoute.bottom) {
      Get.snackbar(AppConfig.snackbarSuccessTitle,
          AppConfig.imageDownloadSuccessMessage);
    }
  }

  void fileOPeration({required bool isSharing}) async {
    AppConfig.getLocalDirectoryPath().then((value) {
      _path = value;
      if (_path != null) {
        File(_path!).writeAsBytesSync(data);
        isSharing == true ? shareFile(_path!, context) : null;
      } else {
        Get.snackbar(
            AppConfig.snackbarErrorTitle, AppConfig.cannotShareMessage);
      }
    });
  }
}
