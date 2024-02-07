import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

class PauseMenu extends StatelessWidget {
  final PixelAdventure game;
  PauseMenu({super.key, required this.game});

  static const blackColor = Color(0xFF000000);
  static const whiteColor = Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/Menu/MenuBackground.png'),
              fit: BoxFit.cover),
        ),
        width: game.size.x,
        height: game.size.y,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('Game paused',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'PixelFont')),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style:
                      TextButton.styleFrom(backgroundColor: Colors.transparent),
                  onPressed: () {
                    game.resumeEngine();
                    game.overlays.remove('PauseMenu');
                  },
                  child: RawImage(
                      width: 50,
                      height: 50,
                      image: game.images.fromCache('Menu/Buttons/Play.png')),
                ),
                TextButton(
                  onPressed: () {
                    game.pauseEngine();
                    game.reloadLevel();

                    game.overlays.remove('PauseMenu');
                    game.resumeEngine();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                  child: RawImage(
                      width: 50,
                      height: 50,
                      image: game.images.fromCache('Menu/Buttons/Restart.png')),
                ),
                TextButton(
                  onPressed: () {
                    game.overlays.add('LevelSelector');
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                  child: RawImage(
                      width: 50,
                      height: 50,
                      image: game.images.fromCache('Menu/Buttons/Levels.png')),
                ),
                TextButton(
                  onPressed: () {
                    game.overlays.remove('PauseMenu');
                    game.overlays.add('MainMenu');
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                  child: RawImage(
                      width: 50,
                      height: 50,
                      image: game.images.fromCache('Menu/Buttons/Menu.png')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
