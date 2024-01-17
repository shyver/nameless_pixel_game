import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../pixel_adventure.dart';

class MainMenu extends StatelessWidget {
  // Reference to parent game.
  final PixelAdventure game;

  MainMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    const blackTextColor = Color.fromRGBO(0, 0, 0, 1.0);
    const whiteTextColor = Color.fromRGBO(255, 255, 255, 1.0);

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: game.size.y,
          width: game.size.x,
          decoration: const BoxDecoration(
            color: blackTextColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Pixel Adventure',
                style: TextStyle(
                    color: whiteTextColor,
                    fontSize: 24,
                    fontFamily: 'PixelFont'),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 200,
                height: 75,
                child: TextButton(
                  onPressed: () {
                    game.overlays.remove('MainMenu');
                    game.resumeEngine();
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: blackTextColor,
                      shape: const StadiumBorder(
                          side: BorderSide(color: whiteTextColor, width: 2.0))),
                  child: const Text(
                    'Play',
                    style: TextStyle(
                        fontSize: 30.0,
                        color: whiteTextColor,
                        fontFamily: 'PixelFont'),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
