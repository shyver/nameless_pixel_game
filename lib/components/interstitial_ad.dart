import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdManager {
  InterstitialAd? _interstitialAd;
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-8691251335190541/7365796576'
      : 'ca-app-pub-3940256099942544/4411468910';
  bool isAdLoaded = false;
  int playing = 0;
  void loadAd() {
    InterstitialAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            isAdLoaded = true;
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            isAdLoaded = false;
          },
        ));
  }

  void showAd() async {
    if (isAdLoaded) {
      playing = 1;
      await _interstitialAd!.show();
      isAdLoaded = false;
      playing = 2;
    }
  }
}
