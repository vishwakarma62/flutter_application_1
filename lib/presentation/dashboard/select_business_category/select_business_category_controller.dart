
import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/core/utils/app_config.dart';
import 'package:postervibe/data/model/get_business_category_list_model.dart';
import 'package:postervibe/data/repository/business_repo.dart';
import 'package:postervibe/di/service_locator.dart';

import 'package:flutter/material.dart';

class SelectBusinessCategoryController extends GetxController {
  final _repository = getIt.get<BusinessRepository>();
  @override
  void onInit() async {
    getMyBusinessCategoryNameList();
    super.onInit();
  }

  RxBool isLoading = false.obs;

  RxList<BusinessCategoryData> businessCategoryList = RxList([]);

  RxList selectBusinessList = [].obs;

  getMyBusinessCategoryNameList() async {
   
      try {
        isLoading.value = true;
        BusinessCategoryNameList response =
            await _repository.getBusinessCategoryList();
        if (response.isSuccess == true) {
          for (var element in response.result!.data!) {
            businessCategoryList.add(element);
          }
        }
      } catch (e) {
        debugPrint(e.toString());
        Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.fetchListErrorMessage);
      } finally {
        isLoading.value = false;
      }
    } 
  }

