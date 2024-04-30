import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:peckpanic/pixel_adventure.dart';

class Won extends StatelessWidget {
  final PixelAdventure game;
  const Won({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: game.size.x,
      height: game.size.y,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/Menu/MenuBackground.png'),
            fit: BoxFit.cover),
      ),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        const Text('YOU WON!',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontFamily: 'PixelFont')),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                game.loadNextLevel();
                game.interstitialAdManager.showAd();
                game.overlays.remove('Won');
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
              ),
              child: RawImage(
                  width: 50,
                  height: 50,
                  image: game.images.fromCache('Menu/Buttons/Next.png')),
            ),
            TextButton(
              onPressed: () {
                game.overlays.remove('Won');
                game.reloadLevel();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
              ),
              child: RawImage(
                  width: 50,
                  height: 50,
                  image: game.images.fromCache('Menu/Buttons/Restart.png')),
            ),
            TextButton(
              onPressed: () {
                game.overlays.remove('Won');
                game.overlays.add('MainMenu');
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
              ),
              child: RawImage(
                  width: 50,
                  height: 50,
                  image: game.images.fromCache('Menu/Buttons/Menu.png')),
            ),
          ],
        ),
      ]),
    );
  }
}
