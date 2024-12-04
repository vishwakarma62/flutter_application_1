import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AdaptiveBannerAd extends StatefulWidget {
  final String adUnitId;
  final AdRequest? adRequest;
  final AdSize? adSize;
  final EdgeInsets padding;
  final Function()? onAdLoaded;
  final Function(LoadAdError error)? onAdFailedToLoad;
  final Function(Ad ad)? onAdClicked;
  final Function(Ad ad)? onAdClosed;
  final Function(Ad ad)? onAdImpression;
  final Function(Ad ad)? onAdOpened;
  final Function(Ad ad)? onAdWillDismissScreen;
  final Function(Ad, double, PrecisionType, String)? onPaidEvent;

  AdaptiveBannerAd({
    Key? key,
    required this.adUnitId,
    this.adRequest,
    this.adSize,
    this.padding = const EdgeInsets.all(16.0),
    this.onAdLoaded,
    this.onAdFailedToLoad,
    this.onAdClicked,
    this.onAdClosed,
    this.onAdImpression,
    this.onAdOpened,
    this.onAdWillDismissScreen,
    this.onPaidEvent,
  }) : super(key: key);

  @override
  State<AdaptiveBannerAd> createState() => _AdaptiveBannerAdState();
}

class _AdaptiveBannerAdState extends State<AdaptiveBannerAd> {
  BannerAd? _inlineAdaptiveAd;
  AdSize? _adSize;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  @override
  void didUpdateWidget(covariant AdaptiveBannerAd oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.adUnitId != oldWidget.adUnitId) {
      _inlineAdaptiveAd?.dispose();
      _loadAd();
    }
  }

  Future<void> _loadAd() async {
    _adSize = null;
    _inlineAdaptiveAd?.dispose();
    _inlineAdaptiveAd = BannerAd(
      adUnitId: widget.adUnitId,
      size: widget.adSize ?? AdSize.banner,
      request: widget.adRequest ?? const AdRequest(),
      listener: BannerAdListener(
        onAdClicked: widget.onAdClicked,
        onAdClosed: widget.onAdClosed,
        onAdImpression: widget.onAdImpression,
        onAdOpened: widget.onAdOpened,
        onAdWillDismissScreen: widget.onAdWillDismissScreen,
        onPaidEvent: widget.onPaidEvent,
        onAdLoaded: (Ad ad) async {
          BannerAd bannerAd = (ad as BannerAd);
          final AdSize? size = await bannerAd.getPlatformAdSize();
          if (size != null) {
            setState(() {
              _adSize = size;
            });
          }
          widget.onAdLoaded?.call();
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          _loadAd();
          widget.onAdFailedToLoad?.call(error);
        },
      ),
    );
    _inlineAdaptiveAd?.load();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: _buildAdWidget(),
    );
  }

  Widget _buildAdWidget() {
    if (_inlineAdaptiveAd == null || _adSize == null) {
      return _buildLoadingWidget();
    }

    return SizedBox(
      width: _inlineAdaptiveAd!.size.width.toDouble(),
      height: _adSize!.height.toDouble(),
      child: AdWidget(ad: _inlineAdaptiveAd!),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: LoadingAnimationWidget.horizontalRotatingDots(
        color: Colors.blue,
        size: 20,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _inlineAdaptiveAd?.dispose();
  }
}
