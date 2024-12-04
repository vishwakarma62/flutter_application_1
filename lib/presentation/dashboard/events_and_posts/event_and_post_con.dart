import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:postervibe/core/network/network_info.dart';
import 'package:postervibe/core/utils/app_config.dart';
import 'package:postervibe/data/model/event_and_posts_model.dart';
import 'package:postervibe/data/repository/dashboard_repo.dart';
import 'package:postervibe/di/service_locator.dart';
import 'package:postervibe/presentation/bottom_bar/bottom_bar_controller.dart';

class EventAndPostController extends GetxController {
  final _repository = getIt.get<DashBoardRepository>();
  ConnectivityManager connectivityManager = Get.find<ConnectivityManager>();
  RxBool noInternet = false.obs;
  RxBool isAdMore = false.obs;
  final BottomBarController bottomBarController = Get.find();
  RxInt total = 0.obs;
  int currentPage = 1;
  @override
  void onClose() {
    super.onClose();
    dispose();
  }

  RxBool isLoading = false.obs;
  RxString ID = ''.obs;
  RxString eventName = ''.obs;

  RxList<EventAndPostData> eventPostList = RxList([]);

  getEventAndPostByCategory() async {
    final Map<String, dynamic> requestParameter = {
      "categoryId": ID.value,
    };
    try {
      isLoading.value = true;
      final response =
          await _repository.getEventAndPostByCategory(requestParameter);
      if (response.isSuccess!) {
        total.value = response.result!.data!.total!;
        eventPostList.assignAll(response.result!.data!.list!);
        currentPage = 1;
      }
    } catch (e) {
      Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.fetchListErrorMessage);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreData() async {
    currentPage++;
    try {
      final response = await _repository.getEventAndPostByCategory({
        "filter": {"page": currentPage}
      });
      final List<EventAndPostData>? newData = response.result?.data?.list ?? [];
      if (newData!.isNotEmpty) {
        total.value = response.result!.data!.total!;
        eventPostList.addAll(newData);
        isAdMore.value = false;
      }
    } catch (e) {
      isAdMore.value = false;
      Get.snackbar(
          AppConfig.snackbarErrorTitle, AppConfig.fetchMoreDataErrorMessage);
    } finally {
      isAdMore.value = false;
    }
  }
}
