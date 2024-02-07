import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/overlays/game_over.dart';
import 'package:pixel_adventure/overlays/level_selector.dart';
import 'package:pixel_adventure/overlays/main_menu.dart';
import 'package:pixel_adventure/overlays/not_enough_fruits.dart';
import 'package:pixel_adventure/overlays/pause_menu.dart';
import 'package:pixel_adventure/overlays/settings.dart';
import 'package:pixel_adventure/overlays/skin_selector.dart';
import 'package:pixel_adventure/overlays/won.dart';
import 'package:pixel_adventure/pixel_adventure.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  PixelAdventure game = PixelAdventure();
  runApp(GameWidget(
    game: kDebugMode ? PixelAdventure() : game,
    overlayBuilderMap: {
      'MainMenu': (BuildContext context, PixelAdventure game) {
        return MainMenu(game: game);
      },
      'PauseMenu': (BuildContext context, PixelAdventure game) {
        return PauseMenu(game: game);
      },
      'LevelSelector': (BuildContext context, PixelAdventure game) {
        return LevelSelector(game: game);
      },
      'GameOver': (BuildContext context, PixelAdventure game) {
        return GameOver(game: game);
      },
      'Settings': (BuildContext context, PixelAdventure game) {
        return SettingsMenu(game: game);
      },
      'SkinSelector': (BuildContext context, PixelAdventure game) {
        return SkinSelector(game: game);
      },
      'Won': (BuildContext context, PixelAdventure game) {
        return Won(game: game);
      },
      'NotEnoughFruits': (BuildContext context, PixelAdventure game) {
        return NotEnoughFruits(game: game);
      },
    },
    initialActiveOverlays: const ['MainMenu'],
  ));
}
