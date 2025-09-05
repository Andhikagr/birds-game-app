import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flappy_birds/component/pipe_group.dart';
import 'package:flappy_birds/game/assets.dart';
import 'package:flappy_birds/game/bird_move.dart';
import 'package:flappy_birds/game/configuration.dart';
import 'package:flappy_birds/game/flappy_bird_game.dart';
import 'package:flutter/material.dart';

class Bird extends SpriteGroupComponent<BirdMove>
    with HasGameReference<FlappyBirdGame>, CollisionCallbacks {
  Bird();

  @override
  Future<void> onLoad() async {
    final birdMidFlap = await game.loadSprite(Assets.birdMid);
    final birdUpFlap = await game.loadSprite(Assets.birdUp);
    final birdDownFlap = await game.loadSprite(Assets.birdDown);

    size = Vector2(50, 40);
    position = Vector2(50, game.size.y / 2 - size.y / 2);
    sprites = {
      BirdMove.middle: birdMidFlap,
      BirdMove.up: birdUpFlap,
      BirdMove.down: birdDownFlap,
    };
    current = BirdMove.middle;
    add(CircleHitbox());
  }

  void fly() {
    add(
      MoveByEffect(
        Vector2(0, Configuration.gravity),
        EffectController(duration: 0.2, curve: Curves.decelerate),
        onComplete: () => current = BirdMove.down,
      ),
    );
    current = BirdMove.up;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    gameOver();
  }

  //reset
  void reset() {
    position = Vector2(50, game.size.y / 2 - size.y / 2);
    game.children.whereType<PipeGroup>().forEach((pipe) {
      pipe.removeFromParent();
    });
  }

  void gameOver() {
    game.overlays.add('gameOver');
    game.pauseEngine();
    game.isHit = true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += Configuration.birdVelocity * dt;
  }
}
