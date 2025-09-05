import 'package:flame/game.dart';
import 'package:flappy_birds/game/flappy_bird_game.dart';
import 'package:flappy_birds/screens/game_over.dart';
import 'package:flappy_birds/screens/menu.dart';
import 'package:flutter/material.dart';

void main() {
  final game = FlappyBirdGame();
  runApp(
    GameWidget(
      game: game,
      initialActiveOverlays: const [Menu.id],
      overlayBuilderMap: {
        'mainMenu': (context, _) => Menu(game: game),
        'gameOver': (context, _) => GameOver(game: game),
      },
    ),
  );
}
