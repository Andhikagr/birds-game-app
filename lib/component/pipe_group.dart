import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappy_birds/component/pipe.dart';
import 'package:flappy_birds/game/assets.dart';
import 'package:flappy_birds/game/configuration.dart';
import 'package:flappy_birds/game/flappy_bird_game.dart';
import 'package:flappy_birds/game/pipe_position.dart';

class PipeGroup extends PositionComponent
    with HasGameReference<FlappyBirdGame> {
  PipeGroup();

  final _random = Random();
  bool _scored = false;

  @override
  Future<void> onLoad() async {
    position.x = game.size.x;

    final heightMinusBase = game.size.y - Configuration.baseHeight;
    final spacing = 120 + _random.nextDouble() * (heightMinusBase / 4);
    final centerY =
        spacing + _random.nextDouble() * (heightMinusBase - spacing);

    addAll([
      Pipe(pipePosition: PipePosition.top, height: centerY - spacing / 2),
      Pipe(
        pipePosition: PipePosition.bottom,
        height: heightMinusBase - (centerY + spacing / 2),
      ),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= Configuration.gameSpeed * dt;
    if (game.isHit) return;

    final topPipe = children.whereType<Pipe>().first;

    if (!_scored && (position.x + topPipe.x + topPipe.width) < game.bird.x) {
      game.bird.score += 1;
      _scored = true;
      FlameAudio.play(Assets.point);
    }
  }
}
