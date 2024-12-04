import 'package:flutter/material.dart';
import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/core/local_storage.dart';
import 'package:postervibe/core/network/network_info.dart';
import 'package:postervibe/core/utils/app_config.dart';
import 'package:postervibe/core/utils/loader.dart';
import 'package:postervibe/data/model/add_and_update_business_model.dart';
import 'package:postervibe/data/model/delete_business_model.dart';
import 'package:postervibe/data/model/my_business_list_model.dart';
import 'package:postervibe/data/repository/business_repo.dart';
import 'package:postervibe/di/service_locator.dart';
import 'package:dio/dio.dart' as dio;

class MyBusinessListController extends GetxController {
  BusinessRepository repository = getIt.get<BusinessRepository>();
  ConnectivityManager connectivityManager = Get.find<ConnectivityManager>();
  RxBool isConnected = true.obs;
  final RxBool isLoading = false.obs;
  RxBool noInternet = false.obs;

  final RxBool isUpdateLoading = false.obs;
  final RxList<myBusinessData> businessList = RxList([]);

  @override
  void onInit() {
    getMyBusinessList();
    connectivityManager.isConnected.listen((isConnected) {
      if (isConnected) {
        noInternet.value = false;
        getMyBusinessList();
      } else {
        noInternet.value = true;
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    dispose();
    super.onClose();
  }

  getMyBusinessList() async {
    try {
      isLoading.value = true;
      final response = await repository.getMyBusinessList();
      if (response.isSuccess!) {
        businessList.assignAll(response.result!.data!);
        for (var element in response.result!.data!) {
          if (element.isDefault!) {
            LocalStorage.selectBusinessIndex(element);
          }
        }
      }
    } catch (e) {
      Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.fetchListErrorMessage);
    } finally {
      isLoading.value = false;
    }
  }

  updateSelectedIndexBusinessList(
      {required int updateIndex,
      int? deleteIndex,
      required BuildContext context}) async {
    try {
      DialogueHelper.showLoading(context);
      final formdata = dio.FormData.fromMap({
        "Id": businessList[updateIndex].id,
        "BusinessCategoryId": businessList[updateIndex].businessCategoryId,
        "IsDefault": true,
        "businessName": businessList[updateIndex].businessName,
      });
      AddAndUpdateBusinessModel response =
          await repository.selectBusiness(formdata);
      if (response.isSuccess == true) {
        if (response.result!.data!.isNotEmpty) {
          for (var i = 0; i < businessList.length; i++) {
            if (businessList[i].id == businessList[updateIndex].id &&
                i == updateIndex) {
              businessList[i].isDefault = true;
              LocalStorage.selectBusinessIndex(businessList[i]);
            } else {
              businessList[i].isDefault = false;
            }
            businessList.refresh();
          }
        }
        if (deleteIndex != null) deleteBusiness(deleteIndex);
      } else if (response.statusCode != 200) {
        Get.snackbar(AppConfig.snackbarErrorTitle, response.message.toString());
      }
    } catch (e) {
      Get.snackbar(AppConfig.snackbarErrorTitle, e.toString());
    } finally {
      DialogueHelper.hideLoading();
    }
  }

  deleteBusiness(int index) async {
    try {
      DeleteBusinessModel response =
          await repository.deleteBusiness({"Id": businessList[index].id});
      if (response.isSuccess == true) {
        if (businessList.length == 1) {
          LocalStorage.clearSelectedBusinessData();
          businessList.removeAt(index);
        } else {
          businessList.removeAt(index);
        }
      }
    } catch (e) {
      Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.fetchListErrorMessage);
    } finally {}
  }
}
