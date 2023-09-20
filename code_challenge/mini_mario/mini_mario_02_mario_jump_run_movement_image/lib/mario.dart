import 'package:flutter/material.dart';
import 'package:mini_mario/game_page.dart';

class Mario extends StatelessWidget {
  const Mario({
    super.key,
    required this.direction,
    required this.isJumping,
    required this.isRunning,
    required this.isIdle,
  });

  final Direction direction;
  final bool isJumping;
  final bool isRunning;
  final bool isIdle;

  @override
  Widget build(BuildContext context) {
    const marioSize = 50.0;

    late final String imgPath;
    final leftOrRight = direction == Direction.left ? 'l' : 'r';
    if (isJumping) {
      imgPath = 'assets/images/mario_jump_$leftOrRight.png';
    } else if (isIdle) {
      imgPath = 'assets/images/mario_idle_$leftOrRight.png';
    } else if (isRunning) {
      imgPath = 'assets/images/mario_run1_$leftOrRight.png';
    } else {
      imgPath = 'assets/images/mario_run2_$leftOrRight.png';
    }

    return Image.asset(
      imgPath,
      width: marioSize,
      height: marioSize,
    );
  }
}
