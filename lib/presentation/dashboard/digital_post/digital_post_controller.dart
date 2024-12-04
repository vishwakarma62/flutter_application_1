import 'dart:async';

import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/core/local_storage.dart';
import 'package:postervibe/core/network/network_info.dart';
import 'package:postervibe/core/utils/app_config.dart';
import 'package:postervibe/data/model/get_event_post_list_by_event_id_model.dart';
import 'package:postervibe/data/repository/dashboard_repo.dart';
import 'package:postervibe/di/service_locator.dart';

class DigitalPostController extends GetxController {
  final _repository = getIt.get<DashBoardRepository>();

  ConnectivityManager connectivityManager = Get.find<ConnectivityManager>();

  RxInt selectIndex = 0.obs;
  RxString eventID = ''.obs;
  RxString eventName = ''.obs;
  RxString postId = ''.obs;
  RxString postLanguage = "All".obs;
  RxBool isLoading = false.obs;
  RxString selectedBusinessId = ''.obs;
  RxList<EventPostByEventIdData> postList = <EventPostByEventIdData>[].obs;
  RxList<EventPostByEventIdData> data = <EventPostByEventIdData>[].obs;
  RxList<String> languageList = RxList();
  RxBool noInternet = false.obs;
  @override
  void onInit() {
    super.onInit();
    selectedBusinessId.value = LocalStorage.selectedBusinessId.value;
    eventID.value = Get.arguments[0];
    postId.value = Get.arguments[1];
    eventName.value = Get.arguments[2];

    fetchEventPostByEventId(eventID.value);
    connectivityManager.isConnected.listen((isConnected) {
      if (isConnected) {
        noInternet.value = false;
        postList.clear();
        data.clear();
        fetchEventPostByEventId(eventID.value);
      } else {
        noInternet.value = true;
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    dispose();
  }

  Future<void> fetchEventPostByEventId(String eventId) async {
    try {
      isLoading.value = true;
      final response = await _repository.getEventPostByCategoryEvent({
        "eventId": eventId,
        "filter": {"page": 1, "limit": 50}
      });
      if (response.isSuccess == true) {
        final newData = response.result!.data?.list ?? [];
        data.addAll(newData);
        postList.addAll(data);
        final uniqueLanguages =
            newData.map((element) => element.language!).toSet();
        languageList.assignAll(["All", ...uniqueLanguages]);
        final postIdValue = postId.value;
        if (postIdValue.isNotEmpty) {
          final index = data.indexWhere((element) => element.id == postIdValue);
          if (index != -1) {
            selectIndex.value = index;
          }
        }
      }
    } catch (e) {
      Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.fetchListErrorMessage);
    } finally {
      isLoading.value = false;
    }
  }

  final List<Map<String, String>> categoryList = [
    {'title': 'all'.tr},
    {'title': 'gujrati'.tr},
    {'title': 'hindi'.tr},
    {'title': 'english'.tr},
  ];
}

class Data {
  String eventId;
  String postId;
  String eventName;

  Data({required this.eventId, required this.eventName, required this.postId});
}
