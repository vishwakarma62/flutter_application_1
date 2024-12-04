import 'dart:io';

import 'package:postervibe/core/utils/app_config.dart';
import 'package:postervibe/presentation/ad/ad_type.dart';

class AdUnitIds {
  static String getTestAdUnitId({
    required AdType adType,
  }) {
    if (Platform.isAndroid) {
      switch (adType) {
        case AdType.interstitial:
          return AppConfig.androidInterstitialAdUnitId;
        case AdType.banner:
          return AppConfig.androidBannerAdUnitId;
      }
    } else if (Platform.isIOS) {
      switch (adType) {
        case AdType.interstitial:
          return AppConfig.iosInterstitialAdUnitId;
        case AdType.banner:
          return AppConfig.iosBannerAdUnitId;
      }
    }
    throw UnsupportedError('Unsupported platform or ad type');
  }

}
