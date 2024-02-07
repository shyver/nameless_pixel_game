import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/src/game/overlay_manager.dart';
import 'package:flame/text.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pixel_adventure/components/fruit.dart';
import 'package:pixel_adventure/components/hearts.dart';
import 'package:pixel_adventure/components/interstitial_ad.dart';
import 'package:pixel_adventure/components/jump_button.dart';
import 'package:pixel_adventure/components/pause_button.dart';
import 'package:pixel_adventure/components/player.dart';
import 'dart:async';
import 'dart:ui';

import 'package:pixel_adventure/components/level.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PixelAdventure extends FlameGame
    with
        HasKeyboardHandlerComponents,
        DragCallbacks,
        TapCallbacks,
        HasCollisionDetection {
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late SharedPreferences prefs;
  late CameraComponent cam;
  final mainMenuIdentifier = 'MainMenu';
  final skinPrices = [0, 79, 129, 249];

  late Player player;
  late JoystickComponent joystick;
  late PauseButton pauseButton;
  late Level world1;
  late TextComponent fruitCountText;
  int fruitcount = 0;
  late String? character;
  late int? totalFruitCount;
  late int? openLevels;
  late List<String>? openSkins;
  late bool? enableMusic;

  bool playSounds = true;
  double soundVolume = 1.0;
  int heartCount = 3;
  InterstitialAdManager interstitialAdManager = InterstitialAdManager();

  List<Heart> hearts = [];
  List<String> levelNames = [
    'level_11',
    'level_12',
    'level_09',
    'level_10',
    'level_04',
    'level_02',
    'level_05',
    'level_03',
    'level_01',
    'level_06',
    'level_07',
  ];
  late int? currentLevelIndex;
  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();
    prefs = await SharedPreferences.getInstance();
    totalFruitCount = prefs.getInt('totalFruitCount');
    if (totalFruitCount == null) {
      await prefs.setInt('totalFruitCount', 0);
      totalFruitCount = 0;
    }
    openLevels = prefs.getInt('OpenLevels');
    if (openLevels == null) {
      await prefs.setInt('OpenLevels', 1);
      openLevels = 1;
    }
    character = prefs.getString('Character');
    if (character == null) {
      await prefs.setString('Character', 'Mask Dude');
      character = 'Mask Dude';
    }
    currentLevelIndex = prefs.getInt('CurrentLevelIndex');
    if (currentLevelIndex == null) {
      await prefs.setInt('CurrentLevelIndex', 0);
      currentLevelIndex = 0;
    }
    openSkins = prefs.getStringList('OpenSkins');
    if (openSkins == null) {
      await prefs.setStringList('OpenSkins', ['Mask Dude']);
      openSkins = ['Mask Dude'];
    }
    enableMusic = prefs.getBool('EnableMusic');
    if (enableMusic == null) {
      await prefs.setBool('EnableMusic', true);
      enableMusic = true;
    }
    interstitialAdManager.loadAd();
    player = Player(character: (character ?? 'Mask Dude'));
    _loadLevel();
    addJoystick();
    updateHearts();
    addFruits();
    add(JumpButton());
    FlameAudio.loopLongAudio('background.mp3', volume: soundVolume);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    updateJoystick();
    if (!enableMusic!) {
      FlameAudio.audioCache.clear('background.mp3');
    }
    // TODO: implement update
    super.update(dt);
  }

  void changeCharacter(String newCharacter) {
    character = newCharacter;
    world1.remove(player);
    player = Player(
        character: (character ?? 'Mask Dude'),
        position: world1.startingPosition);
    world1.add(player);
    prefs.setString('Character', newCharacter);
  }

  void updateHearts() {
    // Step 2
    hearts.forEach((heart) {
      remove(heart); // remove heart from the game
    });
    hearts.clear(); // clear the list of hearts

    for (var i = 0; i < heartCount; i++) {
      Heart heart = Heart(position: Vector2(size.x - 40 - i * 40, 10));
      hearts.add(heart);
      add(heart); // add heart to the game
    }
    if (heartCount == 0) {
      Future.delayed(const Duration(milliseconds: 400), () {
        overlays.add('GameOver');
        fruitcount = 0;
        updateFruitCount();
      });
    }
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
    interstitialAdManager.loadAd();
    if ((currentLevelIndex ?? 0) < levelNames.length - 1) {
      currentLevelIndex = (currentLevelIndex ?? 0) + 1;
      prefs.setInt('CurrentLevelIndex', currentLevelIndex ?? 0);
      world1.remove(player);
      remove(cam);
      remove(world1);

      _loadLevel();
    } else {
      currentLevelIndex = 0;
      prefs.setInt('CurrentLevelIndex', 0);
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
    fruitcount = 0;
    updateFruitCount();
    _loadLevel();
  }

  void _loadLevel() {
    Future.delayed(const Duration(microseconds: 100), () {
      world1 = Level(
        player: player,
        levelName: levelNames[(currentLevelIndex ?? 0)],
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

  void addFruits() {
    // Load the fruit image from cache
    SpriteComponent fruitImage = SpriteComponent(
      priority: 10,
      sprite: Sprite(images.fromCache('HUD/Fruits.png')),
      size: Vector2(64, 64), // adjust the size as needed
      position: Vector2(size.x - 100, 40), // adjust the position as needed
    );
    // Create a text component to display the fruit count
    fruitCountText = TextComponent(
        priority: 11,
        text: 'x$fruitcount',
        position: Vector2(size.x - 48, 60), // adjust the position as needed
        textRenderer: TextPaint(
            style: const TextStyle(
          fontFamily: 'Arcade',
          fontSize: 36,
        )));

    // Add the fruit image and count to the game
    add(fruitImage);
    add(fruitCountText);
  }

  updateFruitCount() {
    remove(fruitCountText);
    fruitCountText = TextComponent(
        priority: 11,
        text: 'x$fruitcount',
        position: Vector2(size.x - 48, 60), // adjust the position as needed
        textRenderer: TextPaint(
            style: const TextStyle(
          fontFamily: 'Arcade',
          fontSize: 36,
        )));
    add(fruitCountText);
  }
}
