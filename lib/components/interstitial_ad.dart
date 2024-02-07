import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdManager {
  InterstitialAd? _interstitialAd;
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-8686777117848080/7339046308'
      : 'ca-app-pub-3940256099942544/4411468910';
  bool isAdLoaded = false;
  void loadAd() {
    InterstitialAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            print('InterstitialAd loaded.');
            isAdLoaded = true;
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
  }

  void showAd() async {
    if (isAdLoaded) {
      await _interstitialAd!.show();
      isAdLoaded = false;
    }
  }
}
