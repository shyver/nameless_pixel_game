import 'dart:ffi';

import 'package:flame/sprite.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/components/fruits_hud.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

class SkinSelector extends StatelessWidget {
  final PixelAdventure game;
  static const skinNames = [
    'Mask Dude',
    'Virtual Guy',
    'Pink Man',
    'Ninja Frog',
  ];
  SkinSelector({Key? key, required this.game}) : super(key: key);

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
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
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
              FruitsHUD(game: game)
            ],
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
                    onPressed: () {
                      if ((game.openSkins ?? []).contains(e)) {
                        game.changeCharacter(e);
                        game.overlays.remove('SkinSelector');
                        game.overlays.add('MainMenu');
                      } else {
                        if ((game.totalFruitCount ?? 0) >=
                            game.skinPrices[skinNames.indexOf(e)]) {
                          game.totalFruitCount = (game.totalFruitCount ?? 0) -
                              game.skinPrices[skinNames.indexOf(e)];
                          game.openSkins?.add(e);
                          game.prefs
                              .setStringList('OpenSkins', game.openSkins!);
                          game.prefs
                              .setInt('totalFruitCount', game.totalFruitCount!);
                          game.changeCharacter(e);
                          game.overlays.remove('SkinSelector');
                          game.overlays.add('MainMenu');
                        } else {
                          game.overlays.add('NotEnoughFruits');
                        }
                      }
                    },
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.only(bottom: 0, top: 10),
                      width: 100,
                      height: 108,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage(
                                  'assets/images/Main Characters/$e/${(game.openSkins ?? []).contains(e) ? 'store' : 'store_locked'}.png'))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 9,
                          ),
                          Text(
                            (game.openSkins ?? []).contains(e)
                                ? ''
                                : game.skinPrices[skinNames.indexOf(e)]
                                    .toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'arcade',
                                fontSize: 24),
                          ),
                          (game.openSkins ?? []).contains(e)
                              ? SizedBox()
                              : RawImage(
                                  fit: BoxFit.fitHeight,
                                  height: 20,
                                  image:
                                      game.images.fromCache('HUD/Fruits.png'),
                                ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
        const SizedBox()
      ]),
    );
  }
}
