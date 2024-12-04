import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:postervibe/core/app_export.dart';

class AdmobBannerSize {
  final int width, height;
  final String? name;

  static Future<InlineAdaptiveSize?> customPortraitAdaptiveBannerAdSize(
      BuildContext context,
      {double? customWidth}) async {
    double adWidth = customWidth ?? Get.width - (2 * 16);

    return AdSize.getPortraitInlineAdaptiveBannerAdSize(adWidth.truncate());
  }

  const AdmobBannerSize({
    required this.width,
    required this.height,
    this.name,
  });
}
