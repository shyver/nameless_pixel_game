import 'package:flutter/material.dart';
import 'package:peckpanic/components/fruits_hud.dart';

import '../pixel_adventure.dart';

class MainMenu extends StatelessWidget {
  // Reference to parent game.
  final PixelAdventure game;

  const MainMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    const whiteTextColor = Color.fromRGBO(255, 255, 255, 1.0);

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/Menu/MenuBackground.png'),
                fit: BoxFit.cover),
          ),
          padding: const EdgeInsets.all(10.0),
          height: game.size.y,
          width: game.size.x,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: game.size.x,
                alignment: Alignment.topRight,
                child: FruitsHUD(game: game),
              ),
              const Text(
                'PECK PANIC!',
                style: TextStyle(
                    color: whiteTextColor,
                    fontSize: 24,
                    fontFamily: 'PixelFont'),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      game.overlays.remove('MainMenu');
                      game.overlays.add('SkinSelector');
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                    ),
                    child: RawImage(
                      image: game.images.fromCache('Menu/Buttons/skin.png'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      game.reloadLevel();
                      game.resumeEngine();
                      game.overlays.remove('MainMenu');
                      if (!game.interstitialAdManager.isAdLoaded) {
                        game.interstitialAdManager.loadAd();
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                    ),
                    child: RawImage(
                      image: game.images.fromCache('Menu/Buttons/Play.png'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // game.overlays.remove('MainMenu');
                      game.overlays.add('LevelSelector');
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                    ),
                    child: RawImage(
                      image: game.images.fromCache('Menu/Buttons/Levels.png'),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () {
                    game.overlays.add('About');
                  },
                  child: const Text('About Us',
                      style: TextStyle(
                          color: whiteTextColor,
                          fontSize: 30,
                          fontFamily: 'arcade'))),
            ],
          ),
        ),
      ),
    );
  }
}
