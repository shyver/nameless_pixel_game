import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:peckpanic/overlays/about.dart';
import 'package:peckpanic/overlays/game_over.dart';
import 'package:peckpanic/overlays/level_selector.dart';
import 'package:peckpanic/overlays/main_menu.dart';
import 'package:peckpanic/overlays/not_enough_fruits.dart';
import 'package:peckpanic/overlays/pause_menu.dart';
import 'package:peckpanic/overlays/settings.dart';
import 'package:peckpanic/overlays/skin_selector.dart';
import 'package:peckpanic/overlays/won.dart';
import 'package:peckpanic/pixel_adventure.dart';
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
      'About': (BuildContext context, PixelAdventure game) {
        return About(game: game);
      },
    },
    initialActiveOverlays: const ['MainMenu'],
  ));
}
