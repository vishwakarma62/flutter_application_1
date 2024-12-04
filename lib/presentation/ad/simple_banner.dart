import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:postervibe/core/app_export.dart';

class AdmobBanner extends StatefulWidget {
  final String adUnitId;
  final AdSize adSize;
  final bool nonPersonalizedAds;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Function()? onAdLoaded;
  final Function(LoadAdError error)? onAdFailedToLoad;
  final Function(Ad ad)? onAdClicked;
  final Function(Ad ad)? onAdClosed;
  final Function(Ad ad)? onAdImpression;
  final Function(Ad ad)? onAdOpened;
  final Function(Ad ad)? onAdWillDismissScreen;
  final Function(Ad, double, PrecisionType, String)? onPaidEvent;

  AdmobBanner({
    Key? key,
    required this.adUnitId,
    required this.adSize,
    this.nonPersonalizedAds = false,
    this.backgroundColor,
    this.borderRadius,
    this.onAdClicked,
    this.onAdClosed,
    this.onAdFailedToLoad,
    this.onAdImpression,
    this.onAdLoaded,
    this.onAdOpened,
    this.onAdWillDismissScreen,
    this.onPaidEvent,
  }) : super(key: key);

  @override
  _AdmobBannerState createState() => _AdmobBannerState();
}

class _AdmobBannerState extends State<AdmobBanner>
    with AutomaticKeepAliveClientMixin {
  late BannerAd _bannerAd;
  bool hasLoaded = false;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      size: widget.adSize,
      adUnitId: widget.adUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          widget.onAdLoaded;
          setState(() {
            hasLoaded = true;
          });
        },
        onAdClicked: widget.onAdClicked,
        onAdClosed: widget.onAdClosed,
        onAdImpression: widget.onAdImpression,
        onAdOpened: widget.onAdOpened,
        onAdWillDismissScreen: widget.onAdWillDismissScreen,
        onPaidEvent: widget.onPaidEvent,
        onAdFailedToLoad: (ad, error) {
          widget.onAdFailedToLoad;
          setState(() {
            hasLoaded = false;
          });
        },
      ),
      request: AdRequest(
        nonPersonalizedAds: widget.nonPersonalizedAds,
      ),
    );
    _loadAd();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  void _loadAd() {
    _bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: widget.backgroundColor ?? Colors.transparent,
      child: FutureBuilder(
        future: _bannerAd.load(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text('Error loading ad: ${snapshot.error}');
            } else {
              final size = Get.size;
              final height = max(size.height * .05, 50.0);
              if (hasLoaded) {
                return Container(
                  width: size.width,
                  height: height,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: ClipRRect(
                    borderRadius: widget.borderRadius ?? BorderRadius.zero,
                    child: AdWidget(ad: _bannerAd),
                  ),
                );
              }
            }
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
