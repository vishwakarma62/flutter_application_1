import 'dart:async';

import 'package:get/get.dart';
import 'package:postervibe/data/model/event_and_posts_model.dart';
import 'package:postervibe/data/repository/all_event_and_post_repository.dart';

import 'package:postervibe/di/service_locator.dart';
import 'package:postervibe/presentation/bottom_bar/bottom_bar_controller.dart';

import '../../../core/app_export.dart';
import '../../../core/utils/app_config.dart';

class PostController extends GetxController {
  final _eventPostList = getIt.get<AllEventAndPostRepo>();
  final BottomBarController bottomBarController = Get.find();
  RxBool isLoading = false.obs;
  RxList<EventAndPostData> postLists = RxList([]);
  RxBool noInternet = false.obs;
  RxInt total = 0.obs;
  int currentPage = 1;

  @override
  void onClose() {
    super.onClose();
    dispose();
  }

  Future<void> fetchInitialData() async {
    try {
      isLoading.value = true;
      final response = await _eventPostList.allEventAndPost({
        "filter": {"page": 1}
      });
      if (response.isSuccess == true) {
        total.value = response.result!.data!.total!;
        final List<EventAndPostData>? newData = response.result?.data?.list;
        postLists.assignAll(newData ?? []);
        currentPage = 1;
      }
    } catch (e) {
      Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.fetchListErrorMessage);
    } finally {
      isLoading.value = false;
    }
  }

  RxBool isAdMore = false.obs;
  Future<void> loadMoreData() async {
    currentPage++;
    try {
      final response = await _eventPostList.allEventAndPost({
        "filter": {"page": currentPage}
      });
      final List<EventAndPostData>? newData = response.result?.data?.list ?? [];
      if (newData!.isNotEmpty) {
        total.value = response.result!.data!.total!;
        postLists.addAll(newData);
        isAdMore.value =false;
      }
    } catch (e) {
       isAdMore.value =false;
      Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.fetchMoreDataErrorMessage);
    } finally {
      isAdMore.value =false;
    }
  }
}
