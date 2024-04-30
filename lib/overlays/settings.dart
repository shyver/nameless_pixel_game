import 'package:flutter/material.dart';
import 'package:peckpanic/pixel_adventure.dart';

class SettingsMenu extends StatelessWidget {
  final PixelAdventure game;
  const SettingsMenu({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: game.size.x,
      height: game.size.y,
      color: Colors.black,
      child: Column(children: [
        Container(
          width: game.size.x,
          height: 50,
          alignment: Alignment.topLeft,
          child: TextButton(
            onPressed: () {
              game.overlays.remove('Settings');
              game.overlays.add('MainMenu');
            },
            child: RawImage(
              image: game.images.fromCache('Menu/Buttons/Back.png'),
            ),
          ),
        ),
        const Text('Settings')
      ]),
    );
  }
}
