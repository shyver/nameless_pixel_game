import 'dart:async';

import 'package:flame/components.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

class Heart extends SpriteComponent with HasGameRef<PixelAdventure> {
  Heart({super.position});

  @override
  FutureOr<void> onLoad() {
    priority = 15;
    sprite = Sprite(game.images.fromCache('HUD/heart.png'));
    size = Vector2(32, 32);
    // TODO: implement onLoad
    return super.onLoad();
  }
}
