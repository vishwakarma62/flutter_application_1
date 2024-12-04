import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:postervibe/core/utils/app_config.dart';
import 'package:postervibe/data/model/get_category_list_model.dart';
import 'package:postervibe/data/repository/dashboard_repo.dart';
import 'package:postervibe/di/service_locator.dart';

class AllCategoryController extends GetxController {
  final _repository = getIt.get<DashBoardRepository>();
  late StreamSubscription<ConnectivityResult> networkSubscription;
  RxBool noInternet = false.obs;

  var isLoading = false.obs;
  RxList<CategoryData> allCategory = RxList([]);

  Future<void> getCategoryList() async {
    try {
      isLoading.value = true;
      final response = await _repository.getCategoryList();
      allCategory.assignAll(response.result?.data ?? []);
    } catch (e) {
      Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.fetchListErrorMessage);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    // Dispose of the controller
    networkSubscription.cancel();
  }

  Future<void> checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      getCategoryList();
    } else {
      noInternet.value = true;
    }
  }
}
