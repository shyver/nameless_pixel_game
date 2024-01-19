import 'package:flutter/material.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

class SkinSelector extends StatelessWidget {
  final PixelAdventure game;
  static const skinNames = [
    'Mask Dude',
    'Ninja Frog',
    'Pink Man',
    'Virtual Guy'
  ];
  SkinSelector({Key? key, required this.game}) : super(key: key);

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
          height: 70,
          alignment: Alignment.topLeft,
          child: TextButton(
            onPressed: () {
              game.overlays.remove('SkinSelector');
              game.overlays.add('MainMenu');
            },
            child: RawImage(
              image: game.images.fromCache('Menu/Buttons/Back.png'),
            ),
          ),
        ),
        const Text(
          'SKIN SELECTOR',
          style: TextStyle(
            fontFamily: 'PixelFont',
            fontSize: 24,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: skinNames
              .map((e) => TextButton(
                  onPressed: () => {},
                  child: RawImage(
                    image: game.images
                        .fromCache('Main Characters/$e/Jump (32x32).png'),
                  )))
              .toList(),
        ),
        const SizedBox()
      ]),
    );
  }
}
