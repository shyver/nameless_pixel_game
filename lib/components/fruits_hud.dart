import 'package:flutter/material.dart';
import 'package:peckpanic/pixel_adventure.dart';

class FruitsHUD extends StatelessWidget {
  final PixelAdventure game;
  const FruitsHUD({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 57,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/HUD/fruitshud.png'),
            fit: BoxFit.contain),
      ),
      child: Container(
        padding: const  EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 70,
                padding: const EdgeInsets.only(top: 5),
                alignment: AlignmentDirectional.bottomCenter,
                child: const Image(
                  image: AssetImage('assets/images/HUD/Fruits.png'),
                  width: 50,
                  height: 50,
                )),
            Text(
              game.totalFruitCount.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 42,
                fontWeight: FontWeight.bold,
                fontFamily: 'Arcade',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
