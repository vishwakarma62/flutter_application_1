import 'dart:async';

import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/core/local_storage.dart';
import 'package:postervibe/core/utils/app_config.dart';
import 'package:postervibe/core/utils/app_version_checker.dart';
import 'package:postervibe/data/model/banner.dart';
import 'package:postervibe/data/model/get_category_list_model.dart';
import 'package:postervibe/data/model/dashboard_event_and_event_post_model.dart';
import 'package:postervibe/data/model/my_business_list_model.dart';
import 'package:postervibe/data/model/today_event_list_model.dart';
import 'package:postervibe/data/repository/business_repo.dart';
import 'package:postervibe/data/repository/dashboard_repo.dart';
import 'package:postervibe/di/service_locator.dart';
import 'package:postervibe/presentation/bottom_bar/bottom_bar_controller.dart';
import 'package:carousel_slider/carousel_controller.dart';

class HomeController extends GetxController {
  final _repository = getIt.get<DashBoardRepository>();
  final _businessRepo = getIt.get<BusinessRepository>();
final appVersionChecker = AppVersionChecker();
  final BottomBarController bottomBarController = Get.find();
  final CarouselController carouselController = CarouselController();

  final RxInt selectedIndex = 0.obs;
  final RxList<CategoryData> categoryList = <CategoryData>[].obs;
  final RxList<DashBoardEventAndEventPOstData> postList =
      <DashBoardEventAndEventPOstData>[].obs;
  final RxList<EventList> todaysEventList = <EventList>[].obs;
  final RxList<BannerData> bannerList = <BannerData>[].obs;

  final RxBool isUpcomingFestivalLoading = false.obs;
  final RxBool isCategoryListLoading = false.obs;
  final RxBool isTodayEventLoading = false.obs;
  final RxBool isBusinessLoading = false.obs;
  final RxBool isBannerLoading = false.obs;
  final RxBool noInternet = false.obs;


 RxBool isDialogue = false.obs;
  Future<void> getTodayEventList() async {
    try {
      isTodayEventLoading.value = true;
      final response = await _repository.getTodaysEventList({});
      if (response.isSuccess == true) {
        todaysEventList.assignAll(response.result?.data?.list ?? []);
      }
    } catch (e) {
      handleNetworkError(e);
    } finally {
      isTodayEventLoading.value = false;
    }
  }

  Future<void> getBannerList() async {
    print('APi Called');
    try {
      isBannerLoading.value = true;
      final response = await _repository.getBannerList();
      if (response.isSuccess == true) {
        bannerList.assignAll(response.result?.list ?? []);
      }
    } catch (e) {
      handleNetworkError(e);
    } finally {
      isBannerLoading.value = false;
    }
  }

  Future<void> getCategoryList() async {
    try {
      isCategoryListLoading.value = true;
      final response = await _repository.getCategoryList();
      categoryList.assignAll(response.result?.data ?? []);
    } catch (e) {
      handleNetworkError(e);
    } finally {
      isCategoryListLoading.value = false;
    }
  }

  Future<void> getPostList() async {
    try {
      isUpcomingFestivalLoading.value = true;
      final response = await _repository.getDashBoardEventAndEventPost();
      postList.assignAll(response.result?.data ?? []);
    } catch (e) {
      handleNetworkError(e);
    } finally {
      isUpcomingFestivalLoading.value = false;
    }
  }

  getBusinessList() async {
    try {
      isBusinessLoading.value = true;
      MyBusinessListModel response = await _businessRepo.getMyBusinessList();

      if (response.isSuccess == true) {
        for (var element in response.result!.data!) {
          if (response.result!.data!.isNotEmpty) {
            if (element.isDefault == true) {
              LocalStorage.selectBusinessIndex(element);
            }
          } else {
            print('list is empty');
          }
        }
      }
    } catch (e) {
      Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.fetchListErrorMessage);
    } finally {
      isBusinessLoading.value = false;
    }
  }

  void handleNetworkError(dynamic error) {
    Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.fetchListErrorMessage);
  }
}
