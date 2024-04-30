import 'package:flutter/material.dart';
import 'package:peckpanic/pixel_adventure.dart';

class LevelSelector extends StatelessWidget {
  final PixelAdventure game;
  const LevelSelector({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/Menu/MenuBackground.png'),
            fit: BoxFit.cover),
      ),
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
        Wrap(
          spacing: 8.0, // gap between adjacent chips
          runSpacing: 4.0, // gap between lines
          direction: Axis.horizontal,
          children: game.levelNames.map((e) {
            late String nameIndex;
            final levelIndex = game.levelNames.indexOf(e) + 1;
            if (levelIndex < 10) {
              nameIndex = '0$levelIndex';
            } else {
              nameIndex = '$levelIndex';
            }
            return SizedBox(
              width: 100,
              height: 100,
              child: TextButton(
                  onPressed: () {
                    if (game.levelNames.indexOf(e) < (game.openLevels ?? 1)) {
                      game.overlays.remove('LevelSelector');
                      game.currentLevelIndex = game.levelNames.indexOf(e);
                      game.reloadLevel();
                      game.resumeEngine();
                    }
                  },
                  child: RawImage(
                    image: game.images.fromCache(
                        'Menu/Levels/${game.levelNames.indexOf(e) < (game.openLevels ?? 1) ? nameIndex : '${nameIndex}_inactive'}.png'),
                  )),
            );
          }).toList(),
        ),
        const SizedBox()
      ]),
    );
    
  }
}
