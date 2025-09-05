import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_birds/component/background.dart';
import 'package:flappy_birds/component/bird.dart';
import 'package:flappy_birds/component/base.dart';
import 'package:flappy_birds/component/pipe_group.dart';
import 'package:flappy_birds/game/configuration.dart';
import 'package:flame/components.dart';
import 'package:flutter/rendering.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  FlappyBirdGame();

  late Bird bird;
  Timer interval = Timer(Configuration.pipeInterval, repeat: true);
  bool isHit = false;
  late TextComponent score;

  @override
  Future<void> onLoad() async {
    addAll([
      Background(),
      Base(),
      bird = Bird(),
      PipeGroup(),
      score = buildScore(),
    ]);
    interval.onTick = () => add(PipeGroup());
  }

  TextComponent buildScore() {
    return TextComponent(
      text: 'Score: 0',
      position: Vector2(size.x / 2, size.y / 2 * 0.2),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          fontFamily: 'Game',
        ),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);
    score.text = 'score: ${bird.score}';
  }

  @override
  void onTap() {
    super.onTap();
    bird.fly();
  }
}
