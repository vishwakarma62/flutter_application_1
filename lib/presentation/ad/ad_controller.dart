
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdController {
  loadInterstitial({
    required Function(InterstitialAd) onAdLoaded,
    required Function(InterstitialAd) onAdDismissedFullScreenContent,
    required Function(InterstitialAd, AdError)
        onAdFailedToShowFullScreenContent,
    required Function(AdError) onAdFailedToLoad,
    required String adUnitId,
    required bool nonPersonalizedAds,
  }) {
    InterstitialAd.load(
      adUnitId: adUnitId,
      request: AdRequest(nonPersonalizedAds: nonPersonalizedAds),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          onAdLoaded(ad);
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: onAdDismissedFullScreenContent,
            onAdFailedToShowFullScreenContent:
                onAdFailedToShowFullScreenContent,
          );
        },
        onAdFailedToLoad: onAdFailedToLoad,
      ),
    );
  }

}
