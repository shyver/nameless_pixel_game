import 'package:flutter/material.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

class LevelSelector extends StatelessWidget {
  final PixelAdventure game;
  LevelSelector({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: game.size.x,
      height: game.size.y,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          width: game.size.x,
          height: 50,
          alignment: Alignment.topLeft,
          child: TextButton(
            onPressed: () {
              game.overlays.remove('LevelSelector');
              game.overlays.add('PauseMenu');
            },
            child: RawImage(
              image: game.images.fromCache('Menu/Buttons/Back.png'),
            ),
          ),
        ),
        const Text(
          'SELECT A LEVEL',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'PixelFont',
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: game.levelNames
              .map((e) => Container(
                    width: 100,
                    height: 100,
                    child: TextButton(
                        onPressed: () {
                          game.overlays.remove('LevelSelector');
                          game.currentLevelIndex = game.levelNames.indexOf(e);
                          game.reloadLevel();
                          game.resumeEngine();
                        },
                        child: RawImage(
                          image: game.images.fromCache(
                              'Menu/Levels/0${game.levelNames.indexOf(e) + 1}.png'),
                        )),
                  ))
              .toList(),
        ),
        const SizedBox()
      ]),
    );
    // TODO: implement build
  }
}
