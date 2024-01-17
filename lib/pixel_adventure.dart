import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/src/game/overlay_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:pixel_adventure/components/jump_button.dart';
import 'package:pixel_adventure/components/pause_button.dart';
import 'package:pixel_adventure/components/player.dart';
import 'dart:async';
import 'dart:ui';

import 'package:pixel_adventure/components/level.dart';

class PixelAdventure extends FlameGame
    with
        HasKeyboardHandlerComponents,
        DragCallbacks,
        TapCallbacks,
        HasCollisionDetection {
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late CameraComponent cam;
  final mainMenuIdentifier = 'MainMenu';
  Player player = Player(character: 'Virtual Guy');
  late JoystickComponent joystick;
  late PauseButton pauseButton;
  late Level world1;
  bool playSounds = true;
  double soundVolume = 1.0;
  List<String> levelNames = ['level_02', 'level_01'];
  int currentLevelIndex = 0;
  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    _loadLevel();
    addJoystick();
    add(JumpButton());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    updateJoystick();
    // TODO: implement update
    super.update(dt);
  }

  JoystickComponent addJoystick() {
    joystick = JoystickComponent(
        priority: 1,
        knob: SpriteComponent(
          sprite: Sprite(images.fromCache('HUD/knob.png')),
        ),
        background: SpriteComponent(
          sprite: Sprite(images.fromCache('HUD/Joystick.png')),
        ),
        margin: const EdgeInsets.only(left: 10, bottom: 10),
        anchor: Anchor.bottomLeft);
    add(joystick);
    return joystick;
  }

  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.downLeft:
      case JoystickDirection.upLeft:
        player.horizontalMovement = -1;
        break;
      case JoystickDirection.right:
      case JoystickDirection.downRight:
      case JoystickDirection.upRight:
        player.horizontalMovement = 1;
        break;
      default:
        player.horizontalMovement = 0;
        break;
    }
  }

  void loadNextLevel() {
    if (currentLevelIndex < levelNames.length - 1) {
      currentLevelIndex++;
      world1.remove(player);
      remove(cam);
      remove(world1);

      _loadLevel();
    } else {
      currentLevelIndex = 0;
      world1.remove(player);
      remove(cam);
      remove(world1);
      _loadLevel();
      //no more levels
    }
  }

  void reloadLevel() {
    world1.remove(player);
    remove(cam);
    remove(world1);
    _loadLevel();
  }

  void _loadLevel() {
    Future.delayed(const Duration(seconds: 1), () {
      world1 = Level(
        player: player,
        levelName: levelNames[currentLevelIndex],
      );
      cam = CameraComponent.withFixedResolution(
          world: world1,
          width: 640,
          height: 360,
          hudComponents: [addPauseButton()]);
      cam.viewfinder.anchor = Anchor.topLeft;
      cam.priority = 0;

      addAll([cam, world1]);
    });
  }

  PauseButton addPauseButton() {
    return pauseButton = PauseButton();
  }
}
