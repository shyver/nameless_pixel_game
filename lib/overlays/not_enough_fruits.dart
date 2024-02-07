import 'package:flutter/material.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

class NotEnoughFruits extends StatelessWidget {
  final PixelAdventure game;
  const NotEnoughFruits({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        game.overlays.remove('NotEnoughFruits');
      },
      child: Container(
        height: game.size.y,
        width: game.size.x,
        margin: const EdgeInsets.all(120),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/HUD/fruitshud.png'),
                fit: BoxFit.contain),
          ),
          child: Text('Not enough fruits!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Arcade',
              )),
        ),
      ),
    );
  }
}
