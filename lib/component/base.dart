import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:flappy_birds/game/assets.dart';
import 'package:flappy_birds/game/configuration.dart';
import 'package:flappy_birds/game/flappy_bird_game.dart';

class Base extends ParallaxComponent<FlappyBirdGame> {
  Base();

  @override
  Future<void> onLoad() async {
    final base = await Flame.images.load(Assets.base);
    parallax = Parallax([
      ParallaxLayer(ParallaxImage(base, fill: LayerFill.none)),
    ]);

    add(
      RectangleHitbox(
        position: Vector2(0, game.size.y - Configuration.baseHeight),
        size: Vector2(game.size.x, Configuration.baseHeight),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    parallax?.baseVelocity.x = Configuration.gameSpeed;
  }
}
