import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:postervibe/core/utils/app_config.dart';
import 'package:postervibe/data/network/dio_exception.dart';
import 'package:postervibe/data/repository/app_version_repo.dart';
// import 'package:postervibe/data/repository/app_version_check_repo/app_version_repo.dart';
import 'package:postervibe/di/service_locator.dart';

enum AndroidStore { googlePlayStore, apkPure }

class AppVersionChecker {
  /// The current version of the app.
  /// if [currentVersion] is null the [currentVersion] will take the Flutter package version
  final String? currentVersion;

  /// The id of the app (com.exemple.your_app).
  /// if [appId] is null the [appId] will take the Flutter package identifier
  final String? appId;

  /// Select The marketplace of your app
  /// default will be `AndroidStore.GooglePlayStore`
  final AndroidStore androidStore;

  AppVersionChecker({
    this.currentVersion,
    this.appId,
    this.androidStore = AndroidStore.googlePlayStore,
  });

  Future<AppCheckerResult> checkUpdate() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final _currentVersion = currentVersion ?? packageInfo.version;
    final _packageName = appId ?? packageInfo.packageName;
    if (Platform.isAndroid) {
      return await _getAppVersion(_currentVersion, _packageName);
    } else if (Platform.isIOS) {
      return await _checkAppleStore(_currentVersion, _packageName);
    } else {
      return AppCheckerResult(
        _currentVersion,
        null,
        "",
        'The target platform "${Platform.operatingSystem}" is not yet supported by this package.',
        false,
      );
    }
  }
}

Future<AppCheckerResult> _getAppVersion(
    String currentVersion, String packageName) async {
  String? errorMsg;
  String? newVersion;
  String? url;
  bool isDisplayAd = true;
  final _appVersion = getIt.get<AppVersionRepo>();
  try {
    final response = await _appVersion.version();
    if (response.message == 'Success' && response.isSuccess == true) {
      newVersion = response.result!.minimumMobileVersion;
      isDisplayAd = response.result!.isDisplayAd == 'true' ? true : false;
      AppConfig.setandroidBannerAdUnitId = response.result!.bannerAdUnitID!;
      AppConfig.setandroidInterstitialAdUnitId =
          response.result!.interstitialAdUnitId!;
    } else if (response.statusCode != 200) {
      errorMsg =
          response.message ?? 'Unable to check the latest version of App';
    }
  } on DioException catch (e) {
    final errorMessage = DioExceptions.fromDioError(e).toString();
    throw errorMessage;
  }
  return AppCheckerResult(
    currentVersion,
    newVersion,
    url,
    errorMsg,
    isDisplayAd,
  );
}

Future<AppCheckerResult> _checkAppleStore(
    String currentVersion, String packageName) async {
  String? errorMsg;
  String? newVersion;
  String? url;
  bool isDisplayAd = false;
  var uri = Uri.https("itunes.apple.com", "/lookup", {"bundleId": packageName});
  try {
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      errorMsg =
          "Can't find an app in the Apple Store with the id: $packageName";
    } else {
      final jsonObj = jsonDecode(response.body);
      final List results = jsonObj['results'];
      if (results.isEmpty) {
        errorMsg =
            "Can't find an app in the Apple Store with the id: $packageName";
      } else {
        newVersion = jsonObj['results'][0]['version'];
        url = jsonObj['results'][0]['trackViewUrl'];
      }
    }
  } catch (e) {
    errorMsg = "$e";
  }
  return AppCheckerResult(
    currentVersion,
    newVersion,
    url,
    errorMsg,
    isDisplayAd,
  );
}

class AppCheckerResult {
  final String currentVersion;
  final String? newVersion;
  final String? appURL;
  final String? errorMessage;
  final bool isDisplayAd;

  AppCheckerResult(
    this.currentVersion,
    this.newVersion,
    this.appURL,
    this.errorMessage,
    this.isDisplayAd,
  );

  bool get canUpdate =>
      _shouldUpdate(currentVersion, (newVersion ?? currentVersion));

  bool _shouldUpdate(String versionA, String versionB) {
    final versionNumbersA =
        versionA.split(".").map((e) => int.tryParse(e) ?? 0).toList();
    final versionNumbersB =
        versionB.split(".").map((e) => int.tryParse(e) ?? 0).toList();

    final int versionASize = versionNumbersA.length;
    final int versionBSize = versionNumbersB.length;
    int maxSize = math.max(versionASize, versionBSize);

    for (int i = 0; i < maxSize; i++) {
      if ((i < versionASize ? versionNumbersA[i] : 0) >
          (i < versionBSize ? versionNumbersB[i] : 0)) {
        return false;
      } else if ((i < versionASize ? versionNumbersA[i] : 0) <
          (i < versionBSize ? versionNumbersB[i] : 0)) {
        return true;
      }
    }
    return false;
  }
}
