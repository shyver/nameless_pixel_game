import 'dart:async';

import 'package:flame/components.dart';
import 'package:peckpanic/pixel_adventure.dart';

class Heart extends SpriteComponent with HasGameRef<PixelAdventure> {
  Heart({super.position});

  @override
  FutureOr<void> onLoad() {
    priority = 15;
    sprite = Sprite(game.images.fromCache('HUD/heart.png'));
    size = Vector2(32, 32);
    return super.onLoad();
  }
}
