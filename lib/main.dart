import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/overlays/level_selector.dart';
import 'package:pixel_adventure/overlays/main_menu.dart';
import 'package:pixel_adventure/overlays/pause_menu.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      }
    },
    initialActiveOverlays: const ['MainMenu'],
  ));
}
