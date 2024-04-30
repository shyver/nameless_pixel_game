import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:peckpanic/pixel_adventure.dart';

class PauseButton extends SpriteComponent
    with TapCallbacks, HasGameRef<PixelAdventure> {
  @override
  FutureOr<void> onLoad() {
    priority = 1;
    sprite = Sprite(game.images.fromCache('HUD/pause.png'));
    position = Vector2(10, 10);
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    game.pauseEngine();
    game.overlays.add('PauseMenu');
    super.onTapUp(event);
  }
}
