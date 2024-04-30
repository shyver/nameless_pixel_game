import 'package:flutter/material.dart';
import 'package:peckpanic/pixel_adventure.dart';

class About extends StatelessWidget {
  final PixelAdventure game;
  const About({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: game.size.x,
      height: game.size.y,
      color: const Color(0xFF211F30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: game.size.x,
            height: 50,
            alignment: Alignment.topLeft,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () {
                  game.overlays.remove('About');
                },
                child: const Image(
                    image: AssetImage('assets/images/Menu/Buttons/Back.png'))),
          ),
          const Text(
            'Peck Panic!',
            style: TextStyle(
              color: Color(0xFFE2E2E2),
              fontSize: 80,
              fontFamily: 'arcade',
            ),
          ),
          const Text(
            'Version 1.0.0',
            style: TextStyle(
              color: Color(0xFFE2E2E2),
              fontSize: 20,
            ),
          ),
          const Text(
            'Developed by Abdelwahed @ SpiceDEV',
            style: TextStyle(
              color: Color(0xFFE2E2E2),
              fontSize: 20,
            ),
          ),
          const Text(
            'Graphics by Pixel Frog',
            style: TextStyle(
              color: Color(0xFFE2E2E2),
              fontSize: 20,
            ),
          ),
          const Text(
            'Powered by Flame Engine',
            style: TextStyle(
              color: Color(0xFFE2E2E2),
              fontSize: 20,
            ),
          ),
          const Text(
              'This is the first version of the game, you can consider it as a beta version. We are working on adding more levels and features. Stay tuned!',
              style: TextStyle(
                color: Color(0xFFE2E2E2),
                fontSize: 20,
              ),
              textAlign: TextAlign.center),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
