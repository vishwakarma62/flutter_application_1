import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/core/network/network_info.dart';
import 'package:postervibe/core/utils/app_config.dart';
import 'package:postervibe/data/repository/search_event_repo.dart';
import 'package:postervibe/di/service_locator.dart';
import 'package:postervibe/presentation/ad/ad_size.dart';
import 'package:postervibe/presentation/bottom_bar/bottom_bar_controller.dart';

class SearchScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  final _searchRepo = getIt.get<SearchRepository>();
  late InlineAdaptiveSize? adSize;
  TextEditingController textEditingController = TextEditingController();
  ConnectivityManager connectivityManager = Get.find<ConnectivityManager>();
  BottomBarController bottomBarController = Get.find();
  RxBool isAdLoading = false.obs;
  RxBool isLoading = false.obs;
  RxString enterText = ''.obs;
  RxBool noInternet = false.obs;
  final RxList<dynamic> searchedEventList = <dynamic>[].obs;
  RxInt total = 0.obs;
  int page = 1;
  Timer? _debounce;
  bool isPageLoading = false; 

  @override
  void onInit() {
    super.onInit();
    loadAdSize();
    searchEvent(limit: 20, page: 1, query: '');
    scrollController.addListener(_onScroll);
    connectivityManager.isConnected.listen(_onConnectivityChanged);
  }

  @override
  void onClose() {
    _debounce?.cancel();
    scrollController.removeListener(_onScroll);
    textEditingController.dispose();
    super.onClose();
  }

  void _onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (searchedEventList.length < total.value && !isPageLoading) {
        addEvent();
      }
    }
  }

  void _onConnectivityChanged(bool isConnected) {
    noInternet.value = !isConnected;
    if (isConnected) {
      searchEvent(limit: 20, page: 1, query: '');
    }
  }

  void loadAdSize() async {
    adSize = await AdmobBannerSize.customPortraitAdaptiveBannerAdSize(
        Get.context!,
        customWidth: Get.width / 3);
  }

  final Duration _debouceDuration = const Duration(milliseconds: 500);

  onSearchChanged(String query) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(_debouceDuration, () async {
      await searchEvent(limit: 20, page: 1, query: query);
    });
  }

  Future<void> checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      searchEvent(limit: 20, page: 1, query: '');
    } else {
      noInternet.value = true;
    }
  }

  searchEvent(
      {required String query, required int page, required int limit}) async {
    String filteredQuerry = query.replaceAll(' ', '');
    final Map<String, dynamic> requestParameter = {
      "filter": {
        "page": page,
        "limit": limit,
        "commonSearchField": filteredQuerry
      }
    };

    try {
      isLoading(true);
      final response = await _searchRepo.searchEvent(requestParameter);
      if (response.isSuccess!) {
        if (searchedEventList.isEmpty) {
          total.value = response.result!.data!.total!;
          searchedEventList.assignAll(response.result!.data!.list!);
        } else {
          total.value = response.result!.data!.total!;
          searchedEventList.clear();
          searchedEventList.addAll(response.result!.data!.list!);
        }
      }
    } catch (e) {
      handleNetworkError(e);
      return false;
    } finally {
      isLoading(false);
    }
  }

  Future<void> loadMoreEvents(
      {required String query, required int page, required int limit}) async {
    String filteredQuery = query.replaceAll(' ', '');
    final Map<String, dynamic> requestParameter = {
      "filter": {
        "page": page,
        "limit": limit,
        "commonSearchField": filteredQuery
      }
    };

    try {
      isPageLoading = true;
      final response = await _searchRepo.searchEvent(requestParameter);
      if (response.isSuccess!) {
        total.value = response.result!.data!.total!;
        searchedEventList.addAll(response.result!.data!.list!);
      }
    } catch (e) {
      handleNetworkError(e);
    } finally {
      isPageLoading = false;
    }
  }

  void addEvent() async {
    if (isLoading.value || isPageLoading) return;
    isPageLoading = true;
    page++;
    await loadMoreEvents(limit: 20, page: page, query: enterText.value);
  }

  void handleNetworkError(dynamic error) {
    Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.fetchListErrorMessage);
  }
}
