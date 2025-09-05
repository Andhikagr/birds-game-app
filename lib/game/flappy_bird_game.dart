import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_birds/component/background.dart';
import 'package:flappy_birds/component/bird.dart';
import 'package:flappy_birds/component/base.dart';
import 'package:flappy_birds/component/pipe_group.dart';
import 'package:flappy_birds/game/configuration.dart';
import 'package:flame/components.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  FlappyBirdGame();

  late Bird bird;
  Timer interval = Timer(Configuration.pipeInterval, repeat: true);
  bool isHit = false;

  @override
  Future<void> onLoad() async {
    addAll([Background(), Base(), bird = Bird(), PipeGroup()]);
    interval.onTick = () => add(PipeGroup());
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);
  }

  @override
  void onTap() {
    super.onTap();
    bird.fly();
  }
}
