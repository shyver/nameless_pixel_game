import 'package:flutter/material.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

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
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 70,
                padding: EdgeInsets.only(top: 5),
                alignment: AlignmentDirectional.bottomCenter,
                child: Image(
                  image: AssetImage('assets/images/HUD/Fruits.png'),
                  width: 50,
                  height: 50,
                )),
            Text(
              game.totalFruitCount.toString(),
              style: TextStyle(
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
