import 'package:flappy_birds/game/assets.dart';
import 'package:flappy_birds/game/flappy_bird_game.dart';
import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  final FlappyBirdGame game;
  static const String id = 'gameOver';

  const GameOver({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();

    return Material(
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(Assets.gameOver),
            SizedBox(height: 40),
            Text(
              "Your Score: ${game.bird.score}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: Colors.white,
                fontFamily: 'Game',
                shadows: [Shadow(color: Colors.orange, offset: Offset(2, 3))],
              ),
            ),
            SizedBox(height: 80),
            GestureDetector(
              onTap: onRestart,
              child: Image.asset('assets/images/button.png', width: 180),
            ),
          ],
        ),
      ),
    );
  }

  void onRestart() {
    game.bird.reset();
    game.overlays.remove('gameOver');
    game.resumeEngine();
  }
}
