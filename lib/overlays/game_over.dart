import 'package:flutter/material.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

class GameOver extends StatelessWidget {
  final PixelAdventure game;
  const GameOver({Key? key, required this.game}) : super(key: key);
  static const blackColor = Color(0xFF000000);
  static const whiteColor = Color(0xFFFFFFFF);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: game.size.x,
      height: game.size.y,
      color: Colors.black,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        const Text(
          'Game Over',
          style: TextStyle(
            fontFamily: 'pixelFont',
            fontSize: 24,
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextButton(
            onPressed: () {
              game.pauseEngine();
              game.reloadLevel();
              game.overlays.remove('GameOver');
              game.resumeEngine();
            },
            style: TextButton.styleFrom(
              backgroundColor: blackColor,
            ),
            child: RawImage(
                width: 50,
                height: 50,
                image: game.images.fromCache('Menu/Buttons/Restart.png')),
          ),
          TextButton(
            onPressed: () {
              game.overlays.remove('GameOver');
              game.overlays.add('LevelSelector');
            },
            style: TextButton.styleFrom(
              backgroundColor: blackColor,
            ),
            child: RawImage(
                width: 50,
                height: 50,
                image: game.images.fromCache('Menu/Buttons/Levels.png')),
          ),
          TextButton(
            onPressed: () {
              game.overlays.remove('GameOver');
              game.overlays.add('MainMenu');
              game.reloadLevel();
            },
            style: TextButton.styleFrom(
              backgroundColor: blackColor,
            ),
            child: RawImage(
                width: 50,
                height: 50,
                image: game.images.fromCache('Menu/Buttons/Menu.png')),
          ),
        ])
      ]),
    );
  }
}
