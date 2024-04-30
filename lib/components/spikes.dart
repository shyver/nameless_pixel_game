import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:peckpanic/pixel_adventure.dart';

class Spikes extends SpriteAnimationComponent with HasGameRef<PixelAdventure> {
  final String stuckTo;
  Spikes({super.position, super.size, this.stuckTo = 'ground'});

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox(
        position: Vector2(0, size.y / 2), size: Vector2(size.x, size.y / 2)));
    anchor = Anchor.center;
    center = position + size / 2;
    angle = stuckTo == 'Ground'
        ? 0
        : stuckTo == 'Top'
            ? pi
            : stuckTo == 'Left'
                ? pi / 2
                : -pi / 2;
    animation = SpriteAnimation.fromFrameData(
        game.images.fromCache('Traps/Spikes/Idle.png'),
        SpriteAnimationData.sequenced(
            amount: 1, stepTime: 0.05, textureSize: Vector2.all(16)));

    return super.onLoad();
  }
}
